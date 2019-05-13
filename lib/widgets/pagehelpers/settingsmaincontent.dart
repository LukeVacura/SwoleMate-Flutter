import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:swolemate/models/appmodel.dart';

import 'package:swolemate/widgets/ui/loading.dart';

class SettingsPageContent extends StatefulWidget {
  final AppModel model;

  SettingsPageContent(this.model);

  @override
  State<StatefulWidget> createState() {
    return _SettingsPageContentState();
  }
}

class _SettingsPageContentState extends State<SettingsPageContent> {
  bool isSwitched = true;
  
  Widget _buildSettingsOptions(AppModel model){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        // ListTile(
        //   leading: Switch(
        //     value: isSwitched,
        //     onChanged: (value) {
        //       setState(() {
        //         isSwitched = value;
        //       });
        //     },
        //     activeTrackColor: Colors.lightGreenAccent, 
        //     activeColor: Colors.green,
        //   ),90
        // ),
      ],

    );
  }

  Widget _buildPageContent(AppModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Container(
          color: Colors.black26,
          child:
            _buildSettingsOptions(model),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (BuildContext context, Widget child, AppModel model) {
        Stack stack = Stack(
          children: <Widget>[
            _buildPageContent(model),
          ],
        );

        if (model.isLoading) {
          stack.children.add(LoadingModal());
        }

        return stack;
      },
    );
  }
}
