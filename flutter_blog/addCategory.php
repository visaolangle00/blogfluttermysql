



<?php 
    //$db = mysqli_connect("localhost" ,"root" ,"" ,"flutter_blog" );
	$db = new mysqli("localhost", "root","","flutter_blog");
	if($db->connect_error){
		die("Connection failed: " .$db->connect_error);
	}
	
	$name = (isset($_POST['name']) ? $_POST['name'] : '');
	$curDate = date('d/m/Y');
	$db->query("INSERT INTO category(name,create_date) VALUES ('$name','$curDate')");
?>

