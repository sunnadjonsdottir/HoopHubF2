import 'package:flutter/material.dart';
import 'screens/dashboard.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basketball App',
      theme: ThemeData(
        primaryColor: Color(0xFFD10B0B),

        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color(0xFFFB5C0F),
        ),
        scaffoldBackgroundColor: Color(0xFF747474),
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black),
        ),

      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HoopHub'),
      ),
      body: Center(
        child: Text('Sign in or sign up to personalise your app experience, save your preferences and unlock access to live NBA game updates, news feed and a dedicated ChatGPT feature for comprehensive NBA insights and discussions.'),
      ),
    );
  }
}