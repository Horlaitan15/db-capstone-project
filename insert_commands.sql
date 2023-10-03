USE LittleLemonDB;

INSERT INTO Countries (CountryCode, Country)
VALUES
('RW', 'Western Sahara'),
('TZ', 'Greenland'),
('ID', 'Togo'),
('AR', 'Cambodia'),
('GR', 'Costa Rica'),
('MV', 'Gambia'),
('TN', 'Tanzania'),
('JM', 'Libyan Arab Jamahiriya'),
('LV', 'Peru'),
('OM', 'Afghanistan');

INSERT INTO Addresses (AddressID, City, CountryCode, PostalCode)
VALUES
(1, 'Lake Lisa', 'RW', '03941'),
(2, 'East Brandonhaven', 'TZ', '87030'),
(3, 'Port Sheilafort', 'ID', '54029'),
(4, 'North Kimberly', 'AR', '13491'),
(5, 'Mcleanberg', 'GR', '57718'),
(6, 'North Matthew', 'MV', '67932'),
(7, 'North Stephanie', 'TN', '50724'),
(8, 'Michaelborough', 'JM', '51880'),
(9, 'North Garyfurt', 'LV', '72620'),
(10, 'Port Karenchester', 'OM', '81522');


INSERT INTO Customers (CustomerID, CustomerName, ContactNumber, Email, AddressID)
VALUES
(1, 'Shannon Small', '(666)648-3524x51438', 'angelicawatson@example.net', 1),
(2, 'Michael Martin', '(324)999-2003x706', 'meganroberts@example.com', 2),
(3, 'Katie Chandler', '(657)964-4759x54716', 'aaronmiller@example.net', 3),
(4, 'Jason Orozco', '+1-494-988-1102x106', 'eosborne@example.org', 4),
(5, 'Brandy Allen', '712.423.3483', 'smcdaniel@example.org', 5),
(6, 'Emily Parker', '(818)285-9702', 'gvaughan@example.com', 6),
(7, 'Alexander Strickland', '(563)595-5581x71781', 'riostina@example.org', 7),
(8, 'Joseph Mercer', '(677)814-2325', 'tammymooney@example.org', 8),
(9, 'Evan Mathis', '718.919.0799x47573', 'vdickson@example.org', 9),
(10, 'Kenneth Love', '+1-370-896-3303x66445', 'kellyfisher@example.com', 10);

