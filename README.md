# SSD_Activity_Lab_2

README.TXT — Activity Lab 2 (SQL)

======================================================================
OVERVIEW
======================================================================
This assignment builds a small streaming-service schema and procedures
in MySQL/MariaDB.

Tables:
  • Shows(ShowID, Title, Genre, ReleaseYear)
  • Subscribers(SubscriberID, SubscriberName, SubscriptionDate)
  • WatchHistory(HistoryID, ShowID, SubscriberID, WatchTime)

Stored Procedures:
  1) ListAllSubscribers()
  2) GetWatchHistoryBySubscriber(IN sub_id INT)
  3) AddSubscriberIfNotExists(IN subName VARCHAR(100))
  4) SendWatchTimeReport()
  5) PrintAllSubscribersWatchHistory()

You will:
  • Create a database named ActivityLab2
  • Create tables and insert sample data (≥10 rows in Shows/Subscribers and ≥10+ rows in WatchHistory)
  • Create the stored procedures
  • Run procedure calls to verify behavior


======================================================================
PREREQUISITES
======================================================================
• MySQL 5.7+ or MariaDB 10.3+ (or compatible)
• An account with privileges to CREATE DATABASE and CREATE ROUTINE
• A SQL client (mysql CLI or MySQL Workbench/other GUI)


======================================================================
FILES (suggested names)
======================================================================
If you prefer to run via files, save your SQL into:
  00_create_database.sql     -> CREATE DATABASE / USE
  01_schema_and_seed.sql     -> CREATE TABLE + INSERT data
  02_procedures.sql          -> all 5 stored procedures

(If you don’t use files, you can paste the statements directly into your SQL client in the order shown below.)


======================================================================
HOW TO EXECUTE (mysql CLI)
======================================================================
Option A: Using files

1) Open terminal and start the client:
   mysql -u <user> -p

2) Create and select the database:
   -- 00_create_database.sql
   CREATE DATABASE ActivityLab2;
   USE ActivityLab2;

3) Load schema + seed data:
   -- 01_schema_and_seed.sql
   SOURCE /absolute/path/to/01_schema_and_seed.sql;

4) Load stored procedures:
   -- 02_procedures.sql
   SOURCE /absolute/path/to/02_procedures.sql;

5) Verify:
   SHOW DATABASES;
   USE ActivityLab2;
   SHOW TABLES;
   SELECT COUNT(*) FROM Shows;
   SELECT COUNT(*) FROM Subscribers;
   SELECT COUNT(*) FROM WatchHistory;

6) Test procedure calls (examples):
   CALL ListAllSubscribers();
   CALL GetWatchHistoryBySubscriber(1);
   CALL AddSubscriberIfNotExists('Alice Bennett');
   CALL SendWatchTimeReport();
   CALL PrintAllSubscribersWatchHistory();


Option B: Pasting directly

1) In the mysql client:
   mysql -u <user> -p

2) Paste and run:
   CREATE DATABASE ActivityLab2;
   USE ActivityLab2;

3) Paste and run your CREATE TABLE + INSERT statements.

4) Paste and run the stored procedures. Remember to set the delimiter:
   DELIMITER $$ 
   ... CREATE PROCEDURE ... $$
   DELIMITER ;

5) Run the same verification and CALL statements as shown above.


======================================================================
DELIMITER NOTES (IMPORTANT)
======================================================================
When creating procedures, switch the delimiter to avoid early semicolon
termination, e.g.:

   DELIMITER $$
   CREATE PROCEDURE ExampleProc()
   BEGIN
       SELECT 'ok';
   END $$
   DELIMITER ;

If you forget to reset the delimiter, subsequent commands may fail.


======================================================================
TROUBLESHOOTING
======================================================================
• ERROR 1007: Can’t create database; database exists
  - Solution: DROP DATABASE ActivityLab2; then recreate, or use a different name.

• ERROR 1050: Table already exists
  - Solution: DROP TABLE WatchHistory; DROP TABLE Subscribers; DROP TABLE Shows; then rerun schema.

• ERROR 1305: PROCEDURE … doesn’t exist
  - Solution: Ensure you ran 02_procedures.sql with the correct DELIMITER, in the ActivityLab2 database, and no errors appeared.

• Foreign key errors on inserts
  - Ensure Shows and Subscribers are inserted before WatchHistory.


======================================================================
GIT REPOSITORY
======================================================================
Repository URL:
  https://github.com/<your-username>/<your-repo-name>

(Replace <your-username>/<your-repo-name> with your actual repository path.)

Suggested structure:
  /sql
    00_create_database.sql
    01_schema_and_seed.sql
    02_procedures.sql
  /README.TXT   (this file)

Basic git commands:
  git init
  git add .
  git commit -m "Activity Lab 2: schema, seed, procedures, README"
  git branch -M main
  git remote add origin https://github.com/<your-username>/<your-repo-name>.git
  git push -u origin main


======================================================================
SAMPLE CALLS (copy/paste)
======================================================================
USE ActivityLab2;
CALL ListAllSubscribers();
CALL GetWatchHistoryBySubscriber(1);
CALL AddSubscriberIfNotExists('Alice Bennett');
CALL SendWatchTimeReport();
CALL PrintAllSubscribersWatchHistory();


======================================================================
RESET (OPTIONAL)
======================================================================
-- DANGER: This will drop the database and all data
DROP DATABASE IF EXISTS ActivityLab2;
-- Then recreate using the steps above.
