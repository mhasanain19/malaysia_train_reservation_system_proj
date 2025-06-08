create database SQLassignment;

use SQLassignment;


CREATE TABLE Track ( 
    TrackID NVARCHAR(50) PRIMARY KEY, 
    TrackName NVARCHAR(50), 
    TrackCode NVARCHAR(50), 
    TotalTrainsPerDay INT 
); 
 
CREATE TABLE Train (
    TrainNumber NVARCHAR(50) PRIMARY KEY,
    TrainName NVARCHAR(50), 
    BusinessSeats int,
    EconomySeats int,
    TrackID NVARCHAR(50),
    FOREIGN KEY (TrackID) REFERENCES Track(TrackID)
);
 
CREATE TABLE TrainAttendant ( 
    AttendantID NVARCHAR(50) PRIMARY KEY, 
    FullName NVARCHAR(50), 
    Position NVARCHAR(50), 
    Salary DECIMAL(10, 2), 
    PhoneNumber NVARCHAR(50), 
    Address NVARCHAR(50) 
); 
 
CREATE TABLE Assigned ( 
AssignmentID NVARCHAR(50) PRIMARY KEY, 
    TrainNumber NVARCHAR(50), 
    AttendantID NVARCHAR(50), 
    FOREIGN KEY (TrainNumber) REFERENCES Train(TrainNumber), 
    FOREIGN KEY (AttendantID) REFERENCES TrainAttendant(AttendantID) 
); 
 
CREATE TABLE State ( 
    StateID NVARCHAR(50) PRIMARY KEY, 
    StateName NVARCHAR(50) 
); 
 
CREATE TABLE TrainStation ( 
    StationID NVARCHAR(50) PRIMARY KEY, 
    StationName NVARCHAR(50), 
    StateID NVARCHAR(50), 
    FOREIGN KEY (StateID) REFERENCES State(StateID) 
); 
 
CREATE TABLE TrackState ( 
    TrackStateID NVARCHAR(50) PRIMARY KEY, 
    TrackID NVARCHAR(50), 
    StateID NVARCHAR(50), 
    FOREIGN KEY (TrackID) REFERENCES Track(TrackID), 
    FOREIGN KEY (StateID) REFERENCES State(StateID) 
); 
 
CREATE TABLE Schedule ( 
ScheduleID NVARCHAR(50) PRIMARY KEY, 
DepartureDate DATE, 
    DepartureTime TIME, 
    ArrivalDate DATE, 
    ArrivalTime TIME, 
    OriginStationID NVARCHAR(50), 
    DestinationStationID NVARCHAR(50), 
    TrainNumber NVARCHAR(50), 
    FOREIGN KEY (OriginStationID) REFERENCES TrainStation(StationID), 
    FOREIGN KEY (DestinationStationID) REFERENCES TrainStation(StationID), 
    FOREIGN KEY (TrainNumber) REFERENCES Train(TrainNumber) 
); 
 
CREATE TABLE TrainOperator ( 
    OperatorID NVARCHAR(50) PRIMARY KEY, 
    FirstName NVARCHAR(50), 
    LastName NVARCHAR(50), 
    Age INT, 
    YearExperience INT, 
    Position NVARCHAR(50), 
    LeadHours INT, 
    Salary decimal(10, 2) 
); 
 
CREATE TABLE Operates ( 
    OperatesID NVARCHAR(50) PRIMARY KEY, 
    Role NVARCHAR(50), 
    TrainNumber NVARCHAR(50), 
    OperatorID NVARCHAR(50), 
FOREIGN KEY (TrainNumber) REFERENCES Train(TrainNumber), 
FOREIGN KEY (OperatorID) REFERENCES TrainOperator(OperatorID) 
); 
 
CREATE TABLE MailingAddress ( 
    MailingAddressID NVARCHAR(50) PRIMARY KEY, 
    Street NVARCHAR(100), 
    City NVARCHAR(50), 
    State NVARCHAR(50), 
    PostalCode NVARCHAR(50), 
    Country NVARCHAR(50) 
); 
 
CREATE TABLE Customer ( 
    CustomerID NVARCHAR(50) PRIMARY KEY, 
    FirstName NVARCHAR(50), 
    LastName NVARCHAR(50), 
    MailingAddressID NVARCHAR(50), 
    FOREIGN KEY (MailingAddressID) REFERENCES MailingAddress(MailingAddressID) 
); 
 
CREATE TABLE CustomerEmailAddress (     EmailID NVARCHAR(50) PRIMARY KEY, 
    EmailAddress NVARCHAR(50), 
    CustomerID NVARCHAR(50), 
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) 
); 
 
