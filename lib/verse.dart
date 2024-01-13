class Verse {
  final int number;
  final int sura;
  final String text;
  final String translation;

  Verse({
    required this.number,
    required this.sura,
    required this.text,
    this.translation = "",
  });

  factory Verse.fromJson(int sura, Map<String, dynamic> json) {
    return Verse(
      number: json['numberInSurah'] ?? 0,
      sura: sura,
      text: json['text'] ?? '',
      translation: json['translation'] ?? '',
    );
  }
}


