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
-- DATA ENTRY FOR RESULTS TABLE
INSERT INTO results
	(result_id, medal, athlete, event)
VALUES
	(1, 'Gold', 1, 1),
	(2, 'Silver', 3, 1),
	(3, 'Bronze', 6, 1),
	(4, 'Gold', 2, 2),
	(5, 'Silver', 4, 2),
	(6, 'Bronze', 3, 2),
	(7, 'Gold', 4, 3),
	(8, 'Silver', 3, 3),
	(9, 'Bronze', 1, 3);

/****************
 * QUESTION #4	*
 ****************/
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

/***************
 * QUESTION #5 *
 ***************/
SELECT 
	a.athlete_fname AS 'Athlete First Name',
	a.athlete_lname AS 'Athlete Last Name'
FROM athletes a 
LEFT JOIN results r 
	ON r.athlete = a.athlete_id
WHERE r.athlete IS NULL;

/***************
 * QUESTION #6 *
 ***************/
CREATE TABLE change_log (
	`action`		ENUM('UPDATE', 'INSERT', 'DELETE')	NOT NULL,
	log_id			INT									PRIMARY KEY		AUTO_INCREMENT,
	result_id_old	INT									NOT NULL,
	result_id_new	INT									NOT NULL,
	medal_old		VARCHAR(255)						NOT NULL,
	medal_new		VARCHAR(255)						NOT NULL,
	athlete_old		INT									NOT NULL,
	athlete_new		INT									NOT NULL,
	event_old		INT									NOT NULL,
	event_new		INT									NOT	NULL,
	`time`			TIMESTAMP							NOT NULL
);

/**************
 * QUESTION 7 *
 **************/
CREATE TRIGGER insert_data
	AFTER INSERT ON results
	FOR EACH ROW
		INSERT INTO change_log	(	
			`action`, result_id_old,
			result_id_new,
			medal_old, 
			medal_new, 
			athlete_old, 
			athlete_new,
			event_old,
			event_new,
			`time`
		)
		VALUES	(	
			'INSERT',
			NEW.result_id, 
			NEW.medal, 
			NEW.athlete,
			NEW.event,
			NOW()
		);


/**************
 * QUESTION 8 *
 **************/
CREATE TRIGGER update_data
	AFTER UPDATE ON results
	FOR EACH ROW
		INSERT INTO change_log	(	
			`action`, 
			result_id_old,
			result_id_new,
			medal_old, 
			medal_new, 
			athlete_old, 
			athlete_new,
			event_old,
			event_new,
			`time`
		)
		VALUES	(	
			'UPDATE',
			OLD.result_id, 
			NEW.result_id, 
			OLD.medal, 
			NEW.medal, 
			OLD.athlete,
			NEW.athlete,
			OLD.event,
			NEW.event,
			NOW()
		);
	
/**************
 * QUESTION 9 *
 **************/





