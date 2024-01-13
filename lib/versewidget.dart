import 'package:flutter/material.dart';
import 'verse.dart';

class VerseWidget extends StatefulWidget {
  final Verse verse;

  const VerseWidget({Key? key, required this.verse}) : super(key: key);

  @override
  _VerseWidgetState createState() => _VerseWidgetState();
}

class _VerseWidgetState extends State<VerseWidget> {
  bool isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toggleExpanded,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                child: Text(widget.verse.number.toString()),
              ),
              title: Text(widget.verse.text),
            ),
            Visibility(
              visible: isExpanded,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.verse.translation),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
