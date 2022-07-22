

<?php
	 $db = mysqli_connect("localhost","root","","flutter_blog");
	 if(!$db){
		 echo "Database connect error".mysqli_error();
	 }
	 
	 $id = $_POST['id'];
	  $title=(isset($_POST['title']) ? $_POST['title'] : '');
	   $body=(isset($_POST['body']) ? $_POST['body'] : '');
	 
	 //$title = $_POST['title'];
	 //$body = $_POST['body'];
	 $category_name= $_POST['category_name'];
	 
	 //phan 12
	 /* 
	 $create_date = date('d/m/Y');
	 $author = $_POST['author'];
	 */
	 
	  $create_date = date('d/m/Y');
	 $author = $_POST['author'];
	 
	 
	 $image = $_FILES['image']['name'];
	 $imagePath = "uploads/".$image;
	 
	 $tmp_name = $_FILES['image']['tmp_name'];
	 move_uploaded_file($tmp_name,$imagePath);
	 
	 $db->query("UPDATE post_table SET image ='$image',author='$author',post_date='$create_date',title='$title',body='$body',category_name='$category_name' WHERE id='$id'");
	 
?>