CREATE TABLE CustomerPhoneNumber ( 
PhoneID NVARCHAR(50) PRIMARY KEY, 
PhoneNumber NVARCHAR(50), 
    CustomerID NVARCHAR(50), 
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) 
); 
 
CREATE TABLE Reservation ( 
    ReservationID NVARCHAR(50) PRIMARY KEY, 
    ReservationNumber NVARCHAR(50), 
    ReservationDate DATE, 
    TravellingDate DATE, 
    SeatsReserved INT, 
    TotalCharges DECIMAL(10, 2), 
    ReservationStateID NVARCHAR(50), 
    CustomerID NVARCHAR(50), 
    TrainNumber NVARCHAR(50), 
    DepartureStation NVARCHAR(50), 
    DestinationStation NVARCHAR(50), 
    FOREIGN KEY (ReservationStateID) REFERENCES State(StateID), 
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID), 
    FOREIGN KEY (TrainNumber) REFERENCES Train(TrainNumber), 
    FOREIGN KEY (DepartureStation) REFERENCES TrainStation(StationID), 
    FOREIGN KEY (DestinationStation) REFERENCES TrainStation(StationID) 
); 


--Adding data for each entity

-- Insert data into "Track" 
INSERT INTO Track VALUES 
('T001', 'Northern Track', 'NA1709', 5), 
('T002', 'Southern Track', 'SA1865', 5), 
('T003', 'East Coast Track', 'CA8760', 3); 
 


-- Insert data into "Train" 
INSERT INTO Train VALUES 
('TN1001', 'Train A', '50', '150', 'T001'),
('TN1002', 'Train B', '45', '120', 'T001'), 
('TN1003', 'Train C', '40', '100', 'T001'), 
('TN1004', 'Train D', '35', '80', 'T002'),  
('TN1005', 'Train E', '30', '70', 'T002'),  
('TN1006', 'Train F', '25', '60', 'T002'), 
('TN1007', 'Train G', '20', '50', 'T002'),  
('TN1008', 'Train H', '15', '40', 'T002'), 
('TN1009', 'Train I', '10', '30', 'T003'),  
('TN1010', 'Train J', '05', '20', 'T003');  
 
 
 
-- Insert data into "TrainAttendant" 
INSERT INTO TrainAttendant VALUES 
('TA001', 'Alice Green', 'Attendant', 2800, '0123456789', '123 Elm St.'), 
('TA002', 'Bob Blue', 'Attendant', 3000, '0123456790', '456 Oak St.'), 
('TA003', 'Charlie Brown', 'Attendant', 3200, '0123456791', '789 Pine St.'), 
('TA004', 'David Black', 'Attendant', 3500, '0123456792', '101 Maple St.'), 
('TA005', 'Eve White', 'Attendant', 3700, '0123456793', '202 Birch St.'), 
('TA006', 'Frank Red', 'Attendant', 3900, '0123456794', '303 Cedar St.'), 
('TA007', 'Grace Pink', 'Attendant', 4100, '0123456795', '404 Spruce St.'), 
('TA008', 'Hank Yellow', 'Attendant', 4300, '0123456796', '505 Fir St.'), 
('TA009', 'Ivy Orange', 'Attendant', 4500, '0123456797', '606 Ash St.'), 
('TA010', 'Jack Purple', 'Attendant', 4700, '0123456798', '707 Willow St.'); 

-- Insert data into "Assigned" 
INSERT INTO Assigned VALUES 
('A001', 'TN1001', 'TA001'), 
('A002', 'TN1002', 'TA002'), 
('A003', 'TN1003', 'TA003'), 
('A004', 'TN1004', 'TA004'), 
('A005', 'TN1005', 'TA005'), 
('A006', 'TN1006', 'TA006'), 
('A007', 'TN1007', 'TA007'), 
('A008', 'TN1008', 'TA008'), 
('A009', 'TN1009', 'TA009'), 
('A010', 'TN1010', 'TA010'); 
 
-- Insert data into "State" 
INSERT INTO State VALUES 
('ST01', 'Kuala Lumpur'), 
('ST02', 'Penang'), 
('ST03', 'Johor'), 
('ST04', 'Kedah'), 
('ST05', 'Perak'), 
('ST06', 'Pahang'), 
('ST07', 'Kelantan'), 
('ST08', 'Terengganu'), 
('ST09', 'Malacca'), 
('ST10', 'Negeri Sembilan'); 
 
 
 
