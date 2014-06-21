<?php
	function do_alert($msg) {
		echo '<script type="text/javascript">alert("' . $msg . '"); </script>';
	}
	if(array_key_exists('check_list', $_GET) && !empty($_GET['check_list'])) {
		// open the file
		$file = "../content/shares.csv";
		// read into array
		$arr = file($file);
		// find the line to remove
		foreach($_GET['check_list'] as $check) {
			$line = $arr[$check];
			$share = explode(',', $line);
			// remove the line
			unset($arr[$check]);
			// unmount the share
			shell_exec("sshfs_stop.sh " . $share[0]); // TODO: ERROR-HANDLING!!!
		}
		// reindex array
		$arr = array_values($arr);
		// write back to file
		file_put_contents($file, implode($arr));
		header("Location: ../index.php");
		exit;
	} else {
		do_alert("Keine Auswahl getroffen!");
	}
?>