import 'dart:convert';

import 'package:blogfluttermysql/admin/categoryDetails.dart';
import 'package:blogfluttermysql/admin/postDetails.dart';
import 'package:blogfluttermysql/main.dart';
import 'package:blogfluttermysql/network/api.dart';
import 'package:blogfluttermysql/page/Login.dart';
import 'package:blogfluttermysql/page/UnSeenNotificationPage.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:http/http.dart' as http;
import 'package:pie_chart/pie_chart.dart';

class Dashboard extends StatefulWidget {
  final name;
  final username;
  final author;
  Dashboard({this.name = "Guest", this.username = "", this.author});
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isSeen = true;

  bool toggle = false;
  Map<String, double> dataMap = Map();
  List<Color> colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.purple,
    Colors.black,
  ];

  var total;
  Future getTotalUnSeenNotification() async {
    //var url = "http://192.168.1.13/flutter/blog_flutter/selectCommentsNotification.php";
    var response = await http.get(BASEURL.selectCommentsNotification);
    if (response.statusCode == 200) {
      setState(() {
        total = response.body;
      });
    }
    print('total unread comments $total');
  }

  var totalPost;
  Future getTotalPost() async {
    //var url = "http://192.168.1.13/flutter/blog_flutter/totalPost.php";
    var response = await http.get(BASEURL.totalPost);
    if (response.statusCode == 200) {
      setState(() {
        totalPost = response.body;
        //dataMap.addAll({"Post": double.parse(totalPost)});
      });
    }
    print('total Post $totalPost');
  }




  var totalCategory;
  Future getTotalCategory() async {
    //var url = "http://192.168.1.13/flutter/blog_flutter/totalCategory.php";
    var response = await http.get(BASEURL.totalCategory);
    if (response.statusCode == 200) {
      setState(() {
        totalCategory = response.body;
       // dataMap.addAll({"Category": double.parse(totalCategory)});
      });
    }
    print('total Category $totalCategory');
  }

  Future showAllData()async{
    //var url = "http://192.168.1.13/flutter/blog_flutter/getchart.php";
    var response = await http.get(BASEURL.getchart);
    if(response.statusCode==200){
      var jsonData =json.decode(response.body);
      List data= jsonData;
      data.forEach((element) {
        dataMap.addAll({element['name']:double.parse(element['price'])});
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTotalUnSeenNotification();
    getTotalPost();
    getTotalCategory();
    showAllData();

    //dataMap.addAll({"Post":double.parse(totalPost),"Category":double.parse(totalCategory)});



//    dataMap.putIfAbsent("Flutter", () => 5);
//    dataMap.putIfAbsent("React", () => 3);
//    dataMap.putIfAbsent("Xamarin", () => 2);
//    dataMap.putIfAbsent("Ionic", () => 2);
  }

  @override
  Widget build(BuildContext context) {
    Widget menuDrawer() {
      return Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.pinkAccent),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person),
                ),
              ),
              accountName: Text(widget.name),
              accountEmail: Text(widget.username),
            ),
            ListTile(
              onTap: () {
                debugPrint("Home");
              },
              leading: Icon(
                Icons.home,
                color: Colors.green,
              ),
              title: Text(
                'Home',
                style: TextStyle(color: Colors.green),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CategoryDetails()));
                debugPrint("Add Category");
              },
              leading: Icon(
                Icons.label,
                color: Colors.grey,
              ),
              title: Text(
                'Add Category',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PostDetails(
                              author: widget.name,
                            )));
                debugPrint("Add post");
              },
              leading: Icon(
                Icons.contacts,
                color: Colors.blue,
              ),
              title: Text(
                'Add post',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            widget.name == "Guest"
                ? ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                      debugPrint("Login");
                    },
                    leading: Icon(
                      Icons.lock,
                      color: Colors.red,
                    ),
                    title: Text(
                      'Login',
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                : ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage()));
                      debugPrint("Login");
                    },
                    leading: Icon(
                      Icons.lock_open,
                      color: Colors.red,
                    ),
                    title: Text(
                      'Logout',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          isSeen
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UnSeenNotificationPage(),
                        ),
                      ).whenComplete(() => getTotalUnSeenNotification());
                      debugPrint('seen');
                    },
                    child: Badge(
                      badgeContent: Text(
                        '$total',
                        style: TextStyle(color: Colors.white, fontSize: 10.0),
                      ),
                      child: Icon(Icons.notifications_active),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(15),
                  child: InkWell(
                    onTap: () {},
                    child: Badge(
                      badgeContent: Text(
                        '0',
                        style: TextStyle(color: Colors.white),
                      ),
                      child: Icon(Icons.notifications_none),
                    ),
                  ),
                ),
        ],
      ),
      drawer: menuDrawer(),
      body: ListView(
        children: [
          myGridView(),
          // chart section
          Column(
            children: [
              Container(
                child: Center(
                  child: toggle
                      ? PieChart(
                          dataMap: dataMap,
                          legendFontColor: Colors.blueGrey[900],
                          legendFontSize: 14.0,
                          legendFontWeight: FontWeight.w500,
                          animationDuration: Duration(milliseconds: 800),
                          chartLegendSpacing: 32.0,
                          chartRadius: MediaQuery.of(context).size.width / 2.7,
                          showChartValuesInPercentage: true,
                          showChartValues: true,
                          showChartValuesOutside: false,
                          chartValuesColor:
                              Colors.blueGrey[900].withOpacity(0.9),
                          colorList: colorList,
                          showLegends: true,
                          decimalPlaces: 1,
                        )
                      : Text("Press Show to show chart"),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  togglePieChart();
                },
                child: Text('Show'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget myGridView() {
    return SingleChildScrollView(
      child: Container(
        height: 250,
        child: GridView.count(
          crossAxisSpacing: 5,
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          padding: EdgeInsets.all(5),
          children: [
            Container(
              color: Colors.purple,
              child: Center(
                child: Text(
                  "Total Post $totalPost",
                  style: TextStyle(fontSize: 20, fontFamily: 'Rubik'),
                ),
              ),
            ),
            Container(
              color: Colors.green,
              child: Center(
                child: Text(
                  "Total Category $totalCategory",
                  style: TextStyle(
                      fontSize: 20, fontFamily: 'Rubik', color: Colors.white),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  void togglePieChart(){
    setState(() {
      toggle = !toggle;
    });
  }
}
