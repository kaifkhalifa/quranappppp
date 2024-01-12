import 'package:flutter/material.dart';
import 'surah_detail.dart'; // Your SurahDetail model
import 'verse.dart'; // Your Verse model

// A simple widget that might represent a verse of the Surah
class VerseWidget extends StatelessWidget {
  final Verse verse; // Your Verse model

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
          title: Text(verse.text), // The original text of the verse
          subtitle: Text(verse.translation), // Translation of the verse
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
