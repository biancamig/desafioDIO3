USE ecommerce;

SHOW TABLES;

SHOW PROCEDURE STATUS
WHERE Db = 'ecommerce';

SHOW EVENTS FROM ecommerce;

SHOW VARIABLES LIKE 'event_scheduler';


CREATE TABLE IF NOT EXISTS event_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    execution_date DATETIME
);

DROP EVENT IF EXISTS ev_backup_test;

CREATE EVENT ev_backup_test
ON SCHEDULE EVERY 1 MINUTE
DO
    INSERT INTO event_log (execution_date)
    VALUES (NOW());


SELECT * FROM event_log;

ALTER EVENT ev_backup_test DISABLE;


SHOW PROCEDURE STATUS
WHERE Db = 'ecommerce';

SHOW EVENTS FROM ecommerce;


USE company_constraints;

SHOW TABLES;