import 'package:flutter/material.dart';
import 'surah.dart';
import 'quran_service.dart';
import 'surah_detail_screen.dart';
import 'surah_detail.dart';
import 'verse_of_the_day_screen.dart'; // Import the VerseOfTheDayScreen class


class SurahListScreen extends StatefulWidget {
  const SurahListScreen({Key? key}) : super(key: key);

  @override
  _SurahListScreenState createState() => _SurahListScreenState();
}

class _SurahListScreenState extends State<SurahListScreen> {
  late Future<List<Surah>> futureSurahs;

  @override
  void initState() {
    super.initState();
    futureSurahs = fetchSurahs(); // Call your API fetch function
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Surahs in Quranic Sequence:', style: TextStyle(color: Colors.white)), // App title
        backgroundColor: Color(0xFF1B0238), // AppBar background color
      ),
      body: FutureBuilder<List<Surah>>(
        future: futureSurahs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No Surahs found'));
          }

          // Surah data is loaded
          List<Surah> surahs = snapshot.data!;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('﷽', style: TextStyle(fontSize: 25, color: Colors.white)),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: surahs.length,
                  separatorBuilder: (context, index) => Divider(color: Colors.white30),
                  itemBuilder: (context, index) {
                    final surah = surahs[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white30,
                        child: Text(
                          surah.number.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        surah.englishName,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        '${surah.revelationType} - ${surah.numberOfAyahs} verses',
                        style: TextStyle(color: Colors.black),
                      ),
                      onTap: () async {
                        try {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => const Center(child: CircularProgressIndicator()),
                          );
                          SurahDetail surahDetail = await fetchSurahDetail(surah.number);
                          Navigator.of(context).pop(); // Dismiss the loading dialog
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SurahDetailScreen(surahDetail: surahDetail),
                            ),
                          );
                        } catch (e) {
                          Navigator.of(context).pop(); // Dismiss the loading dialog on error
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Error'),
                              content: Text(e.toString()),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
bottomNavigationBar: BottomNavigationBar(
  backgroundColor: Color(0xFF1B0238),
  unselectedItemColor: Colors.white70,
  selectedItemColor: Colors.white,
  items: [
    BottomNavigationBarItem(
      icon: Icon(Icons.book),
      label: 'Surah',
    ),
    BottomNavigationBarItem(
      icon: IconButton(
        icon: Icon(Icons.star),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VerseOfTheDayScreen()),
          );
        },
      ),
      label: 'Verse For You',
    ),
  ],
  onTap: (index) {
    // Handle other navigation items if needed
  },
),

    );
  }
}