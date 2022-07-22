import 'dart:convert';

import 'package:blogfluttermysql/components/TopPostCard.dart';
import 'package:blogfluttermysql/page/ContactUs.dart';
import 'package:blogfluttermysql/page/Login.dart';
import 'package:blogfluttermysql/page/aboutUs.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'components/CategoryListItem.dart';
import 'components/RecentPostItem.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        //primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final name;
  final email;

  MyHomePage({this.name = "Guest", this.email = ""});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var curdate = DateFormat("d MMMM y").format(DateTime.now());

  List searchList = [];

  Future showAllPost() async {
    var url = "http://192.168.1.13/flutter/blog_flutter/postAll.php";
    var response = await http.get(url, headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (var i = 0; i < jsonData.length; i++) {
        searchList.add(jsonData[i]['title']);
      }
      print(searchList);
      //return jsonData;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showAllPost();
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
              accountEmail: Text(widget.email),
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
                    MaterialPageRoute(builder: (context) => AboutUs()));
                debugPrint("About Us");
              },
              leading: Icon(
                Icons.label,
                color: Colors.grey,
              ),
              title: Text(
                'About Us',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ContactUs()));
                debugPrint("Contact Us");
              },
              leading: Icon(
                Icons.contacts,
                color: Colors.amber,
              ),
              title: Text(
                'Contact Us',
                style: TextStyle(color: Colors.amber),
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
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: SearchPost(
                    list: searchList,
                  ));
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      drawer: menuDrawer(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Blogs Today',
              style: TextStyle(fontSize: 25, fontFamily: 'Rubik'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  curdate,
                  style: TextStyle(
                      fontSize: 18, fontFamily: 'Rubick', color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.today),
              ),
            ],
          ),
          TopPostCard(userEmail: widget.email,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              child: Text(
                'Top Categories',
                style: TextStyle(fontSize: 25, fontFamily: 'Rubik'),
              ),
            ),
          ),
          CategoryListItem(),
          RecentPostItem(),
        ],
      ),
    );
  }
}

class SearchPost extends SearchDelegate<String> {
  List<dynamic> list;
  SearchPost({this.list});

  List searchTitle = List();

  Future showAllPost() async {
    var url = "http://192.168.1.13/flutter/blog_flutter/searchPost.php";
    var response = await http.post(url, body: {'title': query});

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return jsonData;
    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
          showSuggestions(context);
        },
        icon: Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: showAllPost(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                var list = snapshot.data[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        list['title'],
                        style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Center(
                        child: Container(
                      child: Image.network(
                        'http://192.168.1.13/flutter/blog_flutter/uploads/${list['image']}',
                        height: 250,
                      ),
                    )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        list['body'] == null ? "" : list['body'],
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "by " + list['author'],
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
                            "Posted on: " + list['post_date'],
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration:
                            InputDecoration(labelText: "Enter Comments"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: MaterialButton(
                          color: Colors.blue,
                          child: Text(
                            'Publish',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                );
              });
        }
        return CircularProgressIndicator();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var listData = query.isEmpty
        ? list
        : list
            .where((element) => element.toLowerCase().contains(query))
            .toList();
    return listData.isEmpty
        ? Center(child: Text('No Data Found'))
        : ListView.builder(
            itemCount: listData.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  query = listData[index];
                  showResults(context);
                },
                title: Text(listData[index]),
              );
            });
  }
}
