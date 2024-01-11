import 'package:flutter/material.dart';

class Surah {
  final int number;
  final String name;
  final String arabicName;
  final String origin;
  final int verses;

  Surah({
    required this.number,
    required this.name,
    required this.arabicName,
    required this.origin,
    required this.verses,
  });
}

class SurahListScreen extends StatelessWidget {
  final List<Surah> surahList = [
    Surah(number: 1, name: "Al-Fatihah", arabicName: "الفاتحة", origin: "Meccan", verses: 7),
    // ... Add other Surahs here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D046E),
      appBar: AppBar(
        title: Text('Quran App'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.menu),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Search action
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: ListTile(
              tileColor: Color(0xFF44337A),
              title: Text('Last Read', style: TextStyle(color: Colors.white)),
              subtitle: Text('Al-Fatihah - Ayah No.1', style: TextStyle(color: Colors.white70)),
              leading: Icon(Icons.book, color: Colors.white),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: surahList.length,
              itemBuilder: (context, index) {
                final surah = surahList[index];
                return ListTile(
                  tileColor: index % 2 == 0 ? Color(0xFF2D046E) : Color(0xFF44337A),
                  leading: CircleAvatar(
                    child: Text(
                      surah.number.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text(
                    surah.name,
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    '${surah.origin} - ${surah.verses} verses',
                    style: TextStyle(color: Colors.white70),
                  ),
                  trailing: Text(
                    surah.arabicName,
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmarks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedItemColor: Colors.amber[800],
        backgroundColor: Color(0xFF44337A),
      ),
    );
  }
}