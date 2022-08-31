import 'package:flutter/material.dart';
import 'package:flutter_project_remake/screen/welcome.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Welcome(),
      theme: ThemeData(
          textTheme: GoogleFonts.interTextTheme(
            Theme.of(context).textTheme,
          ),
          primaryColor: Colors.amber.shade800),
      // theme: ThemeData.dark().copyWith(
      //   textTheme: GoogleFonts.interTextTheme(
      //     Theme.of(context).textTheme,
      //   ),
      // ),
    );
  }
}
