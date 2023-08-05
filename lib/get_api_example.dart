import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/UsersModel.dart';

class GetApiExampleThree extends StatefulWidget {
  const GetApiExampleThree({super.key});

  @override
  State<GetApiExampleThree> createState() => _GetApiExampleThreeState();
}

class _GetApiExampleThreeState extends State<GetApiExampleThree> {
  List<UsersModel> usersList = [];

  Future<List<UsersModel>> getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        usersList.add(UsersModel.fromJson(i));
      }
      return usersList;
    } else {
      return usersList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GetApiExampleThree'),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: getUserApi(),
                  builder: (context, AsyncSnapshot<List<UsersModel>> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.builder(
                          itemCount: usersList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ReUseAbleRow(
                                        title: 'Name',
                                        value: snapshot.data![index].name
                                            .toString()),
                                    ReUseAbleRow(
                                        title: 'UserName',
                                        value: snapshot.data![index].username
                                            .toString()),
                                    ReUseAbleRow(
                                        title: 'Email',
                                        value: snapshot.data![index].email
                                            .toString()),
                                    ReUseAbleRow(
                                      title: 'Address',
                                      value: "${snapshot.data![index].address!.city} - ${snapshot.data![index].address!.zipcode}",
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  }))
        ],
      ),
    );
  }
}

class ReUseAbleRow extends StatelessWidget {

  String title;
  String value;

  ReUseAbleRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(title), Text(value)],
        ));
  }
}
