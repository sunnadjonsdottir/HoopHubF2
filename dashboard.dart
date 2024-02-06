import 'package:HoopHub/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'games_screen.dart';
import 'hoopgpt_screen.dart';
import 'newsfeed_screen.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        childAspectRatio: 1.0,
        children: <Widget>[
          _DashboardItem(
            title: 'Games',
            icon: Icons.sports_basketball,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GamesScreen()),
            ),
          ),
          _DashboardItem(
            title: 'Newsfeed',
            icon: Icons.feed,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewsfeedScreen()),
            ),
          ),
          _DashboardItem(
            title: 'HoopGPT',
            icon: Icons.chat,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HoopGPTScreen()),
            ),
          ),
          _DashboardItem(
            title: 'Settings',
            icon: Icons.settings,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
            },
          ),
        ],
      ),
    );
  }
}

class _DashboardItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _DashboardItem({Key? key, required this.title, required this.icon, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 80.0),
            Text(title, style: TextStyle(fontSize: 20.0)),
          ],
        ),
      ),
    );
  }
}
