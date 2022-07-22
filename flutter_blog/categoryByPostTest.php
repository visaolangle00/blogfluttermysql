



<?php 
    //$db = mysqli_connect("localhost" ,"root" ,"" ,"flutter_blog" );
	$db = new mysqli("localhost", "root","","flutter_blog");
	if($db->connect_error){
		die("Connection failed: " .$db->connect_error);
	}
	
	 $category_name = (isset($_POST['category_name']) ? $_POST['category_name'] : '');
	
	$stmt = $db->prepare("SELECT id, image, author, post_date, comments, total_like, title, body, category_name, create_date FROM post_table WHERE category_name=?");
	$stmt->bind_param("s", isset($_POST['category_name']) ? $_POST['category_name'] : '');
	//$stmt->bind_param("s",$category_name);
	$stmt->execute();
	$stmt->bind_result($row_id, $row_image, $row_author, $row_post_date, $row_comments, $row_total_like, $row_title, $row_body, $row_category_name, $row_create_date);
	if($result->num_rows > 0) {
		while($row = $result->fetch_assoc()) {
 
	
	$id[]=$row_id;
	$image[]=$row_image;
	$author[]=$row_post_date;
	$post_date[]=$row_post_date;
	$comments[]=$row_comments;
	$total_like[]=$row_total_like;
	$title[]=$row_title;
	$body[]=$row_body;
	$category_name[]=$row_category_name;
	$create_date[]=$create_date;

  }
}
	$stmt->close();
	echo $id;
	echo $image;
	echo $author;
	echo $post_date;
	echo $comments;
	echo $total_like;
	echo $title;
	echo $body;
	echo $category_name;
	echo $create_date;

$db->close();
?>

