

<?php
	 $db = mysqli_connect("localhost","root","","flutter_blog");
	 if(!$db){
		 echo "Database connect error".mysqli_error();
	 }
	 
	$result = $db->query("SELECT id FROM post_table");
	$totalValue = mysqli_num_rows($result);
	echo json_encode($totalValue);
	 
?>