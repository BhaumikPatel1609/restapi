import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;


class WithoutModal extends StatefulWidget {
  const WithoutModal({Key? key}) : super(key: key);

  @override
  State<WithoutModal> createState() => _WithoutModalState();
}

class _WithoutModalState extends State<WithoutModal> {


  var data;
  Future<void> getUserApi ()async{
    final response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if(response.statusCode==200){

     data =jsonDecode(response.body.toString());

    }else{


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
            builder: (context, snapshort){

              if(snapshort.connectionState==ConnectionState.waiting){
                return CircularProgressIndicator();
              }else{
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context,index){
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Reusable(title: "Name", value: data[index]['name'].toString()),
                              Reusable(title: "UserName", value: data[index]['username'].toString()),
                              Reusable(title: "Email", value: data[index]['email'].toString()),
                              Reusable(title: "Address", value:data[index]['address']['street'].toString()),

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
