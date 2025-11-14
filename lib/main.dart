import 'package:flutter/material.dart';
import 'package:flutter_application_3/home.dart';
import 'package:flutter_application_3/second.dart';

void main() 
{
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