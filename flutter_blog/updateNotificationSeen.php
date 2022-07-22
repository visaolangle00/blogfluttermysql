

<?php
	 $db = mysqli_connect("localhost","root","","flutter_blog");
	 if(!$db){
		 echo "Database connect error".mysqli_error();
	 }
	 
	$id=$_POST['id'];
	$db->query("UPDATE comments SET isSeen =1 Where id='$id'");
	
	 
?>