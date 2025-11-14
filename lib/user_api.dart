import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/user.dart';
import 'package:http/http.dart' as http;

Future<List<user>> fetchUsers() async 
{
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

  if (response.statusCode == 200) 
  {
    List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((json) => user.fromJson(json)).toList();
  } 
  else 
  {
    throw Exception('Failed to load users');
  }
}

Future<int> addUser(user data) async 
{
  try 
  {
    debugPrint("addUser API");    
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/${data.id}'); // Replace with your API endpoint

    var body = jsonEncode(data.toJson());
    http.Response response = await http.post(url, body: body, headers: 
    {
      "Accept": "application/json",
      "content-type": "application/json"
    });      
    
    if (response.statusCode == 200) 
    { 
      debugPrint('Data Insert successfully: ${response.body}');         
      return 1;
    }
    else 
    {
      debugPrint('Failed to insert data. Status code: ${response.statusCode}');    
    }
  } 
  catch (e) 
  {      
    debugPrint(e.toString());
  }

  return 0;
}

Future<int> updateUser(user data) async 
{
  try 
  {
    debugPrint("updateUser API");    
    final url = Uri.parse('https://jsonplaceholder.typicode.com/put/${data.id}'); // Replace with your API endpoint

    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data.toJson()),
    );     
    
    if (response.statusCode == 200) 
    {         
      debugPrint('Data Updated successfully: ${response.body}');      
      return 1;
    }
    else 
    {
      debugPrint('Failed to update data. Status code: ${response.statusCode}');    
    }
  } 
  catch (e) 
  {      
    debugPrint(e.toString());
  }

  return 0;
}

Future<int> deleteUser(int piId) async 
{
  try 
  {
    debugPrint("deleteUser API");  
    final url = Uri.parse('https://jsonplaceholder.typicode.com/delete/$piId'); // Replace with your API endpoint
    
    http.Response response = await http.delete(url, headers: 
    {
      "Accept": "application/json",
      "content-type": "application/json"
    });      
    
    if (response.statusCode == 200) 
    {         
      debugPrint('Data Deleted successfully: ${response.body}');
      return 1;
    }
    else 
    {
      debugPrint('Failed to deleted data. Status code: ${response.statusCode}');    
    }
  } 
  catch (e) 
  {      
    debugPrint(e.toString());
  }

  return 0;
}