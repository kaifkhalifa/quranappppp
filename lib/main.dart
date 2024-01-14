import 'package:flutter/material.dart';
import 'surah_list_screen.dart'; // Ensure this file exists with the SurahListScreen widget

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Noble Quran App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color(0xFFFFD580),
        ),
        // Add more theme data here as per your design
      ),
      home: const SplashScreen(), // This is the splash screen that will be displayed on app launch
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    // Using MediaQuery to get device width and height for responsive sizing
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFF6BACE9), // Blue background color
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Spacer(),
            // App title text
            Text(
              'Noble Quran App',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: deviceHeight * 0.04, // 4% of device height
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: deviceHeight * 0.01), // 1% of device height for spacing
            // Slogan text
            Text(
              'Learn Quran &\nRecite daily',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: deviceHeight * 0.02, // 2% of device height
                color: Colors.white70,
              ),
            ),
            SizedBox(height: deviceHeight * 0.05), // 5% of device height for spacing
            // Logo image
            Image.asset('assets/images/logo.png', width: deviceWidth * 0.5, height: deviceHeight * 0.2),
            Spacer(),
            // Get Started button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.15), // 15% of device width for horizontal padding
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement( // Replace the current screen with the SurahListScreen
                        context,
                        MaterialPageRoute(builder: (context) => const SurahListScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFF9B091), // Button background color
                      shape: StadiumBorder(),
                      padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.08, vertical: deviceHeight * 0.02),
                    ),
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: deviceHeight * 0.02, // 2% of device height for font size
                        color: Color(0xFF6BACE9), // Dark purple text color
                      ),
                    ),
                  ),
                  SizedBox(height: deviceHeight * 0.02), // Add some spacing between the button and the additional text
                  Text(
                    '® kaifkhalifa.com',
                    style: TextStyle(
                      fontSize: deviceHeight * 0.015, // Adjust the font size to make it very small
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: deviceHeight * 0.05), // 5% of device height for bottom spacing
          ],
        ),
      ),
    );
  }
}