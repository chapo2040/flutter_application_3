import 'package:flutter/material.dart';
import 'package:flutter_application_3/home.dart';
import 'package:flutter_application_3/second.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_3/firebase_options.dart';

void main() async
{
  debugPrint("initializeApp... ");
  WidgetsFlutterBinding.ensureInitialized();  
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget 
{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return  MaterialApp
    (      
      title: 'Forms UI App',
      debugShowCheckedModeBanner: false,      
      initialRoute: '/',
      routes: 
      {
        "/": (context) => const Home(),
        "/second": (context) => const Second(),        
      },
    );     
  }
}