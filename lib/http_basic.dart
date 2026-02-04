import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> fetchData() async {
  final response =
      //await http.get(Uri.parse('https://itpart.net/mobile/api/product0xx.php'));
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));

  if (response.statusCode == 200) {
    final jSONbody = json.decode(response.body);
    String strBody = response.body.toString(); // return from the server
    debugPrint(strBody);

    return strBody; //ตอนยังไม่แปลง
    //return jSONbody['title']; //แปลงแล้ว
  } else {
    // throw an exception.
    throw Exception('problem..');
  }
}

class HttpBasic extends StatefulWidget {
  const HttpBasic({super.key});

  @override
  State<HttpBasic> createState() => _HttpBasicState();
}

class _HttpBasicState extends State<HttpBasic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: const Text('HttpBasic Page'),
      ),
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            return Text('${snapshot.data}');
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const Text('No data available!');
        },
      ),
    );
  }
}
