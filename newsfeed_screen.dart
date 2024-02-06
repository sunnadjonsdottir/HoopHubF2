import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsfeedScreen extends StatefulWidget {
  @override
  _NewsfeedScreenState createState() => _NewsfeedScreenState();
}

class _NewsfeedScreenState extends State<NewsfeedScreen> {
  List<dynamic> _news = [];

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    final apiKey = dotenv.env['NEWS_API_KEY'];
    final url = Uri.parse('https://nba-news-today.p.rapidapi.com/news/teams/heat/espn');
    final response = await http.get(url, headers: {
      'x-rapidapi-key': apiKey!,
      'x-rapidapi-host': 'nba-news-today.p.rapidapi.com',
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _news = data['results'];
      });
    } else {
      print('Failed to fetch news');

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NBA Newsfeed'),
      ),
      body: ListView.builder(
        itemCount: _news.length,
        itemBuilder: (context, index) {
          final article = _news[index];
          return ListTile(
            title: Text(article['title']),
            subtitle: Text(article['summary']),
          );
        },
      ),
    );
  }
}
