USE ActivityLab2;

DELIMITER $$

DROP PROCEDURE IF EXISTS PrintAllSubscribersWatchHistory $$
CREATE PROCEDURE PrintAllSubscribersWatchHistory()
BEGIN
    DECLARE v_sub_id INT;
    DECLARE v_sub_name VARCHAR(100);
    DECLARE v_cnt INT;
    DECLARE done TINYINT DEFAULT 0;

    DECLARE cur CURSOR FOR
        SELECT SubscriberID, SubscriberName
        FROM Subscribers
        ORDER BY SubscriberID;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;
    main_loop: LOOP
        FETCH cur INTO v_sub_id, v_sub_name;
        IF done = 1 THEN
            LEAVE main_loop;
        END IF;

        -- Header per subscriber
        SELECT CONCAT('SubscriberID=', v_sub_id, ' Name=', v_sub_name) AS Subscriber;

        -- Check if they have watch history
        SELECT COUNT(*) INTO v_cnt
        FROM WatchHistory
        WHERE SubscriberID = v_sub_id;

        IF v_cnt > 0 THEN
            CALL GetWatchHistoryBySubscriber(v_sub_id);
        ELSE
            SELECT 'No watch history' AS Message;
        END IF;
    END LOOP;

    CLOSE cur;
END $$
DELIMITER ;

-- Call:
CALL PrintAllSubscribersWatchHistory();
