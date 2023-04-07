import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Modal/product_modal.dart';

class ExampleFour extends StatefulWidget {
  const ExampleFour({Key? key}) : super(key: key);

  @override
  State<ExampleFour> createState() => _ExampleFourState();
}

class _ExampleFourState extends State<ExampleFour> {

  Future<ProductModal> getProductApi() async{

    final response =await http.get(Uri.parse('https://webhook.site/9e57c26e-81c1-4c4b-8c9e-00d405c51d2a'));
var data =jsonDecode(response.body.toString());
    if(response.statusCode==200){
      return ProductModal.fromJson(data);
    }else{
      return ProductModal.fromJson(data);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(child: FutureBuilder<ProductModal>(
              future: getProductApi(),
              builder: (context,snapshort){

                    if(snapshort.hasData){
                      return ListView.builder(
                          itemCount: snapshort.data!.data!.length,
                          itemBuilder: (context,index){
                            return Column(
                              children: [
                                ListTile(
                                  title:Text(snapshort.data!.data![index].shop!.name.toString()) ,
                                  subtitle: Text(snapshort.data!.data![index].shop!.shopemail.toString()),
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(snapshort.data!.data![index].shop!.image.toString()),
                                  ),
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.height * .3,
                                  width: MediaQuery.of(context).size.width *1,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                      itemCount:snapshort.data!.data![index].images!.length,
                                      itemBuilder: (context,position){

                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        height: MediaQuery.of(context).size.height * .25,
                                        width: MediaQuery.of(context).size.width * .5,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(snapshort.data!.data![index].images![position].url.toString())
                                                )
                                              ),

                                      ),
                                    );
                                  }),
                                ),
                                Icon(snapshort.data!.data![index].inWishlist! ==false?Icons.favorite:Icons.favorite_border_outlined)
                              ],

                            );

                          });

                    }else{
                      return Text('Loading');
                    }
              },
            ))
          ],
        ),
      ),
    );
  }
}
