import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:networking_in_flutter/parsing_json/model/post.dart';

class JsonParsingMap extends StatefulWidget {
  const JsonParsingMap({Key? key}) : super(key: key);

  @override
  _JsonParsingMapState createState() => _JsonParsingMapState();
}

class _JsonParsingMapState extends State<JsonParsingMap> {
  late Future<PostList?> data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Network network = Network("https://jsonplaceholder.typicode.com/posts");
    data = network.loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PODO'),
      ),
      body: Center(
        child: FutureBuilder(
          builder: (context, AsyncSnapshot<PostList?> snapshot) {
            List<Post> allPost;
            if (snapshot.hasData) {
              allPost = snapshot.data!.post;
              return createListView(allPost, context);
            } else {
              return CircularProgressIndicator();
            }
          },
          future: data,
        ),
      ),
    );
  }

  Widget createListView(List<Post> data, BuildContext context) {
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
                  title: Text("${data[index].title}"),
                  subtitle: Text("${data[index].body}"),
                  leading: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        radius: 23,
                        child: Text("${data[index].id}"),
                      )
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class Network {
  final String url;

  Network(this.url);

  Future<PostList?> loadPosts() async {
    final response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      return PostList.fromJson(jsonDecode(response.body));
    } else {
      Exception("error");
    }
  }
}
