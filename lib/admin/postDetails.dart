import 'dart:convert';

import 'package:blogfluttermysql/admin/addEditCategory.dart';
import 'package:blogfluttermysql/admin/addEditPost.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostDetails extends StatefulWidget {
  final author;
  PostDetails({this.author});
  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  List post = List();

  Future getAllPost() async {
    var url = "http://192.168.1.3/flutter/blog_flutter/postAll.php";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        post = jsonData;
      });
    }
    print(post);
  }

  @override
  void initState() {
    super.initState();
    getAllPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PostDetails'),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => AddEditPost(
                author: widget.author,
              ),
            ));
          }, icon: Icon(Icons.add),),
        ],
      ),
      body: ListView.builder(
        itemCount: post.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            child: ListTile(
              leading: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => AddEditPost(
                      postList: post, index: index, author: widget.author,
                    ),
                  ));
                },
              ),
              title: Text(post[index]['title']),
              subtitle: Text(
                post[index]['body'],
                maxLines: 2,
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {},
              ),
            ),
          );
        },
      ),
    );
  }
}
