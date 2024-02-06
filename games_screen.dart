import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GamesScreen extends StatefulWidget {
  @override
  _GamesScreenState createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  List<dynamic> _games = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchGames();
  }

  Future<void> _fetchGames() async {
    final apiKey = dotenv.env['BASKETBALL_API_KEY'];
    final date = '2019-11-26';
    final url = Uri.parse('https://api-basketball.p.rapidapi.com/games?date=$date');

    try {
      final response = await http.get(url, headers: {
        'X-RapidAPI-Key': apiKey!,
        'X-RapidAPI-Host': 'api-basketball.p.rapidapi.com',
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _games = data['response'];
          _isLoading = false;
        });
      } else {

        print('Failed to load games. Status code: ${response.statusCode}');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {

      print('Error fetching games: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NBA Games'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _games.length,
        itemBuilder: (context, index) {
          final game = _games[index];

          return ListTile(
            title: Text('${game['teams']['home']['name']} vs ${game['teams']['away']['name']}'),
            subtitle: Text('Date: ${game['date']}, Time: ${game['time']}'),
          );
        },
      ),
    );
  }
}


