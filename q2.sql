USE ActivityLab2;

DELIMITER $$

DROP PROCEDURE IF EXISTS GetWatchHistoryBySubscriber $$
CREATE PROCEDURE GetWatchHistoryBySubscriber(IN sub_id INT)
BEGIN
    SELECT s.ShowID,
           s.Title,
           s.Genre,
           s.ReleaseYear,
           w.WatchTime
    FROM WatchHistory w
    JOIN Shows s ON s.ShowID = w.ShowID
    WHERE w.SubscriberID = sub_id
    ORDER BY s.Title;
END $$
DELIMITER ;

-- Calls (examples):
CALL GetWatchHistoryBySubscriber(1);
CALL GetWatchHistoryBySubscriber(3);
