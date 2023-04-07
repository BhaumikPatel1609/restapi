import 'dart:convert';

import 'package:flutter/material.dart';

import 'Postmodal.dart';
import 'package:http/http.dart' as http;
class HomScreen extends StatefulWidget {
  const HomScreen({Key? key}) : super(key: key);

  @override
  State<HomScreen> createState() => _HomScreenState();
}

class _HomScreenState extends State<HomScreen> {

List<Postman> postList=[];

  Future<List<Postman>> getPostApi() async{
    final resposne=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    var data=jsonDecode(resposne.body.toString());
    if(resposne.statusCode==200){
     for(Map<String,dynamic> i in data){
       postList.add(Postman.fromJson(i));
     }
     return postList;
    }else{
      return postList;

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: FutureBuilder(future: getPostApi(),
                  builder: (context,snapshort){
                  if(!snapshort.hasData){
                    return Text('Loding');
                  }else{
                    return ListView.builder(
                        itemCount: postList.length,
                        itemBuilder: (context,index){
                        return Card(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Title',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),),

                                Text(postList[index].title.toString()),
                                SizedBox(height: 20,),
                                Text('Description',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),),

                                Text(postList[index].body.toString())
                              ],
                            ),
                          ),
                        );
                    });
                  }
                  },
                ),
              )
            ],
          ),
    );
  }
}
