

<?php
	 $db = mysqli_connect("localhost","root","","flutter_blog");
	 if(!$db){
		 echo "Database connect error".mysqli_error();
	 }
	$username = (isset($_POST['username']) ? $_POST['username'] : '');
	 $password = (isset($_POST['password']) ? $_POST['password'] : '');
	 
	 $sql = "SELECT * FROM login_register WHERE username= '".$username."' AND password ='".$password."'";
	 $query = mysqli_query($db,$sql);
	 $userdata = array();
	 $count = mysqli_num_rows($query);
	 if($count ==1){
		 $sql = "SELECT * FROM login_register WHERE username ='".$username."'";
				$query = mysqli_query($db,$sql);
				$data=mysqli_fetch_array($query);
				$userdata= $data;
				echo json_encode($userdata);
	 }else{
		 echo json_encode("ERROR");
	 }
?>