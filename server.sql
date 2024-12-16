CREATE TABLE IF NOT EXISTS  music_rawData (    --Table of all your music data, unfiltered (raw basically)
  endtime DATETIME, 
  artistName VARCHAR(100), 
  trackName VARCHAR(200), 
  msPlayed FLOAT
  );
.import music_output.csv music_rawData --csv --skip 1

CREATE TABLE IF NOT EXISTS  podcast_rawData ( --Table of all your podcast data, unfiltered (raw basically)
  endtime DATETIME, 
  artistName VARCHAR(100), 
  trackName VARCHAR(200), 
  msPlayed FLOAT
  );
.import podcast_output.csv podcast_rawData --csv --skip 1


CREATE TABLE IF NOT EXISTS  music_dateFiltered AS   --Filter items in music_rawData to within a date range
SELECT *
FROM music_rawData
WHERE endtime >= '2024-01-01' -- This is the start of your range
AND endtime < '2024-12-04';   -- This is the end of your range

CREATE TABLE IF NOT EXISTS  podcast_dateFiltered AS --Filter items in podcast_rawData to within a date range
SELECT *
FROM podcast_rawData
WHERE endtime >= '2024-01-01' -- This is the start of your range
AND endtime < '2024-12-04';   -- This is the end of your range

CREATE TABLE IF NOT EXISTS  dateFiltered AS         --Combination of all your music and podcast data within the date range
SELECT * 
FROM music_dateFiltered
UNION
SELECT *
FROM podcast_dateFiltered;

CREATE TABLE IF NOT EXISTS  normalizedMinutes AS    --Converts msPlayed to minutesPlayed in dateFiltered
SELECT endtime, artistName, trackName, msPlayed / 60000 AS minutesPlayed 
FROM dateFiltered;

CREATE TABLE IF NOT EXISTS  minutesByArtist AS      --Table of total minutes listened to artists
SELECT artistName, SUM(msPlayed) / 60000 AS totalMinutes 
FROM music_dateFiltered 
GROUP BY artistName 
ORDER BY totalMinutes ASC;

CREATE TABLE IF NOT EXISTS  minutesByPodcast AS     --Table of total minutes listened to podcasts
SELECT artistName AS podcast, SUM(msPlayed) / 60000 AS totalMinutes 
FROM podcast_dateFiltered 
GROUP BY artistName 
ORDER BY totalMinutes ASC;

CREATE TABLE IF NOT EXISTS  music_listenTime AS     --Total minutes listened to music
SELECT SUM(msPlayed) / 60000 AS totalMinutes 
FROM music_dateFiltered;

CREATE TABLE IF NOT EXISTS  podcast_listenTime AS   --Total minutes listened to podcasts
SELECT SUM(msPlayed) / 60000 AS totalMinutes 
FROM podcast_dateFiltered;

CREATE TABLE IF NOT EXISTS  total_listenTime AS     --Total minutes listened to music AND podcasts
SELECT SUM(msPlayed) / 60000 AS totalMinutes 
FROM dateFiltered;

CREATE TABLE IF NOT EXISTS  minutesBySong AS        --Total minutes listened by specific songs
SELECT artistName, trackName, SUM(msPlayed) / 60000  AS totalMinutes
FROM music_dateFiltered
GROUP BY trackName
ORDER BY totalMinutes ASC;

CREATE TABLE IF NOT EXISTS  minutesByMonth AS       --Total minutes by month for BOTH music AND podcasts
SELECT strftime('%m', endtime) AS month, SUM(msPlayed) / 60000 AS totalMinutes 
FROM dateFiltered GROUP BY strftime('%Y-%m', endtime) ORDER BY month;

.mode column        
--idk I'm too lazy to type this everytime I open SQL so I put it here
.tables             
--starts with a "page of contents"