import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class JsonParsing extends StatefulWidget {
  const JsonParsing({Key? key}) : super(key: key);

  @override
  _JsonParsingState createState() => _JsonParsingState();
}

class _JsonParsingState extends State<JsonParsing> {
  late Future data;

  @override
  void initState() {
    super.initState();
    data = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parsing Json'),
      ),
      body: Center(
        child: FutureBuilder(
            future: getData(),
            builder: (
              context,
              AsyncSnapshot snapshot,
            ) {
              if (snapshot.hasData) {
                return createListView(snapshot.data, context);
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }

  Future getData() async {
    var data;
    String Url = "https://jsonplaceholder.typicode.com/posts";
    Network network = Network(Url);

    data = network.fetchData();

    return data;
  }

  Widget createListView(List data, BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, int index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Divider(
                  height: 5,
                ),
                ListTile(
                  title: Text("${data[index]['title']}"),
                  subtitle: Text("${data[index]['body']}"),
                  leading: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        radius: 23,
                        child: Text("${data[index]['userId']}"),
                      )
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }
}

class Network {
  final String url;

  Network(this.url);

  Future fetchData() async {
    print('$url');
    Response response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
