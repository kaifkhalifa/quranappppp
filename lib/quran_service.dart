import 'package:http/http.dart' as http;
import 'dart:convert';
import 'surah.dart'; // Import the Surah class
import 'surah_detail.dart'; // Import the SurahDetail class
import 'verse.dart'; // Import the Verse class

// Function to fetch the list of Surahs
Future<List<Surah>> fetchSurahs() async {
  const String url = 'http://api.alquran.cloud/v1/surah';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final List<dynamic> surahsJson = json.decode(response.body)['data'];
    return surahsJson.map<Surah>((json) => Surah.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load Surahs');
  }
}

// Function to fetch the details of a specific Surah
Future<SurahDetail> fetchSurahDetail(int number) async {
  // Fetch the Arabic text.
  final arabicResponse = await http.get(Uri.parse('http://api.alquran.cloud/v1/surah/$number/quran-uthmani'));
  // Fetch the English translation.
  final translationResponse = await http.get(Uri.parse('http://api.alquran.cloud/v1/surah/$number/en.asad'));

  if (arabicResponse.statusCode == 200 && translationResponse.statusCode == 200) {
    final arabicVersesJson = json.decode(arabicResponse.body)['data']['ayahs'];
    final translationVersesJson = json.decode(translationResponse.body)['data']['ayahs'];

    List<Verse> verses = [];
    for (int i = 0; i < arabicVersesJson.length; i++) {
      // Assuming the array lengths are the same and correspond to each other.
      var arabicVerse = arabicVersesJson[i];
      var translationVerse = translationVersesJson[i];

      verses.add(Verse(
        number: arabicVerse['numberInSurah'],
        sura: number,
        text: arabicVerse['text'],
        translation: translationVerse['text'], // Assuming 'text' contains the translation.
      ));
    }

    final surahDetailJson = json.decode(arabicResponse.body)['data'];
    return SurahDetail(
      number: surahDetailJson['number'],
      name: surahDetailJson['name'],
      englishName: surahDetailJson['englishName'],
      verses: verses,
    );
  } else {
    throw Exception('Failed to load Surah detail with Arabic text and translation');
  }
}


// Function to fetch the English translation for a specific verse
Future<String> fetchVerseTranslation(int surahNumber, int verseNumber) async {
  final response = await http.get(Uri.parse('http://api.alquran.cloud/v1/ayah/$surahNumber:$verseNumber/en.asad'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> verseJson = json.decode(response.body)['data'];
    return verseJson['text']; // Assuming 'text' is the key for the translation text
  } else {
    throw Exception('Failed to load translation');
  }
}

// Function to fetch all verses of a Surah with translations
// At the top of your Dart file, you can define a cache map.
// Your existing cache map
Map<int, List<Verse>> versesCache = {};

Future<List<Verse>> fetchVersesWithTranslations(int surahNumber, {int page = 1}) async {
  // Cache key that includes the surah number and the page number
  int cacheKey = surahNumber * 1000 + page; // Example way to create a unique key per page

  // Check if the cache contains the verses already for the specific page.
  if (versesCache.containsKey(cacheKey)) {
    return versesCache[cacheKey]!;
  }

  // Modify this URL to use the pagination feature of your API
  final response = await http.get(Uri.parse('http://api.alquran.cloud/v1/surah/$surahNumber/quran-uthmani?page=$page'));

  if (response.statusCode == 200) {
    final List<dynamic> versesJson = json.decode(response.body)['data']['ayahs'];
    List<Verse> verses = [];

    for (var verseJson in versesJson) {
      // Check if the translation is included in the verseJson
      // If not, then fetch the translation separately.
      String translation = verseJson.containsKey('translation')
          ? verseJson['translation']
          : await fetchVerseTranslation(surahNumber, verseJson['numberInSurah']);
      
      verses.add(Verse.fromJson(
        surahNumber,
        {
          'numberInSurah': verseJson['numberInSurah'],
          'text': verseJson['text'],
          'translation': translation,
        },
      ));
    }

    // After fetching and parsing the verses, add them to the cache
    versesCache[cacheKey] = verses;

    return verses;
  } else {
    throw Exception('Failed to load verses');
  }
}