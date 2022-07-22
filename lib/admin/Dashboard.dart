
import 'package:blogfluttermysql/admin/categoryDetails.dart';
import 'package:blogfluttermysql/admin/postDetails.dart';
import 'package:blogfluttermysql/main.dart';
import 'package:blogfluttermysql/page/Login.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  final name;
  final username;
  Dashboard({this.name = "Guest",this.username = ""});
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PostDetails()));
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
            widget.name =="Guest"
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyHomePage()));
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
      appBar: AppBar(title: Text('Dashboard'),),
      drawer: menuDrawer(),
      body: Container(),
    );
  }
}
