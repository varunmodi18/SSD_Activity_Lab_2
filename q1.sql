USE ActivityLab2;

DELIMITER $$

DROP PROCEDURE IF EXISTS ListAllSubscribers $$
CREATE PROCEDURE ListAllSubscribers()
BEGIN
    DECLARE v_name VARCHAR(100);
    DECLARE done TINYINT DEFAULT 0;

    DECLARE cur CURSOR FOR
        SELECT SubscriberName FROM Subscribers ORDER BY SubscriberName;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO v_name;
        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        -- Emit one row per name
        SELECT v_name AS SubscriberName;
    END LOOP;

    CLOSE cur;
END $$
DELIMITER ;

-- Call:
CALL ListAllSubscribers();
