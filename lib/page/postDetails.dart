import 'dart:convert';

import 'package:blogfluttermysql/network/api.dart';
import 'package:blogfluttermysql/page/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PostDetails extends StatefulWidget {
  final id;
  final title;
  final image;
  final body;
  final author;
  final postDate;
  final userEmail;
  PostDetails(
      {this.id,
      this.title,
      this.image,
      this.body,
      this.author,
      this.postDate,
      this.userEmail = ""});

  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  TextEditingController commentsController = TextEditingController();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  String isLikeOrDislike = "";

  @override
  void initState() {
    super.initState();
    getLikes();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings(
        '@mipmap/ic_launcher'); // flutter logo or own icon
    var ios = IOSInitializationSettings();
    var initilize = InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(initilize,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint("Notification :" + payload);
    }
  }

  Future showNotification() async {
    var android = AndroidNotificationDetails(
        'channelId', 'channelName', 'channelDescription');
    var ios = IOSNotificationDetails();
    var platform = NotificationDetails(android, ios);
    flutterLocalNotificationsPlugin.show(
        0, 'Blog notification', commentsController.text, platform,
        payload: 'some details value');
  }

  Future addLike() async {
    //var url = "http://192.168.1.13/flutter/blog_flutter/addLike.php";
    var response = await http.post(BASEURL.addLike, body: {
      //"id": widget.categoryList[widget.index]['id'],
      "user_email": widget.userEmail,
      "post_id": widget.id,
    });
    if (response.statusCode == 200) {
      print('Thanks');
    }
  }

  Future getLikes() async {
    //var url = "http://192.168.1.13/flutter/blog_flutter/selectLike.php";
    var response = await http.post(BASEURL.selectLike, body: {
      //"id": widget.categoryList[widget.index]['id'],
      "user_email": widget.userEmail,
      "post_id": widget.id,
    });
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        isLikeOrDislike = data;
      });
    }
    print(isLikeOrDislike);
  }

  Future addComments() async {
    //var url = "http://192.168.1.13/flutter/blog_flutter/addComments.php";
    var response = await http.post(BASEURL.addComments, body: {
      //"id": widget.categoryList[widget.index]['id'],
      "comment": commentsController.text,
      "user_email": widget.userEmail,
      "post_id": widget.id,
    });
    if (response.statusCode == 200) {
      showNotification();
      Fluttertoast.showToast(
        msg: 'Comments Publish Successfull',
      );

//      Fluttertoast.showToast(
//        msg: 'Test',
//      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    ratingAlert(String msg) {
      showDialog(
        context: (context),
        builder: (context) => AlertDialog(
          title: Text('Rating Status'),
          content: Text(
            msg,
            style: TextStyle(
              fontSize: 40,
            ),
          ),
          actions: [
            RaisedButton(
              color: Colors.red,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
          ],
        ),
      );
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
            ////////////////////////////
            Container(
              child: Row(
                children: [
                  isLikeOrDislike == "ONE"
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              addLike().whenComplete(() => getLikes());
                            },
                            child: Text(
                              'Unlike',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        )
                      : IconButton(
                          icon: Icon(Icons.thumb_up),
                          color: Colors.green,
                          onPressed: () {
                            if (widget.userEmail == "") {
                              showDialog(
                                context: (context),
                                builder: (context) => AlertDialog(
                                  title: Text('Message'),
                                  content: Text('Login First Then...'),
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
                                ),
                              );
                            } else {
                              addLike().whenComplete(() => getLikes());
                            }
                          },
                        ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.thumb_down),
                  ),
                  InkWell(
                    child: Icon(Icons.share),
                    onTap: () async {
                      await FlutterShare.share(
                        title: widget.title,
                        text: widget.body,
                        linkUrl: 'https://flutter.dv/',
                        chooserTitle: 'Flutter blog share',
                      );
                    },
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  RatingBar.builder(
                    onRatingUpdate: (rating) {
                      rating == 5
                          ? ratingAlert('Love It')
                          : ((rating < 5) && (rating > 3))
                              ? ratingAlert('Its Ok')
                              : ((rating < 4) && (rating > 2))
                                  ? ratingAlert('Dislike It!')
                                  : ratingAlert('Hate It');
                      print(rating);
                    },
                    direction: Axis.horizontal,
                    itemCount: 5,
                    initialRating: 3,
                    itemSize: 30,
                    itemBuilder: (context, index) {
                      switch (index) {
                        case 0:
                          return Icon(
                            Icons.sentiment_very_dissatisfied,
                            color: Colors.red,
                          );
                        case 1:
                          return Icon(
                            Icons.sentiment_dissatisfied,
                            color: Colors.redAccent,
                          );
                        case 2:
                          return Icon(
                            Icons.sentiment_neutral,
                            color: Colors.amber,
                          );
                        case 3:
                          return Icon(
                            Icons.sentiment_satisfied,
                            color: Colors.greenAccent,
                          );
                        case 4:
                          return Icon(
                            Icons.sentiment_very_satisfied,
                            color: Colors.green,
                          );
                      }
                      return null;
                    },
                  ),
                ],
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
                        if (widget.userEmail == "") {
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
