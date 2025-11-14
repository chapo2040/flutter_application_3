import 'package:flutter/material.dart';

class Second extends StatefulWidget 
{
  const Second({super.key});
 
  @override
  State<Second> createState() => SecondState();
}

class SecondState extends State<Second> 
{ 
  Future<void> onPressed() async 
  {
    debugPrint("onPressed: Prueba Pasada !");    
    // Navigator.pop(context);
  } 

  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp(
      home: Scaffold
      (
        appBar: AppBar(title: Text("data"),),
        body: Column
        (
          children: <Widget>
          [ 
            Text("Hello World"),
            ElevatedButton(onPressed: onPressed, child: const Text('Regresar')),
          ]
        )
      )
    );
  }
}