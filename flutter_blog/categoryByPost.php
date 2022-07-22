

<?php
	 $db = mysqli_connect("localhost","root","","flutter_blog");
	 if(!$db){
		 echo "Database connect error".mysqli_error();
	 }
	 //$name = $_POST['name'];
	
	// khong hieu thi data

	 
	 $category_name = (isset($_POST['category_name']) ? $_POST['category_name'] : '');
	  $list = array();
	 //$result=  $db->query("SELECT*FROM post_table WHERE category_name = 'Flutter'");
	 
	 $result=  $db->query("SELECT*FROM post_table WHERE category_name = '". $category_name. "'");
	 
	 if($result){
		 
		  while($row = $result-> fetch_assoc()){
			  $list[] = $row;
		  }
		  echo json_encode($list);

	 }
	 
	 
	 
	
	 
	 
	 
	 
	 
	
	/* 
	 $category_name=(isset($_POST['category_name']) ? $_POST['category_name'] : '');
	 
	 $query ="SELECT id,image,author,post_date,comments,total_like,title,body,category_name,create_date FROM post_table WHERE category_name ='$category_name'";
	 $result=mysqli_query($db,$query);
	 
	 $lists = array();
	 
	 if($result){
		 while($row = mysqli_fetch_array($result)){
			 $list = array(
					"id" => $row['id'],
					"image" => $row['image'],
					"author" => $row['author'],
					"post_date" => $row['post_date'],
					"comments" => $row['comments'],
					"total_like" => $row['total_like'],
					"title"=> $row['title'],
					"body"=>$row['body'],
					"category_name"=>$row['category_name'],
					"create_date"=>$row['create_date']
					
			 );
			 array_push($lists,$list);
		 }
		 echo json_encode(array("lists"=>$lists));
	 }
	 */
	 
	 
?>