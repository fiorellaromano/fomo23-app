import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
   );
  runApp(FomoApp());
}

class FomoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FOMO23',
      theme: ThemeData(
       useMaterial3: true,
       primarySwatch: Colors.deepPurple,
       scaffoldBackgroundColor: Colors.transparent,
       textTheme: GoogleFonts.nunitoTextTheme(),
       appBarTheme: AppBarTheme(
         backgroundColor: Colors.deepPurple[900],
         foregroundColor: Colors.white,
         centerTitle: true,
         titleTextStyle: TextStyle(
           fontFamily: 'Modak',
           fontSize: 28,
           color: Colors.white,
           ),
         ),
       ),
      home: SplashScreen(),
    );
  }
}
