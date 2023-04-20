import 'dart:convert';

import 'package:apicall/Complacs%20API/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../futurebuilder.dart';
import '../main.dart';
import '../strem.dart';

class ComplexsApi extends StatefulWidget {
  @override
  State<ComplexsApi> createState() => _ComplexsApiState();
}

class _ComplexsApiState extends State<ComplexsApi> {
  List<WelcomeUser> welcomeUser = [];

  SelectedItem(BuildContext context, int item) {
    switch(item){
      case 0 :
        Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: 'Flutter Demo Home Page')));
        break;
      case 1 :
        Navigator.push(context, MaterialPageRoute(builder: (context) => FB()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => Stremms()));
        break;
    }
  }

  Future<List<WelcomeUser>> getDatas() async {
    final respos = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var datas = jsonDecode(respos.body.toString());
    if (respos.statusCode == 200) {
      print(respos.statusCode);
      for (Map<String, dynamic> index in datas) {
        welcomeUser.add(WelcomeUser.fromJson(index));
      }
      return welcomeUser;
    } else {
      print("object4");
      return welcomeUser;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("aaa"),
        actions: [
          PopupMenuButton<int>(itemBuilder: (context) => [
            PopupMenuItem(
              child: Text("Api Cal"),
              value: 0
            //    Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: 'Flutter Demo Home Page'))),
            ),
            PopupMenuDivider( height: 5),
            PopupMenuItem(
              child: Text("Future Builder"),
              value: 1
            //    Navigator.push(context, MaterialPageRoute(builder: (context) => FB())),
            ),
            PopupMenuItem(
              child: Text("Streams Builder"),
              value: 2
            )
          ],
            onSelected: (item) => SelectedItem(context,item),
          )
        ],
        shadowColor: Colors.yellow,
        toolbarHeight: 70,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(30.0),bottomLeft: Radius.circular(30.0))),
      ),
      body: FutureBuilder(
        future: getDatas(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                itemCount: welcomeUser.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 320,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getTexts(index,'ID: ',welcomeUser[index].id.toString()),
                        getTexts(index,'Name: ',welcomeUser[index].name.toString()),
                        getTexts(index,'Email: ',welcomeUser[index].email.toString()),
                        getTexts(index,'Phone: ',welcomeUser[index].phone.toString()),
                        getTexts(index,'Website: ',welcomeUser[index].website.toString()),
                        getTexts(index,'Company Name: ',welcomeUser[index].company.toString()),
                        getTexts(index,'address->geo->lat: ',welcomeUser[index].address.geo.lat.toString()),
                        getTexts(index,'Address Name: ', '${welcomeUser[index].address.suite.toString()}, '
                            '${welcomeUser[index].address.street.toString()},'
                            '${welcomeUser[index].address.city.toString()} - ${welcomeUser[index].address.zipcode.toString()}'),

                      ],
                    ),
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
  Text getTexts(int index,String name,String content){
    return Text.rich(
        TextSpan(children: [
          TextSpan(text: name,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
          TextSpan(text: content,style: const TextStyle(fontSize: 18)),
        ]),maxLines: 2,
    );
  }

}


//
// IconButton(
// onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: 'Flutter Demo Home Page')));},
// icon: Icon(Icons.api)
// ),