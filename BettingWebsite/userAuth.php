<?php
	require_once('basicErrorHandling.php');
	require_once('connDB.php');
	require_once('queryValidUser.php');
	
	session_start();
	
	$dbh = db_connect();
	
	$_SESSION['VALID'] = 0;
	
	if( isset($_POST['txtUser']) && isset($_POST['txtPassword']))
	{
		$userID = $_POST['txtUser'];
		$passwd = $_POST['txtPassword'];
		
		$result = queryValidUser($dbh, $userID, $passwd);
		
		if( 0 != $result )
		{
			$_SESSION['VALID'] = 1;
			$_SESSION['UserID'] = $result;
			header('Location: home.php');
		}
		else
		{
			header('Location: failedLogin.html');
		}
	}
	else
	{
			print 'Post Failed';
	}
?>