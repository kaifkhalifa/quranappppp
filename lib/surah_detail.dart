import 'verse.dart'; // Your Verse model

class SurahDetail {
  final int number;
  final String name;
  final String englishName;
  final List<Verse> verses;

  SurahDetail({
    required this.number,
    required this.name,
    required this.englishName,
    required this.verses,
  });

  factory SurahDetail.fromJson(Map<String, dynamic> json) {
    var surahNumber = json['number']; // Extract the surah number from the JSON
    List<Verse> verses = (json['verses'] as List)
        .map((v) => Verse.fromJson(surahNumber, v)) // Pass the surah number to each Verse
        .toList();

    return SurahDetail(
      number: surahNumber,
      name: json['name'],
      englishName: json['englishName'],
      verses: verses,
    );
  }
}