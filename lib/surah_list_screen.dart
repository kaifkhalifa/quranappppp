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
  List<Surah>? surahs; // Declare a list of Surahs as nullable

  @override
  void initState() {
    super.initState();
    fetchSurahs().then((data) {
      setState(() {
        surahs = data; // Fetch the Surah data and set it to the state variable
      });
    }).catchError((error) {
      // Handle errors here, perhaps by showing a Snackbar with the error message
    });
  }

  @override
  Widget build(BuildContext context) {
    // Check if the surahs are loaded
    if (surahs == null) {
      return Scaffold(
        backgroundColor: Color(0xFF2D046E),
        appBar: AppBar(
          title: const Text('Surah List'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: const Center(child: CircularProgressIndicator()), // Show loading indicator
      );
    } else {
      return Scaffold(
        backgroundColor: Color(0xFF2D046E),
        appBar: AppBar(
          title: const Text('Surah List'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: ListView.builder(
          itemCount: surahs!.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(surahs![index].englishName, style: Theme.of(context).textTheme.bodyText2),
              subtitle: Text('${surahs![index].revelationType} - ${surahs![index].numberOfAyahs} verses', style: Theme.of(context).textTheme.bodyText2),
              onTap: () async {
                try {
                  showDialog(
                    context: context,
                    builder: (context) => const Center(child: CircularProgressIndicator()),
                    barrierDismissible: false,
                  );
                  SurahDetail surahDetail = await fetchSurahDetail(surahs![index].number);
                  Navigator.of(context).pop(); // Dismiss the loading dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SurahDetailScreen(surahDetail: surahDetail),
                    ),
                  );
                } catch (e) {
                  Navigator.of(context).pop(); // Ensure loading dialog is dismissed on error
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
      );
    }
  }
}
