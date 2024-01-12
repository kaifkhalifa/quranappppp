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
  if (json['number'] == null || json['name'] == null || json['englishName'] == null || json['ayahs'] == null) {
    throw Exception('Invalid JSON data for SurahDetail');
  }

  List<Verse> verses = (json['ayahs'] as List).map((v) => Verse.fromJson(v)).toList();

  return SurahDetail(
    number: json['number'] ?? 0,
    name: json['name'] ?? '',
    englishName: json['englishName'] ?? '',
    verses: verses,
  );
}
}