import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Your Profile'),
            onTap: () {
              // Code coming soon
            },
          ),
    bool isNotificationsOn = true;

    ListTile(
    title: Text('Turn on/off Notifications'),
    trailing: Switch(
    value: isNotificationsOn,
    onChanged: (newValue) {

    setState(() {
    isNotificationsOn = newValue;
    });


    if (newValue) {

    } else {

    }
    },
    ),
    ),

    ListTile(
            title: Text('Log out'),
            onTap: () {
              // Code coming soon
            },
          ),
        ],
      ),
    );
  }
}

