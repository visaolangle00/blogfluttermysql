import 'dart:convert';

import 'package:blogfluttermysql/admin/addEditCategory.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryDetails extends StatefulWidget {
  @override
  _CategoryDetailsState createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  List category = List();

  Future getAllCategory() async {
    var url = "http://192.168.1.12/flutter/blog_flutter/CategoryAll.php";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        category = jsonData;
      });
    }
    print(category);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Details'),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => AddEditCategory(),
            ));
          }, icon: Icon(Icons.add),)
        ],
      ),
      body: ListView.builder(
          itemCount: category.length,
          itemBuilder: (context, index) {
        return Card(
          elevation: 2,
          child: ListTile(
            leading: IconButton(
              onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context)=> AddEditCategory(
                   categoryList: category,index: index
                 ) ));
              },
              icon: Icon(Icons.edit),
            ),
            title: Text(category[index]['name']),
            trailing: IconButton(onPressed: () async{
              var url = "http://192.168.1.12/flutter/blog_flutter/deleteCategory.php";
              var response = await http.post(url, body:{"id":category[index]['id']});
              if(response.statusCode ==200){
               showDialog(context: (context), builder: (context) => AlertDialog(
                 title: Text('Message'),
                 content: Text('Category Deleted Successful'),
                 actions: [
                   RaisedButton(
                     color: Colors.red,
                     onPressed: (){
                       Navigator.pop(context);
                     },
                     child: Text("Cancel"),
                   ),
                 ],
               ));
              }
            }, icon: Icon(Icons.delete),),
          ),
        );
      }),
    );
  }
}
