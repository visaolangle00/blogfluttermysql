import 'package:blogfluttermysql/main.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';



class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>  {


  final pages = [
    PageViewModel(
      title: Text('This is Blog Title'),
      body: Text('This is Blog Body'),
      pageColor: Colors.amber,
      titleTextStyle: TextStyle(fontSize: 25, color: Colors.green),
      mainImage: Image.asset('images/1.png'),
    ),
    PageViewModel(
      title: Text('This is Blog Admin Dashboard'),
      body: Text('This is Blog Body Admin Dashboard'),
      pageColor: Colors.purple,
      titleTextStyle: TextStyle(fontSize: 25, color: Colors.green),
      mainImage: Image.asset('images/2.png'),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return IntroViewsFlutter(
        pages,
        showBackButton: true,
        showNextButton: true,
        onTapBackButton: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>MyHomePage(),),);
        },
        pageButtonTextStyles: TextStyle(
          color: Colors.white,

        ),
      );
    });
  }


}
