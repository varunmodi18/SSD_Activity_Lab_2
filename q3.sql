USE ActivityLab2;

DELIMITER $$

DROP PROCEDURE IF EXISTS AddSubscriberIfNotExists $$
CREATE PROCEDURE AddSubscriberIfNotExists(IN subName VARCHAR(100))
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM Subscribers WHERE SubscriberName = subName
    ) THEN
        INSERT INTO Subscribers (SubscriberID, SubscriberName, SubscriptionDate)
        SELECT COALESCE(MAX(SubscriberID), 0) + 1, subName, CURDATE()
        FROM Subscribers;
    END IF;
END $$
DELIMITER ;

-- Calls (examples):
CALL AddSubscriberIfNotExists('Alice Bennett');
CALL AddSubscriberIfNotExists('Emily Clark');  -- No insert if already exists
