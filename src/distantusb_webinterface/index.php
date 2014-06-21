<?php
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Distant-USB Management</title>
	<link rel="stylesheet" type="text/css" href="data/reset.css" />
	<link rel="stylesheet" type="text/css" href="data/main.css" />
</head>

<body>
<div id="wrapper">
	<div id="top" class="clear">
		<img src="./data/picosafe.png" style="margin-top: 25px;">
		<ul>
			<li><a href="index.php">back</a></li>
		</ul>
	</div>

	<div id="body" class="clear">
		<h4>Distant - USB</h4>
		<br>
		<h3>Picosafe hinzuf&uuml;gen</h3>
		<form name="addShare" id="addShare" action="php/addPicosafe.php" method="post">
		<table border="0" cellpadding="0" cellspacing="4">
			<tr>
		      <td align="right">Name des Shares:<td>
		      <td><input id="folder" name="share_name" type="text" size="30" maxlength="30" placeholder="pico_30"></td>
		    </tr>
		    <tr>
		      <td align="right">Benutzeraccount:<td>
		      <td><input id="user" name="user" type="text" size="30" maxlength="30" placeholder="picosafe"></td>
		    </tr>
		    <tr>
		      <td align="right">IP-Adresse:<td>
		      <td><input id="host" name="host" type="text" size="30" maxlength="15" placeholder="172.24.42.1"></td>
		    </tr>
		    <tr>
		      <td align="right">Passwort:<td>
		      <td><input id="password" name="passord" type="password" size="30" maxlength="15"></td>
		    </tr>
		</table>
		<br>
		<center><input type="submit" value="Add" style="height: 25px; width: 8em"></center>
		</form>
		<br>
		<h3>Picosafes entfernen</h3>
		<center>
		<?php
			// first, get the file ...
			$file = file("content/shares.csv");
		
			// now count the lines ...
			$lines = count($file);
		
			// start the table here ...
			echo'<form name="removeShare" id="removeShare" action="php/removePicosafe.php" method="get">
				<table border="0" cellpadding="0" cellspacing="4" style="width:60%">
				<tr>
					<th style="text-align:center; width:10%">Auswahl</th>
					<th style="width:30%">Name</th>
					<th style="width:30%">User</th>
					<th style="width:30%">Host</th>
				</tr>';
				
			// start the loop to get all lines in the table..
			for ($i=0; $i<$lines; $i++) {
				// exlplode it ...
				$parta = explode(',', $file[$i]);
				$partb = explode('@', $parta[1]);
				// now start printing ...
				echo'<tr>
					<td style="text-align:center"><input type="checkbox" name="check_list[]" value="'.$i.'"></td>
					<td >'.$parta[0].'</td>
					<td >'.$partb[0].'</td>
					<td >'.$partb[1].'</td>
				</tr>';
			}
			// close the table
			echo'</table>
				<br>
				<center><input type="submit" value="Remove" style="height: 25px; width: 8em"></center>
				</form>'; 
		?>
		</center>
	</div>

	<div id="footer-right">
		<p>&copy; by Michael Riedel and embedded projects GmbH</p>
	</div>
</div>

</body>
</html>