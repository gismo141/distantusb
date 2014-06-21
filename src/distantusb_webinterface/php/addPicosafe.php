<?php
	function do_alert($msg) {
		echo '<script type="text/javascript">alert("' . $msg . '"); </script>';
	}
	$file = "../content/shares.csv";
	if (!empty($_POST['share_name']) && !empty($_POST['user']) && !empty($_POST['host']) && !empty($_POST['password'])) {
		// Write share to file ...
		$newHost = $_POST['user'] . "@" . $_POST['host'];
		$newPassword = $_POST['password'];
		$newShare =  $_POST['share_name'] . "," . $newHost . "\n";
		file_put_contents($file, $newShare, FILE_APPEND);
		// ... copy the public ssh-keys to the distant picosafe
		shell_exec("copy_keys.sh " . $newHost . " " . $newPassword);
		// ... and mount the new share
		shell_exec("sshfs_start.sh " . $newShare); // TODO: ERROR-HANDLING!!!
		header("Location: ../index.php");
		exit;
	} else {
		do_alert("Die Eingabe ist fehlerhaft!");
		exit;
	}
?>