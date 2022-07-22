import 'package:blogfluttermysql/admin/Dashboard.dart';
import 'package:blogfluttermysql/main.dart';
import 'package:blogfluttermysql/page/Signup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future login() async {
    var url = "http://192.168.1.3/flutter/blog_flutter/login.php";
    var response = await http
        .post(url, body: {"username": user.text, "password": pass.text});
    if (response.statusCode == 200) {
//      var userData = json.decode(response.body);
//      if (userData == "ERROR") {
//        showDialog(
//            context: (context),
//            builder: (context) => AlertDialog(
//                  title: Text('Message'),
//                  content: Text('This User already Exit!'),
//                  actions: [
//                    RaisedButton(
//                      color: Colors.red,
//                      onPressed: () {
//                        Navigator.pop(context);
//                      },
//                      child: Text("Cancel"),
//                    ),
//                  ],
//                ));
//      } else {
//        showDialog(context: (context), builder: (context) => AlertDialog(
//          title: Text('Message'),
//          content: Text('Signup Successfull'),
//          actions: [
//            RaisedButton(color: Colors.red, onPressed: (){
//              Navigator.pop(context);
//
//            }, child: Text("Cancel"),),
//          ],
//        ));
//        print(userData);
//      }

      var userData = json.decode(response.body);
      if (userData == "ERROR") {
        showDialog(
          context: (context),
          builder: (context) => AlertDialog(
            title: Text('Message'),
            content: Text('Username and Password invalid'),
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
      } else {
        if(userData['status']== "Admin"){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> Dashboard(
            name:""+ userData['name'],
            username: "XYZ" + userData['username'],
          ),),);
        }else{
          Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage(
            name: userData['name'],
            email: userData['username'],
          ),),);
        }
        showDialog(
          context: (context),
          builder: (context) => AlertDialog(
            title: Text('Message'),
            content: Text('Login Successfull'),
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
       // print(userData);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.grey[100],
          ),
          Positioned(
            top: 100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Login Here',
                style: TextStyle(fontFamily: 'Rubik', fontSize: 30),
              ),
            ),
          ),
          Positioned(
            top: 200,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: user,
                  decoration: InputDecoration(labelText: 'Username'),
                ),
              ),
            ),
          ),
          Positioned(
            top: 270,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: pass,
                  decoration: InputDecoration(labelText: 'Password'),
                ),
              ),
            ),
          ),
          Positioned(
            top: 350,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    color: Colors.pink,
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      login();
                    },
                  )),
            ),
          ),
          Positioned(
            top: 420,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Or Sign Up',
                  style: TextStyle(color: Colors.pink),
                ),
              ),
            ),
          ),
          Positioned(
            top: 480,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text(
                    'Click Me Fỏ Sign Up',
                    style: TextStyle(color: Colors.grey),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUp()));
                   // debugPrint("Clicked");
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
