

<?php
	 $db = mysqli_connect("localhost","root","","flutter_blog");
	 if(!$db){
		 echo "Database connect error".mysqli_error();
	 }
	 
	 $list = array();
	 $result = $db->query("SELECT*FROM charts");
	 if($result){
		 while($row=$result->fetch_assoc()){
			// $list[]=$row;
			$key['name']=$row['name'];
			$key['price']=$row['price'];
			
			array_push($list,$key);
		 }
		 echo json_encode($list);
	 }
	
	 
?>