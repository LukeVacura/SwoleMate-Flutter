import 'package:flutter/material.dart';
import 'package:swolemate/widgets/ui/custombutton.dart';

class ConfirmDialog {
  static Future<bool> show(BuildContext context, [String title]) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(title != null ? title : 'Are you sure you want to save?'),
          contentPadding: EdgeInsets.all(12.0),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RoundedButton(
                  label: 'No',
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                ),
                SizedBox(
                  width: 20.0,
                ),
                RoundedButton(
                  label: 'Yes',
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
