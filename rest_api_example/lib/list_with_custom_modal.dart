import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PhotoAPI extends StatefulWidget {
  const PhotoAPI({super.key});

  @override
  State<PhotoAPI> createState() => _PhotoAPIState();
}

class _PhotoAPIState extends State<PhotoAPI> {
  List<Photos> photolist = [];
  Future<List<Photos>> getPhotos() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        Photos photos = Photos(
          title: i["title"],
          url: i["url"],
          id: i["id"],
        );
        photolist.add(photos);
      }
      return photolist;
    } else {
      return photolist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Api Calling",
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPhotos(),
                builder: (context, snapshot) {
                  return ListView.builder(itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                        //  NetworkImage(
                        // "https://oaidalleapiprodscus.blob.core.windows.net/private/org-ZTeRIgwolDii4gV9UqcJSP0r/user-oDJUXqoyLFx4IxYl4kEKK3Ax/img-Srbt4woHjwn8TeCn5iKBRJZf.png?st=2023-04-05T11%3A00%3A24Z&se=2023-04-05T13%3A00%3A24Z&sp=r&sv=2021-08-06&sr=b&rscd=inline&rsct=image/png&skoid=6aaadede-4fb3-4698-a8f6-684d7786b067&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2023-04-05T11%3A59%3A39Z&ske=2023-04-06T11%3A59%3A39Z&sks=b&skv=2021-08-06&sig=mv0RFIqFe%2BUcquOmE1jgc/W9D5tjsPi/clNxz4Lj99w%3D"),
                        NetworkImage(snapshot.data![index].url.toString()),
                      ),
                      title: Text("Racipe Name${snapshot.data![index].id}"),
                      subtitle:
                      Text("Discription${snapshot.data![index].title}"),
                    );
                  });
                }),
          )
        ],
      ),
    );
  }
}

class Photos {
  String title, url;
  int id;
  Photos({required this.title, required this.url, required this.id});
}