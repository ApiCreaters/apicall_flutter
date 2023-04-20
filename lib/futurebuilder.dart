import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FB extends StatefulWidget {
   FB({Key? key}) : super(key: key);
  @override
  State<FB> createState() => _FBState();
}

class _FBState extends State<FB> {
    Future<bool> futureBuild() async {
      await Future.delayed(Duration(seconds: 2));
      return true;
    }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(onPressed: (){
          futureBuild();
          setState(() {

          });
        }, child: Text("Click")),
        FutureBuilder(
          future: futureBuild(),
            builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return CircularProgressIndicator();
              }else if(snapshot.connectionState == ConnectionState.done || snapshot.connectionState ==ConnectionState.active){
                if(snapshot.hasError){
                  return Text(snapshot.error.toString());
                }else if(snapshot.hasData){
                  return Text(snapshot.data.toString());
                }else {
                  return Text("Nothing...");
                }
              }else {
                return Text("data");
              }
            }
        )
      ],
    );
  }
}
