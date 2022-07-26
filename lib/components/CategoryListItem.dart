import 'dart:convert';

import 'package:blogfluttermysql/network/api.dart';
import 'package:blogfluttermysql/page/SelectCategoryBy.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryListItem extends StatefulWidget {
  @override
  _CategoryListItemState createState() => _CategoryListItemState();
}

class _CategoryListItemState extends State<CategoryListItem> {
  List categories = List();

  Future getAllCategory() async {
    //var url = "http://192.168.1.13/flutter/blog_flutter/CategoryAll.php";
    var response = await http.get(BASEURL.CategoryAll);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        categories = jsonData;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return CategoryItem(
              categoryName: categories[index]['name'],
            );
          }),
    );
  }
}

class CategoryItem extends StatefulWidget {
  final categoryName;
  CategoryItem({this.categoryName});
  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          child: Text(
            widget.categoryName,
            style: TextStyle(
                color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SelectCategoryBy(
                          categoryName: widget.categoryName,
                        )));
           // debugPrint(widget.categoryName);
          },
        ),
      ),
    );
  }
}
