import 'package:brew_crew_firebase/models/brew.dart';
import 'package:brew_crew_firebase/screens/home/settings_form.dart';
import 'package:brew_crew_firebase/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew_firebase/services/database.dart';
import 'package:brew_crew_firebase/screens/home/brew_list.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    void _showSettingPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
            child: SettingsForm(),
          );
        },
      );
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0,
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person, color: Colors.white),
              label: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings, color: Colors.white),
              label: Text('Settings', style: TextStyle(color: Colors.white)),
              onPressed: () => _showSettingPanel(),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: BrewList(),
        ),
      ),
    );
  }
}
