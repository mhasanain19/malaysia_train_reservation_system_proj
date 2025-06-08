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