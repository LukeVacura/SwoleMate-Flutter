import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/subjects.dart';

import 'package:swolemate/models/objects/user.dart';
import 'package:swolemate/models/objects/exercise.dart';
import 'package:swolemate/models/objects/settings.dart';
import 'package:swolemate/models/objects/firebase.dart';



mixin CoreModel on Model {
  List<Exercise> _exercises = [];
  Exercise _exercise;
  bool _isLoading = false;
  //Filter _filter = Filter.Workout;
  User _user;

  bool get isLoading {
    return _isLoading;
  }

  Exercise get currentExercise {
    return _exercise;
  }

  void setCurrentExercise(Exercise exercise) {
    _exercise = exercise;
  }
}

mixin ExercisesModel on CoreModel {
}

mixin UserModel on CoreModel {
  Timer _authTimer;
  PublishSubject<bool> _userSubject = PublishSubject();

  User get user {
    return _user;
  }

  PublishSubject<bool> get userSubject {
    return _userSubject;
  }

  Future<Map<String, dynamic>> authenticate(
      String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> formData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    try {
      final http.Response response = await http.post(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=${Configure.ApiKey}',
        body: json.encode(formData),
        headers: {'Content-Type': 'application/json'},
      );

      final Map<String, dynamic> responseData = json.decode(response.body);
      String message;

      if (responseData.containsKey('idToken')) {
        _user = User(
          id: responseData['localId'],
          email: responseData['email'],
          token: responseData['idToken'],
        );

        setAuthTimeout(int.parse(responseData['expiresIn']));

        final DateTime now = DateTime.now();
        final DateTime expiryTime =
            now.add(Duration(seconds: int.parse(responseData['expiresIn'])));

        final prefs = await SharedPreferences.getInstance();
        prefs.setString('userId', responseData['localId']);
        prefs.setString('email', responseData['email']);
        prefs.setString('token', responseData['idToken']);
        prefs.setString('refreshToken', responseData['refreshToken']);
        prefs.setString('expiryTime', expiryTime.toIso8601String());

        _userSubject.add(true);

        _isLoading = false;
        notifyListeners();

        return {'success': true};
      } else if (responseData['error']['message'] == 'EMAIL_NOT_FOUND') {
        message = 'Email is not found.';
      } else if (responseData['error']['message'] == 'INVALID_PASSWORD') {
        message = 'Password is invalid.';
      } else if (responseData['error']['message'] == 'USER_DISABLED') {
        message = 'The user account has been disabled.';
      }

      _isLoading = false;
      notifyListeners();

      return {
        'success': false,
        'message': message,
      };
    } catch (error) {
      _isLoading = false;
      notifyListeners();

      return {'success': false, 'message': error};
    }
  }

  Future<Map<String, dynamic>> register(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> formData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    try {
      final http.Response response = await http.post(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=${Configure.ApiKey}',
        body: json.encode(formData),
        headers: {'Content-Type': 'application/json'},
      );

      final Map<String, dynamic> responseData = json.decode(response.body);
      String message;

      if (responseData.containsKey('idToken')) {
        _user = User(
          id: responseData['localId'],
          email: responseData['email'],
          token: responseData['idToken'],
        );

        setAuthTimeout(int.parse(responseData['expiresIn']));

        final DateTime now = DateTime.now();
        final DateTime expiryTime =
            now.add(Duration(seconds: int.parse(responseData['expiresIn'])));

        final prefs = await SharedPreferences.getInstance();
        prefs.setString('userId', responseData['localId']);
        prefs.setString('email', responseData['email']);
        prefs.setString('token', responseData['idToken']);
        prefs.setString('refreshToken', responseData['refreshToken']);
        prefs.setString('expiryTime', expiryTime.toIso8601String());

        _userSubject.add(true);

        _isLoading = false;
        notifyListeners();

        return {'success': true};
      } else if (responseData['error']['message'] == 'EMAIL_EXISTS') {
        message = 'Email is already exists.';
      } else if (responseData['error']['message'] == 'OPERATION_NOT_ALLOWED') {
        message = 'Password sign-in is disabled.';
      } else if (responseData['error']['message'] ==
          'TOO_MANY_ATTEMPTS_TRY_LATER') {
        message =
            'We have blocked all requests from this device due to unusual activity. Try again later.';
      }

      _isLoading = false;
      notifyListeners();

      return {
        'success': false,
        'message': message,
      };
    } catch (error) {
      _isLoading = false;
      notifyListeners();

      return {'success': false, 'message': error};
    }
  }

  void logout() async {
    _exercises = [];
    _exercise = null;
    //_filter = Filter.Workout;
    _user = null;

    _authTimer.cancel();

    _userSubject.add(false);

    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void autoAuthentication() async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');

    if (token != null) {
      final String expiryTimeString = prefs.getString('expiryTime');
      final DateTime now = DateTime.now();
      final parsedExpiryTime = DateTime.parse(expiryTimeString);

      if (parsedExpiryTime.isBefore(now)) {
        _user = null;

        return;
      }

      _user = User(
        id: prefs.getString('userId'),
        email: prefs.getString('email'),
        token: token,
      );

      final int tokenLifespan = parsedExpiryTime.difference(now).inSeconds;
      setAuthTimeout(tokenLifespan);

      _userSubject.add(true);
    }
  }

  void tryRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refreshToken');

    final Map<String, dynamic> formData = {
      'grant_type': 'refresh_token',
      'refresh_token': refreshToken
    };

    try {
      final http.Response response = await http.post(
        'https://securetoken.googleapis.com/v1/token?key=${Configure.ApiKey}',
        body: json.encode(formData),
        headers: {'Content-Type': 'application/json'},
      );

      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData.containsKey('id_token')) {
        _user = User(
          id: prefs.getString('userId'),
          email: prefs.getString('email'),
          token: responseData['id_token'],
        );

        setAuthTimeout(int.parse(responseData['expires_in']));

        final DateTime now = DateTime.now();
        final DateTime expiryTime =
            now.add(Duration(seconds: int.parse(responseData['expires_in'])));

        prefs.setString('token', responseData['id_token']);
        prefs.setString('expiryTime', expiryTime.toIso8601String());
        prefs.setString('refreshToken', responseData['refresh_token']);

        print('tryRefreshToken');

        return;
      }
    } catch (error) {}

    logout();
  }

  void setAuthTimeout(int time) {
    _authTimer = Timer(Duration(seconds: time), tryRefreshToken);
  }
}


