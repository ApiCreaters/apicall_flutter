import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Stremms extends StatefulWidget {
  const Stremms({Key? key}) : super(key: key);

  @override
  State<Stremms> createState() => _StremmsState();
}

class _StremmsState extends State<Stremms> {
  int count = 1;
  StreamController<int> streamController = StreamController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
          stream: streamController.stream,
          builder: (context,snapshot){
            if(snapshot.hasData){
              return Text(snapshot.data.toString());
            }
            else{
              return Text("Null");
            }
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          count ++;
          streamController.sink.add(count);
        },
      ),
    );
  }
}
