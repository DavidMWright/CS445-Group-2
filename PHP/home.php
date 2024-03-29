<?php 
	require_once('basicErrorHandling.php');
	require_once ('connDB.php');
	
	require_once('queryBalance.php');
	require_once('queryUpcomingMatches.php');
	require_once('queryPlayerProfile.php');
	require_once('queryTeam.php');
	require_once('queryWins.php');
	require_once('queryShots.php');
	require_once('queryGoals.php');
	require_once('queryOutcome.php');
	
	session_start();
	
	require_once ('authHelp.php');
	
	$dbh = db_connect();
	
	$upcoming = getUpcoming($dbh);
	
	$winBets = getWins($dbh, $_SESSION['UserID']);
	$shotBets = getShots($dbh, $_SESSION['UserID']);
	$goalBets = getGoals($dbh, $_SESSION['UserID']);
	
	$balance = getBalance($dbh, $_SESSION['UserID']);
?>


<html>
    <head>
        <title>Bet</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>

    <body>
        <header>
					<div class='matches'>
						<form method='post' action='showGameAndRoster.php'>
							<ul>
								<?php  
									foreach($upcoming as $data)
									{
										if($data['FinalScoreHome'] == NULL)
										{
											print '<li><button class="btn btn1" name="teams" type="Submit" Value=' . $data['HomeID'] . ',' . $data['AwayID'] . '>';
											print $data['HomeName'] . ' vs. ' . $data['AwayName'];
											print '</li>';
										}
									}
								?>
							</ul>
						</form>
					</div>
					
					<div class='Logout'>
						<form method='post' action='login.php'>
							<input class='btn btn1' type='Submit' value='Logout'>
						</form>
					</div>
        </header>
				
				<div id='MakeBet'>
					<h2>Place Bet</h2>
					
					<form method='post' action='betPage.php'>
						<p>Choose Bet Type:</p>
						<select Name='BetType'>
							<option Value='win'>Match Winner</option>
							<option Value='mostShots'>Most Shots</option>
							<option Value='mostGoals'>Most Goals</option>
						</select>
						
						<p>Choose Match:</p>
						<select Name='Match'>
							<?php
								foreach($upcoming as $data)
								{
									if($data['FinalScoreHome'] == NULL)
									{
										print '<option Value='. $data['HomeID'] . ',' . $data['AwayID'] . '>';
										print $data['HomeName'] . ' vs. ' . $data['AwayName'];
										print '</option>';
									}
								}
							?>
						</select>
						<br>
						<button class="btn btn1" type="Submit">Go</button>
					</form>
					
					<br>
					
					<h3 class='oneLine'>Current Balance:</h3> <p class='oneLine'>$<?php print $balance[0] ?></p>
					<div class='Login'>
						<form method='post' action='addBalance.php'>
							<p>Add Money:</p>
							<input type='number' name='Amount' min='10'>
							<input class='btn btn1' type='Submit' value='Add'>
						</form>
					</div>
				</div>
				
				<div id='CurrentBets'>
					<h2>Bets Made</h2>
					<ul id='BetList'>
						<?php
							if($winBets != NULL)
							{
								foreach($winBets as $data)
								{
									$teamName = getTeam($dbh, $data['Win']);
									print '<li>' . $data['HomeName'] . ' vs. ' . $data['AwayName'] . '<br>';
									print '$' . $data['Amount'] . ' on ' . $teamName[0]['Name'] . ' Winning<br>';
									
									$outcome = getOutcome($dbh, $data['BetID']);
									if($outcome == NULL)
									{
										print 'Outcome TBD';
									}
									elseif($outcome = 1)
									{
										print 'You Won!';
									}
									else
									{
										print 'You Lost';
									}
									
									print '</li>';
								}
							}
							
							if($shotBets != NULL)
							{
								foreach($shotBets as $data)
								{
									$playerProfile = getPlayerProfile($dbh, $data['Player']);
									print '<li>' . $data['HomeName'] . ' vs. ' . $data['AwayName'] . '<br>'; 
									print '$' . $data['Amount'] . ' on ' . $playerProfile[0]['FName'] . ' ' . $playerProfile[0]['LName'] . ' (Most Shots)<br>';
									
									$outcome = getOutcome($dbh, $data['BetID']);
									if($outcome == NULL)
									{
										print 'Outcome TBD';
									}
									elseif($outcome = 1)
									{
										print 'You Won!';
									}
									else
									{
										print 'You Lost';
									}
									
									print '</li>';
								}
							}
							
							if($goalBets != NULL)
							{
								foreach($goalBets as $data)
								{
									$playerProfile = getPlayerProfile($dbh, $data['Player']);
									print '<li>' . $data['HomeName'] . ' vs. ' . $data['AwayName'] . '<br>'; 
									print '$' . $data['Amount'] . ' on ' . $playerProfile[0]['FName'] . ' ' . $playerProfile[0]['LName'] . ' (Most Goals)<br>';
									
									$outcome = getOutcome($dbh, $data['BetID']);
									if($outcome == NULL)
									{
										print 'Outcome TBD';
									}
									elseif($outcome = 1)
									{
										print 'You Won!';
									}
									else
									{
										print 'You Lost';
									}
									
									print '</li>';
								}
							}
							
						?>
					</ul>
				</div>
				
        <footer>
					
        </footer>
    </body>
</html>

<?php
	db_close($dbh);
?>