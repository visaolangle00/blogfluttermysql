

<?php
	 $db = mysqli_connect("localhost","root","","flutter_blog");
	 if(!$db){
		 echo "Database connect error".mysqli_error();
	 }
	 $username = (isset($_POST['username']) ? $_POST['username'] : '');
	 $password = (isset($_POST['password']) ? $_POST['password'] : '');
	 $name = (isset($_POST['name']) ? $_POST['name'] : '');
	
	$sql1 = "SELECT*FROM login_register WHERE username = '".$username."'";
	$query = mysqli_query($db,$sql1);
	$userdata = array();
	$count = mysqli_num_rows($query);
	if($count == 1){
		echo json_encode("ERROR");
	}else{
		//var_dump($username);
		//var_dump($password);
		$insert = "INSERT INTO `login_register` (`name`,`username`,`password`) VALUES ('$name','$username','$password')";
		$result = mysqli_query($db,$insert);
		if($result){
			$sql2 = "SELECT*FROM `login_register` WHERE username = '$username'";
			$query = mysqli_query($db,$sql2);
			$data = mysqli_fetch_array($query);
			$userdata =$data;
		}
		echo json_encode($userdata);
	}
	
?>