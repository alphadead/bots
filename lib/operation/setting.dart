import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _lights = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  "Settings",
                  style: TextStyle(fontSize: 22),
                ),
                SizedBox(
                  width: 12,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              child: Container(
                height: 60,
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.account_box),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Profile',
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                height: 60,
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.settings),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Theme',
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                height: 60,
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.android),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Bots',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      width: 195,
                    ),
                    CupertinoSwitch(
                      value: _lights,
                      onChanged: (bool value) {
                        setState(() {
                          _lights = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                height: 60,
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.exit_to_app),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'logout',
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
