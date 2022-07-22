import 'dart:convert';
import 'dart:math';

import 'package:blogfluttermysql/network/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UnSeenNotificationPage extends StatefulWidget {
  @override
  _UnSeenNotificationPageState createState() => _UnSeenNotificationPageState();
}

class _UnSeenNotificationPageState extends State<UnSeenNotificationPage> {
  List allUnSeenNotification = List();

  Future getUnSeenNotification() async {
    //var url = "http://192.168.1.13/flutter/blog_flutter/selectUnSeenNotification.php";
    var response = await http.get(BASEURL.selectUnSeenNotification);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        allUnSeenNotification = jsonData;
      });
    }
    print(allUnSeenNotification);
  }

  Future  updateNotification(String id) async {

    //var url = "http://192.168.1.13/flutter/blog_flutter/updateNotificationSeen.php";
    var response = await http.post(BASEURL.updateNotificationSeen,body:{"id":id});
    if (response.statusCode == 200) {
      print('ok');
    }

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUnSeenNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: ListView.builder(
            itemCount: allUnSeenNotification.length,
            itemBuilder: (context, index) {
              var list = allUnSeenNotification[index];
              return Card(
                color:
                    Colors.primaries[Random().nextInt(Colors.primaries.length)],
                child: ListTile(
                  title: Text(list['comment']),
                  trailing: IconButton(
                    icon: Text(
                      'Read',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                        updateNotification(list['id']).whenComplete(() => getUnSeenNotification());
                    },
                  ),
                ),
              );
            }),
      ),
    );
  }
}
