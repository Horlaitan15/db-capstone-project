USE LittleLemonDB;
CREATE VIEW OrdersView AS SELECT OrderID, Quantity, TotalCost FROM  Orders WHERE Quantity > 2;
create view OrdersInfoView AS 
SELECT C.CustomerID, C.CustomerName AS FullName, O.OrderID, O.TotalCost, M.MenuName, I.CourseName 
FROM Customers AS C LEFT JOIN Orders AS O ON C.CustomerID = O.CustomerID
LEFT JOIN Menus AS M ON O.MenuID = M.MenuID
LEFT JOIN MenuItems AS I ON M.MenuItemID = I.MenuItemID
WHERE O.TotalCost > 150;

SELECT MenuName FROM Menus WHERE MenuID = ANY (SELECT MenuID FROM Orders WHERE Quantity > 2);
CREATE PROCEDURE GetMaxQuantity()
	SELECT MAX(Quantity) AS 'MAX Quantity in Order' FROM Orders

DELIMITER //
CREATE PROCEDURE PrepareStored()
	BEGIN
		PREPARE GetOrderDetail FROM 'SELECT OrderID, Quantity, TotalCost FROM Orders WHERE CustomerID = ?';
		SET @id = 1;
		EXECUTE GetOrderDetail USING @id;
	END //

DELIMITER ;
-- CALL PrepareStored;

DELIMITER //
CREATE PROCEDURE CancelOrder(IN order_id VARCHAR(45))
	BEGIN
		DELETE FROM Orders WHERE OrderID = order_id;
		SELECT CONCAT('Order ', order_id, ' is cancelled') AS Confirmation;
	END //

DELIMITER ;

INSERT INTO Bookings (BookingID, BookingSlot, TableNumber, CustomerID) 
VALUES 
(1, '2022-10-10', 5, 1), (2, '2022-11-12', 3, 3), (3,'2022-10-11', 2, 2),
(4, '2022-10-13', 2, 1);

DELIMITER //
CREATE PROCEDURE CheckBooking(IN booking_slot DATE, IN table_number INT)
	BEGIN
		DECLARE result_count INT;
		SELECT COUNT(BookingID) INTO result_count FROM Bookings WHERE BookingSlot = DATE(booking_slot) AND TableNumber = table_number;
        IF result_count > 0 THEN
        SELECT CONCAT('Table ', table_number, ' is already booked') AS 'Booking Status';
        ELSE
        SELECT CONCAT('Table ', table_number, ' is available') AS 'Booking Status';
        END IF;
	END //
    
DELIMITER ;

-- CALL CheckBooking('2022-11-12', 3);

DELIMITER //
CREATE PROCEDURE AddValidBooking(order_date DATE, table_number INT)
BEGIN
START TRANSACTION;
INSERT INTO Bookings (BookingID, BookingSlot, TableNumber, CustomerID) VALUES (1, ordate_date, table_number, 2);
IF (SELECT COUNT(BookingID) FROM Bookings WHERE TableNumber = table_number) > 1 THEN
SELECT CONCAT('Table ', table_number, ' is already booked - booking cancelled') AS 'Booking status';
ROLLBACK;
ELSE
SELECT CONCAT('Table ', table_number, ' has successfully been booked.') AS 'Booking status';
COMMIT;
END IF;
END //

CREATE PROCEDURE AddBooking(booking_id INT, customer_id INT, booking_date DATE, table_number INT)
BEGIN
INSERT INTO Bookings (BookingID, CustomerID, TableNumber, BookingSlot) VALUES (booking_id, customer_id, table_number, booking_date);
SELECT 'New booking added' AS Confirmation;
END //

CREATE PROCEDURE UpdateBooking (booking_id INT, booking_date DATE)
BEGIN
UPDATE Bookings SET BookingSlot = booking_date WHERE BookingID = booking_id;
SELECT CONCAT('Booking ', booking_id, ' updated') AS Confirmation;
END //

CREATE PROCEDURE CancelBooking (booking_id INT)
BEGIN
DELETE FROM Bookings WHERE BookingID = booking_id;
SELECT CONCAT('Booking ', booking_id, ' cancelled') AS Confirmation;
END //

