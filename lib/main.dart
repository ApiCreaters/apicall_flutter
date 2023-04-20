import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Complacs API/apicall.dart';
import 'model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: ComplexsApi(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Welcome> welcome = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (context,snapshot) {
            if(snapshot.hasData) {
              return ListView.builder(
                  itemCount: welcome.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 130,
                      color: Colors.greenAccent,
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      margin: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("User Id: ${welcome[index].userId}", style: TextStyle(fontSize: 18),),
                          Text("Id: ${welcome[index].id}", style: TextStyle(fontSize: 18),),
                          Text("Title: ${welcome[index].title}",maxLines: 1, style: TextStyle(fontSize: 18),),
                          Text("Body: ${welcome[index].body}",maxLines: 1, style: TextStyle(fontSize: 18),),
                        ],
                      ),
                    );
                  }
              );
            }
            else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        )
    );
  }

  Future<List<Welcome>> getData() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        welcome.add(Welcome.fromJson(index));
      }
      return welcome;
    } else {
      return welcome;
    }
  }
}
