import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AddEditPost extends StatefulWidget {
  final postList;
  final index;
  AddEditPost({this.postList, this.index});
  @override
  _AddEditPostState createState() => _AddEditPostState();
}

class _AddEditPostState extends State<AddEditPost> {
  File _image;
  final picker = ImagePicker();

  String selectedCategory;
  List categoryItem = List();

  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();

  bool editMode = false;

  Future choiceImage() async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage.path);
    });
  }

  Future addEditPost()async{
    var uri = Uri.parse("http://192.168.1.3/flutter/blog_flutter/addPost.php");
    var request = http.MultipartRequest("POST", uri);
    request.fields['title'] = title.text;
    request.fields['body']=body.text;
    request.fields['category_name']=selectedCategory;

    var pic = await http.MultipartFile.fromPath('image', _image.path,filename: _image.path);
    request.files.add(pic);

    var response = await request.send();

    if(response.statusCode==200){
            print(title.text);
    }
  }

  Future getAllCategory() async {
    var url = "http://192.168.1.3/flutter/blog_flutter/CategoryAll.php";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        categoryItem = jsonData;
      });
    }
    print(categoryItem);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllCategory();
    if (widget.index != null) {
      editMode = true;
      title.text = widget.postList[widget.index]['title'];
      body.text = widget.postList[widget.index]['body'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(editMode ? 'Update' : 'Add '),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: title,
              decoration: InputDecoration(labelText: 'Post Title'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: body,
              maxLines: 4,
              decoration: InputDecoration(labelText: 'Post Body'),
            ),
          ),
          IconButton(
            onPressed: () {
              choiceImage();
            },
            icon: Icon(
              Icons.image,
              size: 50,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child:
                _image == null ? Center(child: Text('No Image Selected')) : Image.file(_image),
            width: 100,
            height: 100,
          ),
          SizedBox(
            height: 20,
          ),
          DropdownButton(
            isExpanded: true,
            value: selectedCategory,
            hint: Text('Select Category'),
            items: categoryItem.map((category) {
              return DropdownMenuItem(
                value: category['name'],
                child: Text(category['name']),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedCategory = newValue;
              });
            },
          ),
          SizedBox(height: 10,),
          RaisedButton(
            child: Text('Save Post'),
            onPressed: () {
              addEditPost();
            },
          ),
        ],
      ),
    );
  }
}
