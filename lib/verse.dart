class Verse {
  final int number;
  final String text;
  final String translation;

  Verse({required this.number, required this.text, required this.translation});

  factory Verse.fromJson(Map<String, dynamic> json) {
    return Verse(
      number: json['number'] ?? 0, // Providing a default value if null
      text: json['text'] ?? '', // Providing an empty string if null
      translation: json['translation'] ?? '', // Providing an empty string if null
    );
  }
}


