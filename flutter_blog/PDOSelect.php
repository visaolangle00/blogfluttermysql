



<?php 
    //$db = mysqli_connect("localhost" ,"root" ,"" ,"flutter_blog" );
	
	$connectDetails =[
	  "DBType" => "mysql",
	  "DBhost" => "localhost",
	  "DBName" => "flutter_blog",
	  "DBUser" => "root",
	  "DBPassword" => ""
	];
	//$category_name = (isset($_POST['category_name']) ? $_POST['category_name'] : '');    
	
	$_DB = new PDO(
	  $connectDetails["DBType"].":host=".$connectDetails["DBhost"].";
	  dbname=".$connectDetails["DBName"].";charset=utf8",
	  $connectDetails["DBUser"],
	  $connectDetails["DBPassword"],
	  [
			//PDO::ATTR_EMULATE_PREPARES => false,
			//PDO::ATTR_PERSISTENT => true
	  ]
	);
	
	 //$category_name = (isset($_POST['category_name']) ? $_POST['category_name'] : '');
	
	//$SQL = "SELECT * FROM post_table WHERE category_name = ?";
	//$SQL = "SELECT * FROM post_table WHERE category_name = '".$_POST["category_name"]."'";
	//$SQL = "SELECT * FROM post_table WHERE category_name = '".$_POST["category_name"]."'";
	
	$category_name='Flutter';
	$query = $_DB->prepare("SELECT * FROM post_table WHERE category_name=:category_name");
	$query->bindParam(':category_name',$category_name);
	$query->execute();
	//$query ->execute([$_POST["test"]]);
	
	$results =$query->fetchAll(PDO::FETCH_ASSOC);
	print_r($results);
		
?>

