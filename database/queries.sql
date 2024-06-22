-- 20 Queries for Project Phase 2

-- 1 Get Formation for a specific SquadSummary
SELECT f_name
FROM Formation
JOIN SquadSummary ON Formation.f_id = SquadSummary.f_id
WHERE SquadSummary.s_id = 1;

-- 2 Find Users who have a saved squad with a specfic player position
SELECT DISTINCT Users.u_name
FROM Users
JOIN SavedSquad ON Users.u_id = SavedSquad.u_id
JOIN PlayersInSquad ON SavedSquad.ss_id = PlayersInSquad.ss_id
JOIN Players ON PlayersInSquad.p_id = Players.p_id
WHERE Players.p_position = 'ST';

-- 3 Get Users and SquadSummaries who have highest average rating
SELECT Users.u_name, SquadSummary.s_id, SquadSummary.s_avgRating
FROM Users
JOIN SavedSquad ON Users.u_id = SavedSquad.u_id
JOIN SquadSummary ON SavedSquad.ss_id = SquadSummary.ss_id
WHERE SquadSummary.s_avgRating = (SELECT MAX(s_avgRating) FROM SquadSummary)

-- 4 FInd Users who have a squad saved with a player from a specific nation
SELECT DISTINCT Users.u_name
FROM Users
JOIN SavedSquad ON Users.u_id = SavedSquad.u_id
JOIN PlayersInSquad ON SavedSquad.ss_id = PlayersInSquad.ss_id
JOIN Players ON PlayersInSquad.p_id = Players.p_id
WHERE Players.p_nation = 'Brazil';

-- 5 List Top Nations with the most squad summaries
SELECT s_topNation, COUNT(*) as nation_count
FROM SquadSummary
GROUP BY s_topNation
ORDER BY nation_count DESC;

-- 6 Total Squad Count for each Formation
SELECT Formation.f_name, COUNT(SavedSquad.ss_id) as squad_count
FROM Formation
JOIN SquadSummary ON Formation.f_id = SquadSummary.f_id
JOIN SavedSquad ON SquadSummary.ss_id = SavedSquad.ss_id
GROUP BY Formation.f_name;

-- 7 Get Formation Name from specific SquadSummary
SELECT Formation.f_name
FROM Formation
JOIN SquadSummary ON Formation.f_id = SquadSummary.f_id
WHERE SquadSummary.s_id = 1;

-- 8 Find Players apart of multiple Squads
SELECT p_id, COUNT(DISTINCT ss_id) as squad_count
FROM PlayersInSquad
GROUP BY p_id
HAVING squad_count > 1;

-- 9 Count number of Players in each SquadSummary
SELECT ss_id, COUNT(p_id) as player_count
FROM PlayersInSquad
GROUP BY ss_id;

-- 10 Search for Specific Player
SELECT * 
FROM Players
WHERE p_name = 'Ronaldo';

-- 11 Get players from a specific nation
SELECT *
FROM Players
WHERE p_nation = 'Brazil';

-- 12 Get all SquadSummaries where AVG Rating is above a number
SELECT *
FROM SquadSummary
WHERE s_avgRating > 85;

-- 13 Get all Users who have SavedSquads with specific Formation
SELECT DISTINCT Users.u_name
FROM Users
JOIN SavedSquad ON Users.u_id = SavedSquad.u_id
JOIN SquadSummary ON SavedSquad.ss_id = SquadSummary.ss_id
JOIN Formation ON SquadSummary.f_id = Formation.f_id
WHERE Formation.f_name = '4-4-2';

-- 14 Find SquadSummary with a specific Top Nation & Top League
SELECT SquadSummary.s_id, SquadSummary.s_topLeague, SquadSummary.s_topNation
FROM SquadSummary
WHERE SquadSummary.s_topNation = 'England' AND SquadSummary.s_topLeague = 'Premier League';

-- 15 Find players with best attack performance metric
SELECT Players.p_name, MAX(PerformanceMetric.shooting_handling) as max_metric_value
FROM Players
JOIN PerformanceMetric ON Players.p_id = PerformanceMetric.p_id
GROUP BY Players.p_name, PerformanceMetric.shooting_handling;

-- 16 Get Players not in any squads
SELECT Players.p_name
FROM Players
JOIN PlayersInSquad ON Players.p_id = PlayersInSquad.p_id
WHERE PlayersInSquad.p_id IS NULL;

-- 17 Find user who has SavedSquad with players from a specific Club
SELECT DISTINCT Users.u_name
FROM Users
JOIN SavedSquad ON Users.u_id = SavedSquad.u_id
JOIN PlayersInSquad ON SavedSquad.ss_id = PlayersInSquad.ss_id
JOIN Players ON PlayersInSquad.p_id = Players.p_id
WHERE Players.p_club = 'EA FC ICONS';

-- 18 Calculate AVG Rating for every SquadSummary
SELECT SquadSummary.s_id, AVG(SquadSummary.s_avgRating) as avg_rating
FROM SquadSummary
GROUP BY SquadSummary.s_id;

-- 19 Get Users who have SavedSquads with the best Goalkepper ratings
SELECT DISTINCT Users.u_name
FROM Users
JOIN SavedSquad ON Users.u_id = SavedSquad.u_id
JOIN PlayersInSquad ON SavedSquad.ss_id = PlayersInSquad.ss_id
JOIN Players ON PlayersInSquad.p_id = Players.p_id
WHERE Players.p_position = 'GK'
ORDER BY Players.p_rating DESC
LIMIT 10;

-- 20 Find Users who have SavedSquads with players from differnt nations but a specific topLeague
SELECT DISTINCT Users.u_name
FROM Users
JOIN SavedSquad ON Users.u_id = SavedSquad.u_id
JOIN SquadSummary ON SavedSquad.ss_id = SquadSummary.ss_id
JOIN PlayersInSquad ON SquadSummary.ss_id = PlayersInSquad.ss_id
JOIN Players ON PlayersInSquad.p_id = Players.p_id
WHERE SquadSummary.s_topLeague = 'Premier League'
GROUP BY Users.u_name
HAVING COUNT(DISTINCT Players.p_nation) > 1;
