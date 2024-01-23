import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';

class DailyVerse {
  final int id;
  final String arabicText;
  final String englishTranslation;

  DailyVerse({
    required this.id,
    required this.arabicText,
    required this.englishTranslation,
  });
}

class VerseOfTheDayScreen extends StatefulWidget {
  @override
  _VerseOfTheDayScreenState createState() => _VerseOfTheDayScreenState();
}

class _VerseOfTheDayScreenState extends State<VerseOfTheDayScreen> {
  late DailyVerse _dailyVerse;

  @override
  void initState() {
    super.initState();
    // Call a method to fetch a random verse and its translation
    _fetchRandomVerse();
  }

  // Method to fetch a random verse and its translation
  void _fetchRandomVerse() async {
    final versesJson =
        await DefaultAssetBundle.of(context).loadString('assets/verses.json');
    final verses = json.decode(versesJson);

    final random = Random();
    final selectedVerse = verses[random.nextInt(verses.length)];

    setState(() {
      _dailyVerse = DailyVerse(
        id: selectedVerse['id'],
        arabicText: selectedVerse['arabicText'],
        englishTranslation: selectedVerse['englishTranslation'],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'A Verse For You',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF1B0238),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Container(
          width: 400, // Adjust the width as needed
          height: 350, // Set the height of the white bubble
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _dailyVerse.arabicText,
                    style: TextStyle(fontSize: 27),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 25),
                  Text(
                    _dailyVerse.englishTranslation,
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
