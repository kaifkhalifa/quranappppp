import 'package:flutter/material.dart';
import 'surah.dart';
import 'quran_service.dart';
import 'surah_detail_screen.dart';
import 'surah_detail.dart';

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

  void _showFutureFeatureMessage() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Feature Coming Soon'),
        content: Text('This feature will be available in future versions of the app'),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
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
              // Placeholder for your featured Surah card and TabBar...
              // Implement your featured Surah card and TabBar here as per your design...

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
                      title: Stack(
                        children: <Widget>[
                          // Stroked text at the back
                          Text(
                            surah.englishName,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 0 // Adjust the stroke width as needed
                                ..color = Colors.black,
                            ),
                          ),
                          // Solid text at the front
                          Text(
                            surah.englishName,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Text(
                        '${surah.revelationType} - ${surah.numberOfAyahs} verses',
                        style: TextStyle(color: Colors.black),
                      ),
                      onTap: () async {
                        // Your onTap functionality...
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
                          // Handle error, perhaps show an error dialog
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
        onTap: (index) {
          if (index == 1 || index == 2 || index == 3) {
            _showFutureFeatureMessage();
          } else {
            // Handle navigation for the first item, if needed
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Surah'),
          BottomNavigationBarItem(icon: Icon(Icons.layers), label: 'Para'),
          BottomNavigationBarItem(icon: Icon(Icons.pages), label: 'Page'),
          BottomNavigationBarItem(icon: Icon(Icons.headset), label: 'Hijb'),
        ],
      ),
    );
  }
}