-- Insert data into "TrainStation" INSERT INTO TrainStation VALUES 
INSERT INTO TrainStation VALUES
('STA001', 'Kuala Lumpur Sentral', 'ST01'), 
('STA002', 'Butterworth', 'ST02'), 
('STA003', 'Johor Bahru Sentral', 'ST03'), 
('STA004', 'Alor Setar', 'ST04'), 
('STA005', 'Ipoh', 'ST05'), 
('STA006', 'Kuantan', 'ST06'), 
('STA007', 'Kota Bharu', 'ST07'), 
('STA008', 'Kuala Terengganu', 'ST08'), 
('STA009', 'Malacca Central', 'ST09'), 
('STA010', 'Seremban', 'ST10'); 
 
-- Insert data into "TrackState" 
INSERT INTO TrackState VALUES 
('TS001', 'T001', 'ST01'), 
('TS002', 'T001', 'ST02'), 
('TS003', 'T002', 'ST02'), 
('TS004', 'T002', 'ST03'), 
('TS005', 'T003', 'ST03'), 
('TS006', 'T003', 'ST04'); 
 
-- Insert data into "TrainOperator" 
INSERT INTO TrainOperator VALUES 
('TO001', 'John', 'Doe', 45, 20, 'Captain', 25000, 5500), 
('TO002', 'Jane', 'Doe', 38, 15, 'Co-Captain', 15000, 4800), 
('TO003', 'Michael', 'Smith', 42, 18, 'Captain', 21000, 5200), 
('TO004', 'Emily', 'Jones', 29, 7, 'Co-Captain', 9000, 4200), 
('TO005', 'Daniel', 'Brown', 47, 25, 'Captain', 33000, 6000), 
('TO006', 'Sophia', 'Davis', 33, 10, 'Co-Captain', 12500, 4600), 
('TO007', 'James', 'Miller', 40, 20, 'Captain', 23000, 5400), 
('TO008', 'Olivia', 'Wilson', 36, 12, 'Co-Captain', 17000, 4900), 
('TO009', 'William', 'Moore', 44, 22, 'Captain', 28000, 5600), 
('TO010', 'Ava', 'Taylor', 31, 8, 'Co-Captain', 10500, 4300),
('TO011', 'Ammer', 'Smith', 35, 10, 'Captain', 5000, 5500);

-- Insert data into "Operates" 
INSERT INTO Operates VALUES 
('O001', 'Captain', 'TN1001', 'TO001'), 
('O002', 'Co-Captain', 'TN1001', 'TO002'), 
('O003', 'Captain', 'TN1002', 'TO003'), 
('O004', 'Co-Captain', 'TN1002', 'TO004'), 
('O005', 'Captain', 'TN1003', 'TO005'), 
('O006', 'Co-Captain', 'TN1003', 'TO006'), 
('O007', 'Captain', 'TN1004', 'TO007'), 
('O008', 'Co-Captain', 'TN1004', 'TO008'), 
('O009', 'Captain', 'TN1005', 'TO009'), 
('O010', 'Co-Captain', 'TN1005', 'TO010'),
('O011', 'Captain', 'TN1001', 'TO011');
 
-- Insert data into "MailingAddress" 
INSERT INTO MailingAddress VALUES 
('MA001', '123 Elm St.', 'Kuala Lumpur', 'Wilayah Persekutuan', '50000', 'Malaysia'), 
('MA002', '456 Oak St.', 'Penang', 'Penang', '10000', 'Malaysia'), 
('MA003', '789 Pine St.', 'Johor', 'Johor', '80000', 'Malaysia'), 
('MA004', '101 Maple St.', 'Alor Setar', 'Kedah', '05000', 'Malaysia'), 
('MA005', '202 Birch St.', 'Ipoh', 'Perak', '30000', 'Malaysia'), 
('MA006', '303 Cedar St.', 'Kuantan', 'Pahang', '25000', 'Malaysia'), 
('MA007', '404 Spruce St.', 'Kota Bharu', 'Kelantan', '15000', 'Malaysia'), 
('MA008', '505 Fir St.', 'Kuala Terengganu', 'Terengganu', '20000', 'Malaysia'); 
 
-- Insert data into "Customer" 
INSERT INTO Customer VALUES 
('C001', 'Alice', 'Walker', 'MA001'), 
('C002', 'Bob', 'Smith', 'MA002'), 
('C003', 'Charlie', 'Johnson', 'MA003'), 
('C004', 'David', 'Brown', 'MA004'), 
('C005', 'Eva', 'Martinez', 'MA005'), 
('C006', 'Frank', 'Garcia', 'MA006'), 
('C007', 'Grace', 'Lopez', 'MA007'), 
('C008', 'Henry', 'Miller', 'MA008'); 
 
