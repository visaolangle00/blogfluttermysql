import 'dart:convert';

import 'package:blogfluttermysql/components/TopPostCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SelectCategoryBy extends StatefulWidget {
  final categoryName;
  SelectCategoryBy({this.categoryName});
  @override
  _SelectCategoryByState createState() => _SelectCategoryByState();
}

class _SelectCategoryByState extends State<SelectCategoryBy> {
  List categoryByPost = List();

  Future categoryByData() async {
    var url = "http://192.168.1.12/flutter/blog_flutter/categoryByPost.php";
    var response =
        await http.post(url, body: {'category_name': widget.categoryName});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        categoryByPost = jsonData;
      });
      print(response.body);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryByData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: categoryByPost.length,
            itemBuilder: (context, index) {
              return NewPostItem(
                author: categoryByPost[index]['author'],
                body: categoryByPost[index]['body'],
                categoryName: categoryByPost[index]['category_name'],
                comments: categoryByPost[index]['comments'],
                image:
                    'http://192.168.1.12/flutter/blog_flutter/uploads/${categoryByPost[index]['image']}',
                postDate: categoryByPost[index]['post_date'],
                totalLike: categoryByPost[index]['total_like'],
                createDate: categoryByPost[index]['create_date'],
                title: categoryByPost[index]['title'],
              );
            }),
      ),
    );
  }
}
