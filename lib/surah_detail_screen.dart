import 'package:flutter/material.dart';
import 'surah_detail.dart'; // Your SurahDetail model
import 'verse.dart'; // Your Verse model
import 'versewidget.dart' ;

// A simple widget that might represent a verse of the Surah
class VerseWidget extends StatelessWidget {
  final Verse verse;

  const VerseWidget({Key? key, required this.verse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            child: Text(verse.number.toString()),
          ),
          title: Text(
            verse.text,
            style: TextStyle(
              fontSize: 30, // Increase the font size for the verse text
              // Add other styling as needed
            ),
          ),
          subtitle: Text(
            verse.translation,
            style: TextStyle(
              fontSize: 18, // Increase the font size for the translation
              color: Colors.grey[600], // Optional: Adjust the color if needed
              // Add other styling as needed
            ),
          ),
        ),
      ),
    );
  }
}


class SurahDetailScreen extends StatelessWidget {
  final SurahDetail surahDetail; // Accept SurahDetail object directly

  const SurahDetailScreen({Key? key, required this.surahDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // No need for FutureBuilder, as we're accepting the data directly
    return Scaffold(
      appBar: AppBar(
        title: Text(surahDetail.name), // Display the Surah name in AppBar
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                surahDetail.englishName,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(), // to disable ListView's scrolling
              shrinkWrap: true, // Use this to fit the list into the available space
              itemCount: surahDetail.verses.length,
              itemBuilder: (context, index) {
                return VerseWidget(verse: surahDetail.verses[index]);
              },
            ),
            // ...other widgets displaying details...
          ],
        ),
      ),
    );
  }
}