-- Insert data into "CustomerEmailAddress" 
INSERT INTO CustomerEmailAddress VALUES 
('CE001', 'alice.walker@example.com', 'C001'), 
('CE002', 'bob.smith@example.com', 'C002'), 
('CE003', 'charlie.johnson@example.com', 'C003'), 
('CE004', 'david.brown@example.com', 'C004'), 
('CE005', 'eva.martinez@example.com', 'C005'), 
('CE006', 'frank.garcia@example.com', 'C006'), 
('CE007', 'grace.lopez@example.com', 'C007'), 
('CE008', 'henry.miller@example.com', 'C008'); 
 
-- Insert data into "CustomerPhoneNumber" 
INSERT INTO CustomerPhoneNumber VALUES 
('CP001', '0123456789', 'C001'), 
('CP002', '0123456790', 'C002'), 
('CP003', '0123456791', 'C003'), 
('CP004', '0123456792', 'C004'), 
('CP005', '0123456793', 'C005'), 
('CP006', '0123456794', 'C006'), 
('CP007', '0123456795', 'C007'), 
('CP008', '0123456796', 'C008'); 
 
-- Insert data into "Reservation" 
INSERT INTO Reservation  VALUES 
('RES0001', 'RN0001', '2024-07-01', '2024-07-15', 2, 150.00, 'ST01', 'C001', 'TN1001', 'STA001', 'STA002'), 
('RES0002', 'RN0002', '2024-07-02', '2024-07-16', 3, 225.00, 'ST02', 'C002', 'TN1002', 'STA002', 'STA003'), 
('RES0003', 'RN0003', '2024-07-03', '2024-07-17', 1, 75.00, 'ST03', 'C003', 'TN1003', 'STA003', 'STA004'), 
('RES0004', 'RN0004', '2024-07-04', '2024-07-18', 4, 300.00, 'ST04', 'C004', 'TN1004', 'STA004', 'STA005'), 
('RES0005', 'RN0005', '2024-07-05', '2024-07-19', 2, 150.00, 'ST01', 'C001', 'TN1005', 'STA005', 'STA006'), 
('RES0006', 'RN0006', '2024-07-06', '2024-07-20', 3, 225.00, 'ST01', 'C001', 'TN1006', 'STA006', 'STA007'), 
('RES0007', 'RN0007', '2024-07-07', '2024-07-21', 1, 75.00, 'ST02', 'C002', 'TN1007', 'STA007', 'STA008'), 
('RES0008', 'RN0008', '2024-07-08', '2024-07-22', 4, 300.00, 'ST03', 'C003', 'TN1008', 'STA008', 'STA009'), 
('RES0009', 'RN0009', '2024-07-09', '2024-07-23', 2, 150.00, 'ST01', 'C001', 'TN1009', 'STA009', 'STA010'), 
('RES0010', 'RN0010', '2024-07-10', '2024-07-24', 3, 225.00, 'ST02', 'C002', 'TN1010', 'STA010', 'STA001'); 
 
 
 
 
-- Insert data into "Schedule" 
INSERT INTO Schedule VALUES 
('S001', '2024-08-01', '08:00', '2024-08-01', '12:00', 'STA001', 'STA002', 'TN1001'), 
('S002', '2024-08-02', '09:00', '2024-08-02', '13:00', 'STA002', 'STA003', 'TN1002'), 
('S003', '2024-08-03', '10:00', '2024-08-03', '14:00', 'STA003', 'STA004', 'TN1003'), 
('S004', '2024-08-04', '11:00', '2024-08-04', '15:00', 'STA004', 'STA005', 'TN1004'), 
('S005', '2024-08-05', '12:00', '2024-08-05', '16:00', 'STA005', 'STA006', 'TN1005'), 
('S006', '2024-08-06', '13:00', '2024-08-06', '17:00', 'STA006', 'STA007', 'TN1006'), 
('S007', '2024-08-07', '14:00', '2024-08-07', '18:00', 'STA007', 'STA008', 'TN1007'), 
('S008', '2024-08-08', '15:00', '2024-08-08', '19:00', 'STA008', 'STA009', 'TN1008'), 
('S009', '2024-08-09', '16:00', '2024-08-09', '20:00', 'STA009', 'STA010', 'TN1009'), 
('S010', '2024-08-10', '17:00', '2024-08-10', '21:00', 'STA010', 'STA001', 'TN1010'); 

 
 
