import 'dart:convert';

import 'package:api_intigration/Models/GetApiModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetApiHome extends StatefulWidget {
  const GetApiHome({super.key});

  @override
  State<GetApiHome> createState() => _GetApiHomeState();
}

class _GetApiHomeState extends State<GetApiHome> {
  List<GetApiModel> postList = [];

  Future<List<GetApiModel>> getApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      postList.clear();
      for (Map i in data) {
        postList.add(GetApiModel.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Get Api Exmple"),
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: getApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Expanded(
                      child: ListView.builder(
                          itemCount: postList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Index : ${postList[index].id}'),
                                  const Text('Title :',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                  Text('${postList[index].title}'),
                                  const Text('Desc :',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                  Text('${postList[index].body}')
                                ],
                              ),
                            );
                          }));
                }
              })
        ],
      ),
    );
  }
}
