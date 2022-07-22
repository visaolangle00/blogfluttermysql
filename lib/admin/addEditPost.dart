import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class AddEditPost extends StatefulWidget {
  final postList;
  final index;
  final author;
  AddEditPost({this.postList, this.index, this.author});
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

  Future addEditPost() async {
    if (editMode) {
      var uri =
          Uri.parse("http://192.168.1.13/flutter/blog_flutter/updatePost.php");
      var request = http.MultipartRequest("POST", uri);
      request.fields['id'] = widget.postList[widget.index]['id'];
      request.fields['title'] = title.text;
      request.fields['body'] = body.text;
      request.fields['author'] = widget.author;
      print(widget.author);
      request.fields['category_name'] = selectedCategory;

      var pic = await http.MultipartFile.fromPath('image', _image.path,
          filename: _image.path);
      request.files.add(pic);

      var response = await request.send();

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Post Update Successful');
        Navigator.pop(context);
        print(title.text);
      }
    } else {
      var uri =
          Uri.parse("http://192.168.1.13/flutter/blog_flutter/addPost.php");
      var request = http.MultipartRequest("POST", uri);
      request.fields['title'] = title.text;
      request.fields['body'] = body.text;
      request.fields['author'] = widget.author;
      print(widget.author);
      request.fields['category_name'] = selectedCategory;

      var pic = await http.MultipartFile.fromPath('image', _image.path,
          filename: _image.path);
      request.files.add(pic);

      var response = await request.send();

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Post Update Successful', fontSize: 25);
        Navigator.pop(context);
        print(title.text);
      }
    }
  }

  Future getAllCategory() async {
    var url = "http://192.168.1.13/flutter/blog_flutter/CategoryAll.php";
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
      selectedCategory = widget.postList[widget.index]['category_name'];
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
          editMode
              ? Container(
                  child: Image.network(
                      'http://192.168.1.13/flutter/blog_flutter/uploads/${widget.postList[widget.index]['image']}'),
                  width: 100,
                  height: 100,
                )
              : Text(''),
          SizedBox(
            height: 20,
          ),
          Container(
            child: _image == null
                ? Center(child: Text('No Image Selected'))
                : Image.file(_image),
            width: 100,
            height: 100,
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton(
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
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              child: Text('Save Post'),
              onPressed: () {
                addEditPost();
              },
            ),
          ),
        ],
      ),
    );
  }
}