--Q1 
SELECT AVG(Salary) AS AverageSalary 
FROM TrainOperator 
WHERE  LeadHours >= 15000; 
 
 
 --Q2
SELECT TrainOp.FirstName, TrainOp.LastName, TrainOp.Age, TrainOp.YearExperience, TrackSubquery.TrackName
FROM TrainOperator TrainOp
JOIN Operates O ON TrainOp.OperatorID = O.OperatorID
JOIN Train T ON O.TrainNumber = T.TrainNumber
JOIN (
    SELECT TR.TrackID, TR.TrackName
    FROM Track TR
    WHERE TR.TrackName = 'Northern Track'
) AS TrackSubquery ON T.TrackID = TrackSubquery.TrackID;
 
 
 
--Q3 
-- Find tracks with the greatest number of trains
WITH TrackCounts AS (
    SELECT TR.TrackName, COUNT(T.TrainNumber) AS NumberOfTrains
    FROM Train T
    JOIN Track TR ON T.TrackID = TR.TrackID
    GROUP BY TR.TrackName
),
MaxTrainCount AS (
    SELECT MAX(NumberOfTrains) AS MaxCount
    FROM TrackCounts
)
SELECT TC.TrackName, TC.NumberOfTrains
FROM TrackCounts TC
WHERE TC.NumberOfTrains = (SELECT MaxCount FROM MaxTrainCount);

 
 
--Q4 
SELECT C.FirstName, C.LastName
FROM Customer C
JOIN Reservation R ON C.CustomerID = R.CustomerID
GROUP BY C.FirstName, C.LastName
HAVING COUNT(R.ReservationID) > 2;
 
 
--Q5 
SELECT TA.FullName, TA.Position 
FROM TrainAttendant TA
JOIN Assigned A ON TA.AttendantID = A.AttendantID
JOIN Train T ON A.TrainNumber = T.TrainNumber
JOIN Operates O ON T.TrainNumber = O.TrainNumber
JOIN TrainOperator TrainOp ON O.OperatorID = TrainOp.OperatorID
WHERE TrainOp.FirstName = 'Ammer';
 
 
 
 
--Q6 
SELECT C.FirstName, C.LastName, S.StateName AS CustomerState 
FROM Customer C 
JOIN MailingAddress MA ON C.MailingAddressID = MA.MailingAddressID 
JOIN State S ON MA.State = S.StateName 
JOIN TrainStation TS ON TS.StateID = S.StateID 
WHERE TS.StationID IN ( 
    SELECT DISTINCT OriginStationID 
    FROM Schedule 
    UNION 
    SELECT DISTINCT DestinationStationID 
    FROM Schedule 
); 
 
 
--Q7 
SELECT TrainNumber, BusinessSeats 
FROM Train 
WHERE BusinessSeats = (
  SELECT MAX(BusinessSeats) 
  FROM Train
);

 
  
--Q8 
SELECT C.FirstName, C.LastName 
FROM Customer C 
LEFT JOIN Reservation R ON C.CustomerID = R.CustomerID 
WHERE R.ReservationID IS NULL 
ORDER BY C.CustomerID DESC; 
 
 
 
--Q9 
SELECT TR.TrackID, TR.TrackName, COUNT(T.TrainNumber) AS TotalNumberOfTrains 
FROM Track TR 
LEFT JOIN Train T ON TR.TrackID = T.TrackID 
GROUP BY TR.TrackID, TR.TrackName;
 

--Q10 
SELECT FullName, Position 
FROM TrainAttendant 
WHERE Salary NOT IN (2800, 3500); 
 
--Q11 
WITH ReservationCounts AS ( 
    SELECT C.FirstName, C.LastName, COUNT(R.ReservationID) AS TotalReservations 
    FROM Customer C 
    JOIN Reservation R ON C.CustomerID = R.CustomerID 
    GROUP BY C.FirstName, C.LastName 
) 
SELECT FirstName, LastName, TotalReservations 
FROM ReservationCounts 
WHERE TotalReservations = (SELECT MAX(TotalReservations) FROM ReservationCounts); 



--Q12
SELECT R.ReservationID, R.ReservationNumber, R.ReservationDate, R.TravellingDate, R.SeatsReserved, R.TotalCharges, 
       R.DepartureStation, R.DestinationStation, R.TrainNumber
FROM Reservation R
JOIN Customer C ON R.CustomerID = C.CustomerID
WHERE C.FirstName = 'David' AND C.LastName = 'Brown';
