/******************
 * ATHLETES TABLE *
 ******************/
CREATE TABLE athletes (
	athlete_id		INT				PRIMARY KEY,
	athlete_fname	VARCHAR(255)	NOT NULL,
	athlete_lname	VARCHAR(255)	NOT NULL
);
-- DATA ENTRY FOR ATHLETES TABLE
INSERT INTO athletes 
	(athlete_id, athlete_fname, athlete_lname)
VALUES
	(1, 'Dorothy', 'Dietrich'),
	(2, 'Fay', 'Presto'),
	(3, 'Doug', ' Henning'),
	(4, 'Ellen', 'Armstrong'),
	(5, 'Edgar', 'Cayce'),
	(6, 'Howard', 'Thurston');

/****************
 * EVENTS TABLE	*
 ****************/
CREATE TABLE events (
	event_id	INT				PRIMARY KEY,
	event_name	VARCHAR(255)	NOT NULL,
	event_time	TIME			NOT NULL
);
-- DATA ENTRY FOR EVENTS TABLE
INSERT INTO events
	(event_id, event_name, event_time)
VALUES
	(1, 'Javelin Throw', '10:00'),
	(2, '100m Sprint', '13:00'),
	(3, 'Pole Vault', '15:00');

/*****************
 * RESULTS TABLE *
 *****************/
CREATE TABLE results (
	result_id	INT				PRIMARY KEY,
	medal		VARCHAR(255)	NOT NULL,
	athlete 	INT				NOT NULL,
	event		INT				NOT NULL,
	FOREIGN KEY (athlete)
		REFERENCES athletes (athlete_id),
	FOREIGN KEY (event)
		REFERENCES events (event_id)
);


CREATE VIEW athletes_table AS 
SELECT 
	a.athlete_fname AS "First Name",
	a.athlete_lname AS "Last Name",
	e.event_name AS "Event Name",
	e.event_time AS "Event Time",
	r.medal AS "Medal Earned"
FROM results r
JOIN athletes a 
	ON r.athlete = a.athlete_id 
JOIN events e 
	ON r.event = e.event_id;

