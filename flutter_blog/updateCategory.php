



<?php 
    //$db = mysqli_connect("localhost" ,"root" ,"" ,"flutter_blog" );
	$db = new mysqli("localhost", "root","","flutter_blog");
	if($db->connect_error){
		die("Connection failed: " .$db->connect_error);
	}
	
	$id = $_POST['id'];
	$name = $_POST['name'];
	$curDate = date('d/m/Y h:i');
	
	
	$db->query("UPDATE category SET name = '$name', create_date = '$curDate' WHERE id= '$id'");
?>

