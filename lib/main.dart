import 'package:flutter/material.dart';
import 'surah_list_screen.dart'; // Make sure this file exists and contains the SurahListScreen widget

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quran App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D046E), // Replace with your background color
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Aligns children vertically in the center
          crossAxisAlignment: CrossAxisAlignment.stretch, // Stretches children horizontally to fit the screen width
          children: [
            Spacer(), // Adds a flexible space before the content
            Text(
              'Quran App',
              textAlign: TextAlign.center, // Centers the text horizontally
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Learn Quran and\nRecite once everyday',
              textAlign: TextAlign.center, // Centers the text horizontally
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 32),
            Image.asset('assets/images/logo.png', width: 200, height: 200), // Specify your image size as needed
            Spacer(), // Adds a flexible space after the content before the button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70), // Adjust the horizontal padding to center the button
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SurahListScreen()), // This assumes you have a SurahListScreen widget defined in another file
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFFFD580), // Button background color
                  shape: StadiumBorder(), // Rounded shape of the button
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16), // Padding inside the button
                ),
                child: Text(
                  'Get Started',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 32), // Space after the button
          ],
        ),
      ),
    );
  }
}