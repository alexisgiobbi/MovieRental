CREATE PROCEDURE UserLogin (
    IN input_username VARCHAR(255),
    IN input_password VARCHAR(255)
)
BEGIN
    DECLARE user_type VARCHAR(50);
    DECLARE user_id INT;
    DECLARE user_name VARCHAR(255);
    DECLARE store_id INT;
    DECLARE position VARCHAR(255);
    DECLARE email VARCHAR(255);
    DECLARE phone_number VARCHAR(255);

    -- Check in Customer table
    SELECT 'Customer', customer_id, name, NULL, NULL, email, phone_number
    INTO user_type, user_id, user_name, store_id, position, email, phone_number
    FROM Customer
    WHERE username = input_username AND password = input_password
    LIMIT 1;

    IF user_type IS NOT NULL THEN
        SELECT user_type, user_id, user_name, store_id, position, email, phone_number;
        LEAVE PROCEDURE;
    END IF;

    -- Check in Employee table
    SELECT 'Employee', employee_id, name, store_id, position, NULL, NULL
    INTO user_type, user_id, user_name, store_id, position, email, phone_number
    FROM Employee
    WHERE username = input_username AND password = input_password
    LIMIT 1;

    IF user_type IS NOT NULL THEN
        SELECT user_type, user_id, user_name, store_id, position, email, phone_number;
        LEAVE PROCEDURE;
    END IF;

    -- If no match found, return NULL
    SELECT NULL AS user_type, NULL AS user_id, NULL AS user_name, NULL AS store_id, NULL AS position, NULL AS email, NULL AS phone_number;
END;
