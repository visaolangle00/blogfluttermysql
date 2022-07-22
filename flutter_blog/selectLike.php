

<?php
	 $db = mysqli_connect("localhost","root","","flutter_blog");
	 if(!$db){
		 echo "Database connect error".mysqli_error();
	 }
	$user_email = (isset($_POST['user_email']) ? $_POST['user_email'] : '');
	$post_id = (isset($_POST['post_id']) ? $_POST['post_id'] : '');
	 $curDate = date('d/m/Y');
	
	$result = $db->query("SELECT*FROM post_likes WHERE user_email ='".$user_email."' AND post_id='".$post_id."' ");
	$count= mysqli_num_rows($result);
	if($count==1){
		echo json_encode("ONE");
	}else{
		echo json_encode("ZERO");
	}
	
?>