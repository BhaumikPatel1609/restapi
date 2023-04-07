import 'dart:convert';

import 'package:flutter/material.dart';

import 'Modal/ArrayModal.dart';
import 'package:http/http.dart' as http;


class ExampleThree extends StatefulWidget {
  const ExampleThree({Key? key}) : super(key: key);

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {
List<ArrayModal> userList=[];


Future<List<ArrayModal>> getUserApi ()async{
  final response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
var data =jsonDecode(response.body.toString());

  if(response.statusCode==200){

    for(Map<String, dynamic> i in data){
      print(i['name']);
      userList.add(ArrayModal.fromJson(i));
    }
    return userList;
  }
  else{
    return userList;
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(''),),
      body: Column(
        children: [
          Expanded(child: FutureBuilder(
            future: getUserApi(),
            builder: (context,AsyncSnapshot<List<ArrayModal>> snapshort){

              if(!snapshort.hasData){
                return CircularProgressIndicator();
              }else{
                return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context,index){
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Reusable(title: "Name", value: snapshort.data![index].name.toString()),
                          Reusable(title: "UserName", value: snapshort.data![index].username.toString()),
                          Reusable(title: "Email", value: snapshort.data![index].email.toString()),
                          Reusable(title: "Address", value: snapshort.data![index].address!.geo!.lat.toString()),

                        ],
                      ),
                    ),
                  );
                });
              }

            },
          ))
        ],
      ),
    );
  }
}

class Reusable extends StatelessWidget {
  String title,value;
   Reusable({Key? key,required this.title,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
