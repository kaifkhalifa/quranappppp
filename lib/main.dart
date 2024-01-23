import 'package:flutter/material.dart';
import 'surah_list_screen.dart';
import 'verse_of_the_day_screen.dart'; // Import the VerseOfTheDayScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Noble Quran App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color(0xFFFFD580),
        ),
        // Add more theme data here as per your design
      ),
      home: SplashScreen(), // Remove the const keyword here
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _dataLoaded = false; // Added variable to control data loading

  @override
  void initState() {
    super.initState();
    _loadData(); // Load data asynchronously when the splash screen is created
  }

  // Function to preload essential data asynchronously
  Future<void> _loadData() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate a delay (replace with your data loading logic)

    setState(() {
      _dataLoaded = true; // Mark data as loaded
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFF6BACE9),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Spacer(),
            Text(
              'Noble Quran App',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: deviceHeight * 0.04,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: deviceHeight * 0.01),
            Text(
              'Learn Quran &\nRecite Daily',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: deviceHeight * 0.02,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: deviceHeight * 0.05),
            Image.asset('assets/images/logo.png', width: deviceWidth * 0.5, height: deviceHeight * 0.2),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.15),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_dataLoaded) {
                        // Only navigate if data is loaded
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => SurahListScreen()),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFF9B091),
                      shape: StadiumBorder(),
                      padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.08, vertical: deviceHeight * 0.02),
                    ),
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: deviceHeight * 0.02,
                        color: Color(0xFF6BACE9),
                      ),
                    ),
                  ),
                  SizedBox(height: deviceHeight * 0.02),
                  Text(
                    '® kaifkhalifa.com',
                    style: TextStyle(
                      fontSize: deviceHeight * 0.015,
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: deviceHeight * 0.05),
          ],
        ),
      ),
    );
  }
}
