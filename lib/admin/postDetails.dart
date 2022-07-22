import 'dart:convert';

import 'package:blogfluttermysql/admin/addEditCategory.dart';
import 'package:blogfluttermysql/admin/addEditPost.dart';
import 'package:blogfluttermysql/network/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class PostDetails extends StatefulWidget {
  final author;
  PostDetails({this.author});
  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  List post = List();

  Future getAllPost() async {
   // var url = "http://192.168.1.13/flutter/blog_flutter/postAll.php";
    var response = await http.get(BASEURL.postAll);
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
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEditPost(
                      author: widget.author,
                    ),
                  )).whenComplete(() {
                    getAllPost();
              });
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: post.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 2,
              child: ListTile(
                leading: IconButton(
                  icon: Icon(Icons.edit, color: Colors.green,),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddEditPost(
                            postList: post,
                            index: index,
                            author: widget.author,
                          ),
                        )).whenComplete((){
                          getAllPost();
                    });
                  },
                ),
                title: Text(post[index]['title']),
                subtitle: Text(
                  post[index]['body'],
                  maxLines: 2,
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red,),
                  onPressed: () {
                    showDialog(context: (context), builder: (context) => AlertDialog(
                      title: Text('Message'),
                      content: Text('Are You Sure You Want To Delete!'),
                      actions: [
                        RaisedButton(
                          color: Colors.red,
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: Text("Cancel"),
                        ),
                        RaisedButton(
                          color: Colors.green,
                          onPressed: () async{

                            //var url = "http://192.168.1.13/flutter/blog_flutter/deletePost.php";
                            var response = await http.post(BASEURL.deletePost,body:{"id":post[index]['id']});
                            if(response.statusCode ==200){
                              Fluttertoast.showToast(msg: 'Post Update Successful',fontSize: 20);
                              setState(() {
                                getAllPost();
                              });
                              Navigator.pop(context);
                            }
                          },
                          child: Text("Confirm"),
                        ),
                      ],
                    ));
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
