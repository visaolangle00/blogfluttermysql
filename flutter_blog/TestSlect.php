



<?php 
    //$db = mysqli_connect("localhost" ,"root" ,"" ,"flutter_blog" );
	$db = new mysqli("localhost", "root","","flutter_blog");
	if($db->connect_error){
		die("Connection failed: " .$db->connect_error);
	}
	
	 //$category_name = (isset($_POST['category_name']) ? $_POST['category_name'] : '');
	
	$stmt = $db->prepare("SELECT id, image, author, post_date, comments, total_like, title, body, category_name, create_date FROM post_table WHERE category_name=?");
	$stmt->bind_param("s", $_POST['category_name']);
	//$stmt->bind_param("s",$category_name);
	$stmt->execute();
	$stmt->store_result();
	
	
	if($stmt->num_rows===0) exit('No rows');
	$stmt->bind_result($row_id, $row_image, $row_author, $row_post_date, $row_comments, $row_total_like, $row_title, $row_body, $row_category_name, $row_create_date);
	while($stmt->fetch()){
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
	
	
    var_export($category_name);
	$stmt->close();
	

$db->close();
?>

