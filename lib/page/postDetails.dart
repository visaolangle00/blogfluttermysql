import 'package:blogfluttermysql/page/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class PostDetails extends StatefulWidget {
  final id;
  final title;
  final image;
  final body;
  final author;
  final postDate;
  final userEmail;
  PostDetails({this.id,
        this.title,
      this.image,
      this.body,
      this.author,
      this.postDate,
      this.userEmail =""});

  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  @override
  Widget build(BuildContext context) {
    TextEditingController commentsController = TextEditingController();


    Future addComments() async{
      var url = "http://192.168.1.10/flutter/blog_flutter/addComments.php";
      var response = await http.post(url, body: {
        //"id": widget.categoryList[widget.index]['id'],
        "comment": commentsController.text,
        "user_email": widget.userEmail,
        "post_id":widget.id,
      });
      if(response.statusCode ==200){
        Fluttertoast.showToast(msg: 'Comments Publish Successfull',);
        Navigator.pop(context);
      }
    }


    return Scaffold(
      appBar: AppBar(
        title: Text("Post Details"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.title,
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 22,
            ),
            Container(
              child: Image.network(
                widget.image,
                height: 250,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.body == null ? "" : widget.body,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "by " + widget.author,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Posted on: " + widget.postDate,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Comments Area",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Rubik',
                ),
              ),
            ),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onSubmitted: (value) {
                        commentsController.text = value;
                      },
                      onChanged: (value) {
                        print(widget.userEmail);
                        if (widget.userEmail =="") {
                          showDialog(
                              context: (context),
                              builder: (context) => AlertDialog(
                                    title: Text('Message'),
                                    content: Text('Login First Then Comments'),
                                    actions: [
                                      RaisedButton(
                                        color: Colors.red,
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Login(),
                                            ),
                                          );
                                        },
                                        child: Text("Login"),
                                      ),
                                    ],
                                  ));
                        }
                      },
                      controller: commentsController,
                      decoration: InputDecoration(labelText: 'Enter Cmt'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      color: Colors.blue,
                      child: Text(
                        'Publish',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        addComments();
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
