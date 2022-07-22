

<?php
	 $db = mysqli_connect("localhost","root","","flutter_blog");
	 if(!$db){
		 echo "Database connect error".mysqli_error();
	 }
	$user_email = (isset($_POST['user_email']) ? $_POST['user_email'] : '');
	 $post_id= $_POST['post_id'];
	 $curDate = date('d/m/Y');
	
	$result = $db->query("SELECT*FROM post_likes WHERE user_email ='$user_email' AND post_id='$post_id'");
	$count= mysqli_num_rows($result);
	if($count==1){
		$sql=$db->query("SELECT*FROM post_table WHERE id = '$post_id'");
		$data=mysqli_fetch_array($sql);
		$sum= $data['total_like']-1;
		$db->query("UPDATE post_table SET total_like='$sum' WHERE id='$post_id'");
		$db->query("DELETE FROM post_likes WHERE user_email = '$user_email' AND post_id='$post_id' ");
	}else{
		$sql= $db->query("SELECT*FROM post_table WHERE id='$post_id'");
		$data=mysqli_fetch_array($sql);
		$sum=$data['total_like']+1;
		$db->query("INSERT INTO post_likes(user_email,post_id,islike,cur_date) VALUES('$user_email','$post_id',1,'$curDate')");
		$db->query("UPDATE post_table SET total_like ='$sum' WHERE id='$post_id'");
	}
	
?>