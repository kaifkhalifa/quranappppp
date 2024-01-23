import 'dart:convert';
import 'package:flutter/material.dart';

class DuasListItem {
  final String arabic;
  final String english;

  DuasListItem({
    required this.arabic,
    required this.english,
  });
}

class DuasScreen extends StatefulWidget {
  @override
  _DuasScreenState createState() => _DuasScreenState();
}

class _DuasScreenState extends State<DuasScreen> {
  List<DuasListItem> duasList = [];

  @override
  void initState() {
    super.initState();
    loadDuas(); // Load the duas when the screen initializes
  }

  Future<void> loadDuas() async {
    final String duasData =
        await DefaultAssetBundle.of(context).loadString('assets/duas.json');
    final List<dynamic> jsonDuas = json.decode(duasData);

    List<DuasListItem> loadedDuasList = [];

    for (var dua in jsonDuas) {
      loadedDuasList.add(
        DuasListItem(
          arabic: dua['arabic'],
          english: dua['english'],
        ),
      );
    }

    setState(() {
      duasList = loadedDuasList; // Update the state with the loaded duas
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Duas From the Quran',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF1B0238),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemCount: duasList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                title: Text(
                  ' ${duasList[index].arabic}',
                  style: TextStyle(fontSize: 27),
                ),
                subtitle: Text(
                  ' ${duasList[index].english}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
