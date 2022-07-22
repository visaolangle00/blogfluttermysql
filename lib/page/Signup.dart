import 'dart:convert';

import 'package:blogfluttermysql/admin/Dashboard.dart';
import 'package:blogfluttermysql/main.dart';
import 'package:blogfluttermysql/page/Login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController name = TextEditingController();

  Future signUp() async {
    var url = "http://192.168.1.13/flutter/blog_flutter/register.php";
    var response = await http
        .post(url, body: {"username":user.text, "password":pass.text, "name":name.text});
   // .post(url, body: {"username":"testest", "password":"123"});
    if (response.statusCode == 200) {
      var userData = json.decode(response.body.toString());
      print(userData.toString());
      if (userData == "ERROR") {
        showDialog(
          context: (context),
          builder: (context) => AlertDialog(
            title: Text('Message'),
            content: Text('This User already Exit'),
            actions: [
              RaisedButton(color: Colors.red,onPressed: (){
                Navigator.pop(context);
              },child: Text("Cancel"),),
            ],
          ),
        );
      }
      else{
        if(userData['status']== "Admin"){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> Dashboard(
            name: userData['name'],
          ),),);
        }else{
          Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage(name: userData['name'],email: userData['username'],),),);
        }
        showDialog(
          context: (context),
          builder: (context) => AlertDialog(
            title: Text('Message'),
            content: Text('Signup Successfull'),
            actions: [
              RaisedButton(color: Colors.red,onPressed: (){
                Navigator.pop(context);

              },child: Text("Cancel"),),
            ],
          ),
        );
        print(userData);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp'),
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
                'Sign up Here',
                style: TextStyle(fontFamily: 'Rubik', fontSize: 30),
              ),
            ),
          ),
          Positioned(
            top: 150,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(labelText: 'Name'),

                ),
              ),
            ),
          ),
          Positioned(
            top: 230,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: user,
                  decoration: InputDecoration(labelText: 'username'),

                ),
              ),
            ),
          ),
          Positioned(
            top: 310,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: pass,
                  decoration: InputDecoration(labelText: 'password'),
                ),
              ),
            ),
          ),
          Positioned(
            top: 380,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    color: Colors.pink,
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      signUp();
                    },
                  )),
            ),
          ),
          Positioned(
            top: 440,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Or Sign In',
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
                    'Click Me For Sign In',
                    style: TextStyle(color: Colors.grey),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                    debugPrint("Clicked");
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
