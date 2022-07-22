

<?php
	 $db = mysqli_connect("localhost","root","","flutter_blog");
	 if(!$db){
		 echo "Database connect error".mysqli_error();
	 }
	 
	 $search = $_POST['title'];
	 $list = array();
	 $result = $db->query("SELECT * FROM post_table WHERE title Like '%$search%'");
	 if($result){
		 while($row = $result->fetch_assoc()){
			 $list[]= $row;
		 }
		 echo json_encode($list);
	 }
	 
?>