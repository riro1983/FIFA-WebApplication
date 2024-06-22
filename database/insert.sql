-- Inserting Data into Users Table
INSERT INTO 'Users' ('u_id', 'u_name', 'u_pass') VALUES
(1, 'Lionel', 'CR7'),
(2, 'Garfield', 'lasagna'), 
(3, 'Rick', 'Morty'),
(4, 'Javier', '123'),
(5, 'Ricardo', '5678');

-- Importing players23_info.csv into Players Table
.mode "csv"
.headers on
.import players23_info.csv Players

-- Importing Data into PerformanceMetric Table
.mode "csv"
.headers on
.import players_performance23_info.csv PerformanceMetric

-- Inserting data into PerformanceMetric table
-- Inserting data into PerformanceMetric table for 10 players
/*
INSERT INTO PerformanceMetric (p_id, pace_diving, shooting_handling, passing_kicking, dribbling_reflexes, defense_speed, physical_positioning)
VALUES 
    (1, 95, 85, 90, 92, 88, 89),
    (2, 92, 78, 85, 89, 82, 85),
    (3, 90, 88, 82, 85, 80, 84),
    (4, 88, 84, 87, 91, 75, 82),
    (5, 85, 80, 75, 78, 90, 88),
    (6, 75, 92, 78, 80, 85, 89),
    (7, 89, 85, 84, 87, 78, 82),
    (8, 91, 79, 88, 90, 82, 86),
    (9, 86, 83, 85, 88, 79, 83),
    (10, 88, 87, 84, 91, 84, 85);
*/
-- Inserting Data into Formation Table
INSERT INTO 'Formation' ('f_id', 'f_name', 'u_id') VALUES
(0001, '4-4-2', 1),
(0002, '4-4-3', 2),
(0003, '4-1-4-1', 3),
(0004, '4-3-2-1', 4),
(0005, '4-2-2-2', 5),
(0006, '4-2-1-2', 6),
(0007, '4-5-1', 7),
(0008, '5-3-2', 8),
(0009, '4-4-1-1', 9),
(0010, '3-5-2', 10),
(0011, '3-4-3', 11),
(0012, '4-2-3-1', 12),
(0013, '4-1-2-3', 13);

-- Insert Data Into Players
-- Inserting players data into the Players table
/*
INSERT INTO Players (p_name, p_club, p_nation, p_league, p_rating, p_position)
VALUES 
    ('Pelé', 'EA FC ICONS', 'Brazil', 'Icons', 95, 'CAM'),
    ('Zinedine Zidane', 'EA FC ICONS', 'France', 'Icons', 94, 'CAM'),
    ('Ronaldo', 'EA FC ICONS', 'Brazil', 'Icons', 94, 'ST'),
    ('Ronaldinho', 'EA FC ICONS', 'Brazil', 'Icons', 93, 'LW'),
    ('Johan Cruyff', 'EA FC ICONS', 'Holland', 'Icons', 93, 'CF'),
    ('Lev Yashin', 'EA FC ICONS', 'Russia', 'Icons', 92, 'GK'),
    ('Ferenc Puskás', 'EA FC ICONS', 'Hungary', 'Icons', 92, 'CF'),
    ('Mané Garrincha', 'EA FC ICONS', 'Brazil', 'Icons', 92, 'RW'),
    ('Paolo Maldini', 'EA FC ICONS', 'Italy', 'Icons', 92, 'CB'),
    ('Müller', 'EA FC ICONS', 'Germany', 'Icons', 92, 'ST'),
    ('Charlton', 'EA FC ICONS', 'England', 'Icons', 92, 'CAM'),
    ('Erling Haaland', 'Manchester City', 'Norway', 'Premier League', 92, 'ST'),
    ('Erling Haaland', 'Manchester City', 'Norway', 'Premier League', 91, 'ST'),
    ('Kylian Mbappé', 'Paris SG', 'France', 'Ligue 1 Uber Eats', 91, 'ST'),
    ('Kevin De Bruyne', 'Manchester City', 'Belgium', 'Premier League', 91, 'CM'),
    ('Robert Lewandowski', 'FC Barcelona', 'Poland', 'LALIGA EA SPORTS', 91, 'ST'),
    ('Franco Baresi', 'EA FC ICONS', 'Italy', 'Icons', 91, 'CB'),
    ('Thierry Henry', 'EA FC ICONS', 'France', 'Icons', 91, 'ST'),
    ('Carlos Alberto Torres', 'EA FC ICONS', 'Brazil', 'Icons', 91, 'RB'),
    ('Marcos Cafú', 'EA FC ICONS', 'Brazil', 'Icons', 91, 'RWB'),
    ('Marco van Basten', 'EA FC ICONS', 'Holland', 'Icons', 91, 'ST'),
    ('Eusébio', 'EA FC ICONS', 'Portugal', 'Icons', 91, 'CF'),
    ('Antunes Coimbra', 'EA FC ICONS', 'Brazil', 'Icons', 91, 'CAM'),
    ('Roberto Baggio', 'EA FC ICONS', 'Italy', 'Icons', 91, 'CAM'),
    ('Harry Kane', 'FC Bayern München', 'England', 'Bundesliga', 91, 'ST'),
    ('Lionel Messi', 'Inter Miami CF', 'Argentina', 'MLS', 90, 'CF'),
    ('Karim Benzema', 'Al Ittihad', 'France', 'ROSHN Saudi League', 90, 'CF'),
    ('Thibaut Courtois', 'Real Madrid', 'Belgium', 'LALIGA EA SPORTS', 90, 'GK'),
    ('Harry Kane', 'FC Bayern München', 'England', 'Bundesliga', 90, 'ST');
*/

INSERT INTO SquadSummary (s_id, ss_id, u_id, f_id, s_avgRating, s_attRating, s_defRating, s_topLeague, s_topNation, s_topteam)
VALUES (1, 1, 1, 1, 90, 88, 85, 'Premier League', 'England', 'FC Bayern München');

-- Inserting data into PlayersInSquad table
INSERT INTO PlayersInSquad (p_id, ss_id)
VALUES 
    (1, 1),
    (2, 1),
    (3, 2),
    (4, 2),
    (5, 3),
    (6, 3),
    (7, 4),
    (8, 4),
    (9, 5),
    (10, 5);

-- Inserting data into SavedSquad table
/* 
INSERT INTO SavedSquad (u_id, s_id, p_id)
VALUES 
    (1, 1, 1),
    (2, 2, 2),
    (3, 3, 3),
    (4, 4, 4),
    (5, 5, 5);
*/
INSERT INTO UsersSquads (usquad_id, u_id, ss_id) VALUES
    (1, 1, 1),
    (2, 2, 2),
    (3, 3, 3);