mixin SettingsModel on CoreModel {
  Settings _settings;
  PublishSubject<bool> _themeSubject = PublishSubject();

  Settings get settings {
    return _settings;
  }

  PublishSubject<bool> get themeSubject {
    return _themeSubject;
  }

  void loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final areUnitsImperial = _loadAreUnitsImperial(prefs);
    final colorSet = _loadCurrentColor(prefs);
    final isDarkThemeUsed = false;

    _settings = Settings(
      isShortcutsEnabled: _loadIsShortcutsEnabled(prefs),
      isDarkThemeUsed: false,
      areUnitsImperial: areUnitsImperial,
      setColor: colorSet,
    );

    _themeSubject.add(isDarkThemeUsed);
  }

  bool _loadIsShortcutsEnabled(SharedPreferences prefs) {
    // return prefs.getKeys().contains('isShortcutsEnabled') &&
    //         prefs.getBool('isShortcutsEnabled')
    //     ? true
    //     : false;
    return true;
  }

  bool _loadIsDarkThemeUsed(SharedPreferences prefs) {
    return prefs.getKeys().contains('isDarkThemeUsed') &&
            prefs.getBool('isDarkThemeUsed')
        ? true
        : false;
  }
  bool _loadAreUnitsImperial(SharedPreferences prefs) {
    return prefs.getKeys().contains('areUnitsImperial') &&
            prefs.getBool('areUnitsImperial')
        ? true
        : false;
  }

  int _loadCurrentColor(SharedPreferences prefs) {
    try{
      return prefs.getInt('setColor');
    }
    catch (Exception){
      prefs.setInt('setColor', 0);
      return 0;
    }
  }

  Future toggleIsShortcutEnabled() async {
    _isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isShortcutsEnabled', !_loadIsShortcutsEnabled(prefs));

    _settings = Settings(
      isShortcutsEnabled: _loadIsShortcutsEnabled(prefs),
      isDarkThemeUsed: _loadIsDarkThemeUsed(prefs),
      areUnitsImperial: _loadAreUnitsImperial(prefs),
      setColor: _loadCurrentColor(prefs),
    );

    _isLoading = false;
    notifyListeners();
  }

  Future toggleIsDarkThemeUsed() async {
    _isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final isDarkThemeUsed = !_loadIsDarkThemeUsed(prefs);
    prefs.setBool('isDarkThemeUsed', isDarkThemeUsed);

    _themeSubject.add(isDarkThemeUsed);

    _settings = Settings(
      isShortcutsEnabled: _loadIsShortcutsEnabled(prefs),
      isDarkThemeUsed: _loadIsDarkThemeUsed(prefs),
      areUnitsImperial: _loadAreUnitsImperial(prefs),
      setColor: _loadCurrentColor(prefs),
    );

    _isLoading = false;
    notifyListeners();
  }

  Future toggleAreUnitsImperial() async {
    _isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final areUnitsImperial = !_loadAreUnitsImperial(prefs);
    prefs.setBool('areUnitsImperial', areUnitsImperial);

    _settings = Settings(
      isShortcutsEnabled: _loadIsShortcutsEnabled(prefs),
      isDarkThemeUsed: _loadIsDarkThemeUsed(prefs),
      areUnitsImperial: _loadAreUnitsImperial(prefs),
      setColor: _loadCurrentColor(prefs),
    );

    _isLoading = false;
    notifyListeners();
  }

  Future toggleColor(int color) async {
    _isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final setColor = color;
    prefs.setInt('setColor', setColor);

    _settings = Settings(
      isShortcutsEnabled: _loadIsShortcutsEnabled(prefs),
      isDarkThemeUsed: _loadIsDarkThemeUsed(prefs),
      areUnitsImperial: _loadAreUnitsImperial(prefs),
      setColor: _loadCurrentColor(prefs),
    );

    _isLoading = false;
    notifyListeners();
  }
}
