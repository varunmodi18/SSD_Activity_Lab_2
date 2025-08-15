USE ActivityLab2;

DELIMITER $$

DROP PROCEDURE IF EXISTS SendWatchTimeReport $$
CREATE PROCEDURE SendWatchTimeReport()
BEGIN
    DECLARE v_sub_id INT;
    DECLARE done TINYINT DEFAULT 0;

    -- Iterate only over subscribers present in WatchHistory
    DECLARE cur CURSOR FOR
        SELECT DISTINCT SubscriberID FROM WatchHistory ORDER BY SubscriberID;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;
    loop_subs: LOOP
        FETCH cur INTO v_sub_id;
        IF done = 1 THEN
            LEAVE loop_subs;
        END IF;

        -- Optional header per subscriber
        SELECT CONCAT('Watch history for SubscriberID = ', v_sub_id) AS Header;

        CALL GetWatchHistoryBySubscriber(v_sub_id);
    END LOOP;

    CLOSE cur;
END $$
DELIMITER ;

-- Call:
CALL SendWatchTimeReport();
