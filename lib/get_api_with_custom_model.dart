import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetApiWithCustomModel extends StatefulWidget {
  const GetApiWithCustomModel({super.key});

  @override
  State<GetApiWithCustomModel> createState() => _GetApiWithCustomModelState();
}

class _GetApiWithCustomModelState extends State<GetApiWithCustomModel> {
  List<Photos> photosList = [];

  Future<List<Photos>> getPhotos() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      photosList.clear();
      for (Map i in data) {
        Photos photos = Photos(title: i['title'], url: i['url'], id: i['id']);
        photosList.add(photos);
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Get Api With Custom Model')),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: getPhotos(),
                  builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
                    return ListView.builder(
                        itemCount: photosList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  snapshot.data![index].url.toString(),
                                  scale: 2),
                            ),
                            subtitle:
                                Text(snapshot.data![index].title.toString()),
                            title: Text(
                              snapshot.data![index].id.toString(),
                            ),
                          );
                        });
                  }))
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
