# Problem 3:

# Creating a new schema
CREATE SCHEMA Cricket;
USE Cricket;

# Question 1:

SELECT player_name FROM player
WHERE country_name = England
ORDER BY player_name ASC
;

# Question 2:

SELECT player_name, TIMESTAMPDIFF(YEAR, DATE(2018-12-02), dob) AS Age
FROM player
WHERE bowling_skill = 'Legbreak googly' AND age >= 28
ORDER BY age DESC, player_name ASC
;

# Question 3:

SELECT match_id, toss-winner FROM match_1
WHERE toss_decision = bat
ORDER BY match_id ASC
;

# Question 4:

SELECT over_id
FROM ball_by_ball
RIGHT JOIN batsman_scored.runs_scored AS runs_scored
ON ball_by_ball.over_id = batsman_scored.over_id
WHERE ball_by_ball.match_id = 335987 AND batsman_scored.runs_scored <= 7
GROUP BY ball_by_ball.over_id
ORDER BY runs DESC, over_id ASC
;

# Question 5:
 
SELECT DISTINCT(player_name)
FROM player
INNER JOIN wicket_taken
ON player.player_id = wicket_taken.player_out AND wicket_taken.kind_out = bowled
;

# Question 6:

SELECT player_name
FROM player
INNER JOIN ball_by_ball ON ball_by_ball.bowler = player.player_id
INNER JOIN batsman_scored.runs_scored AS runs_scored ON  (batsman_scored.match_id = ball_by_ball.match_id AND batsman_scored.over_id = ball_by_ball.over_id AND batsman_scored.ball_id = ball_by_ball.ball_id)
GROUP BY batsman_scored.match_id
ORDER BY runs_scored ASC, player_name ASC LIMIT 1
;

# Question 7:

SELECT player_name
FROM player
INNER JOIN player_match
ON player_match.player_id = player.player_id
INNER JOIN team
ON team.team_id = player_match.team_id
WHERE player_match.role = Captain AND player_match.role = Keeper AND team.team_id = match_1.match_winner
ORDER BY player_name ASC
;

# Question 8:

SELECT player_name 
FROM player
INNER JOIN player_match
ON player_match.player_id = player.player_id
RIGHT JOIN batsman_scored.runs_scored AS runs_scored
ON batsman_scored.match_id = player_match.match_id
WHERE runs_scored >= 50
GROUP BY batsman_scored.match_id
ORDER BY runs_scored DESC, player_name ASC
;

# Question 9:

SELECT player_name 
FROM player
INNER JOIN player_match
ON player_match.player_id = player.player_id
RIGHT JOIN batsman_scored.runs_scored AS runs_scored
ON batsman_scored.match_id = player_match.match_id
INNER JOIN match_1
ON player_match.match_id = match_1.match_id
INNER JOIN team
ON player_match.team_id = team.team_id
WHERE runs_scored >= 100 AND team.team_id != match_1.match_winner
GROUP BY batsman_scored.match_id
ORDER BY runs_scored DESC, player_name ASC
;

# Question 10:

SELECT match_id, venue
FROM match_1
WHERE 
match_1.team_1 = (SELECT team_id FROM team WHERE 'name' = 'Kolkata Knight Riders') 
OR 
match_1.team_2 = (SELECT team_id FROM team WHERE 'name' = 'Kolkata Knight Riders') 
AND 
match_winner != (SELECT team_id FROM team WHERE 'name' = 'Kolkata Knight Riders')
ORDER BY match_id ASC
;

# Question 11:

SELECT player_name
FROM player
INNER JOIN player_match 
ON player_match.player_id = player.player_id
INNER JOIN match_1 
ON match_1.match_id = player_match.match_id
RIGHT JOIN (
SELECT (SUM(runs_scored))/DISTINCT(COUNT(match_id)) AS batting_avg
FROM batsman_scored
)
ON batsman_scored.match_id = match_1.match_id
FROM batsman_scored
WHERE match_1.sesaon_id = 5
ORDER BY player_name ASC LIMIT 10
;


















