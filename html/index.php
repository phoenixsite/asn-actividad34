<?php

	$dsn="mysql:host=mariadb;dbname=notesdb";
	$dbuser = $_ENV["DB_USER"];
	$dbpass = $_ENV["DB_PASSWORD"];

	require "./dbutil.php";
	$db = openDBConnection($dsn,$dbuser,$dbpass);

	if ($_SERVER['REQUEST_METHOD'] === 'POST') {
		$query = "INSERT INTO notes (title,text,hidden) VALUES (" .
				"'{$_POST['title']}','{$_POST['text']}',0 );";
		$db->exec($query);
		header("Location: " . $_SERVER['REQUEST_URI']);
		exit();
	}

	$query="SELECT * FROM notes";

	if ( isset($_GET['id']) ) {
		$vmodel['note']= $db->query($query." WHERE id=  {$_GET['id']}")
							->fetch();
		include('views/note.php');
	} else {
		$vmodel['notes'] = $db->query($query);
		include("views/notes.php");
	}

?>
