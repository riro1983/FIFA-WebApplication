-- Drop the old table (WARNING: This will delete the existing data)
DROP TABLE IF EXISTS Users;
-- Users Table
CREATE TABLE Users (
    u_id INTEGER PRIMARY KEY AUTOINCREMENT,
    u_name VARCHAR(50) NOT NULL,
    u_pass VARCHAR(255) NOT NULL
);
-- Drop the old table (WARNING: This will delete the existing data)
DROP TABLE IF EXISTS Players;
-- Players Table
CREATE TABLE Players (
    p_id INT PRIMARY KEY,
    p_name VARCHAR(255) NOT NULL,
    p_club VARCHAR(255),
    p_league VARCHAR(255),
    p_nation VARCHAR(255),
    p_rating INT,
    p_position VARCHAR(255)
);
-- Drop the old table (WARNING: This will delete the existing data)
DROP TABLE IF EXISTS SavedSquad;
-- Saved Squad Table
CREATE TABLE SavedSquad (
    ss_id INTEGER PRIMARY KEY AUTOINCREMENT,
    u_id INT,
    s_id INT,
    p_id INT,
    f_id INT,
    FOREIGN KEY (u_id) REFERENCES Users(u_id),
    FOREIGN KEY (s_id) REFERENCES SquadSummary(s_id),
    FOREIGN KEY (p_id) REFERENCES Players(p_id),
    FOREIGN KEY (f_id) REFERENCES Formation(f_id)
);
-- Drop the old table (WARNING: This will delete the existing data)
DROP TABLE IF EXISTS SquadSummary;
-- Squad Summary Table
CREATE TABLE SquadSummary (
    s_id INT PRIMARY KEY,
    ss_id INT,
    u_id INT,
    f_id INT,
    s_avgRating INT,
    s_attRating INT,
    s_defRating INT,
    s_topLeague VARCHAR(255),
    s_topNation VARCHAR(255),
    s_topteam VARCHAR(255),
    FOREIGN KEY (ss_id) REFERENCES SavedSquad(ss_id),
    FOREIGN KEY (u_id) REFERENCES Users(u_id)
    FOREIGN KEY (f_id) REFERENCES Formation(f_id)
);
-- Drop the old table (WARNING: This will delete the existing data)
DROP TABLE IF EXISTS Formation;
-- Formation Table
CREATE TABLE Formation (
    f_id INTEGER PRIMARY KEY,
    f_name VARCHAR(255) NOT NULL,
    u_id INT,
    FOREIGN KEY (u_id) REFERENCES Users(u_id)
);

-- Drop the old table (WARNING: This will delete the existing data)
DROP TABLE IF EXISTS PerformanceMetric;

-- Create a new PerformanceMetric table
CREATE TABLE PerformanceMetric (
    pm_id INT PRIMARY KEY,
    p_id INT,
    Pace_Diving INT,
    Shooting_Handling INT,
    Passing_Kicking INT,
    Dribbling_Reflexes INT,
    Defense_Speed INT,
    Physical_Positioning INT,
    FOREIGN KEY (p_id) REFERENCES Players(p_id)
);


-- Drop the old table (WARNING: This will delete the existing data)
DROP TABLE IF EXISTS UsersSquads;
-- UsersSquads Table (Association Table for Many-to-Many relationship between Users and SavedSquad)
CREATE TABLE UsersSquads (
    usquad_id INTEGER PRIMARY KEY,
    u_id INT,
    ss_id INTEGER,
    FOREIGN KEY (u_id) REFERENCES Users(u_id),
    FOREIGN KEY (ss_id) REFERENCES SavedSquad(ss_id)
);
-- Drop the old table (WARNING: This will delete the existing data)
DROP TABLE IF EXISTS PlayersInSquad;
-- PlayersInSquad Table (Association Table for Many-to-Many relationship between Players and SavedSquad)
CREATE TABLE PlayersInSquad (
    psquad_id INTEGER PRIMARY KEY AUTOINCREMENT,
    p_id INTEGER,
    ss_id INTEGER,
    FOREIGN KEY (p_id) REFERENCES Players(p_id),
    FOREIGN KEY (ss_id) REFERENCES SavedSquad(ss_id)
);

-- The following table relationships need clarification as they are not fully clear from the diagram:
-- 1. How SavedSummary relates to UsersSquads.
-- 2. How PlayersSaved relates to other tables.

-- Once clarified, you can add FOREIGN KEY constraints to establish the relationships.

-- You should also add INDEXES as needed for columns that will be used in JOIN operations or where searches are frequent.

-- After creating the tables, you can use .import commands to load CSV data into these tables, assuming you have CSV files with matching columns.
