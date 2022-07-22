import 'package:blogfluttermysql/components/TopPostCard.dart';
import 'package:blogfluttermysql/page/ContactUs.dart';
import 'package:blogfluttermysql/page/aboutUs.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'components/CategoryListItem.dart';
import 'components/RecentPostItem.dart';

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
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var curdate = DateFormat("d MMMM y").format(DateTime.now());

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
                  backgroundColor:Colors.white ,
                  child: Icon(Icons.person),
                ),
              ),
              accountName: Text('Shawon'),
              accountEmail: Text("Shawon@gmail.com"),
            ),
            ListTile(
              onTap: (){
                debugPrint("Home");
              },
              leading: Icon(Icons.home,color: Colors.green,),
              title: Text('Home',style: TextStyle(color: Colors.green),),
            ),
            ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutUs()));
                debugPrint("About Us");
              },
              leading: Icon(Icons.label,color: Colors.grey,),
              title: Text('About Us',style: TextStyle(color: Colors.grey),),
            ),
            ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactUs()));
                debugPrint("Contact Us");
              },
              leading: Icon(Icons.contacts,color: Colors.amber,),
              title: Text('Contact Us',style: TextStyle(color: Colors.amber),),
            ),

            ListTile(
              onTap: (){
                debugPrint("Login");
              },
              leading: Icon(Icons.lock_open,color: Colors.red,),
              title: Text('Login',style: TextStyle(color: Colors.red),),
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
          Container(
            width: 150,
            height: 50,
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
            ),
          )
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
          TopPostCard(),
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
