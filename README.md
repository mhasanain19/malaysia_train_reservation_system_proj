# malaysia_train_reservation_system_proj
making the data base structure using SQL

# SQLassignment – Train Reservation and Management System

Welcome to the **SQLassignment** project! This database system models a complete Train Reservation and Management System, including tracks, trains, staff, stations, customers, and bookings.

## 📦 Project Structure

This project contains:

* A relational database named **SQLassignment**
* 14 normalized tables with relationships
* Sample data for all tables

## 🛠️ Technologies Used

* SQL (Structured Query Language)
* MySQL or any compatible RDBMS

## 📋 Tables Overview

### 1. Track

* Stores track information
* Primary Key: `TrackID`

### 2. Train

* Stores train details (name, seating, type, etc.)
* Foreign Key: `TrackID`

### 3. TrainAttendant

* Stores attendant staff information
* Primary Key: `AttendantID`

### 4. Assigned

* Maps attendants to trains
* Foreign Keys: `TrainNumber`, `AttendantID`

### 5. State

* Malaysian states
* Primary Key: `StateID`

### 6. TrainStation

* Stores station information
* Foreign Key: `StateID`

### 7. TrackState

* States covered by each track
* Foreign Keys: `TrackID`, `StateID`

### 8. Schedule

* Train schedules and routes
* Foreign Keys: `TrainNumber`, `OriginStationID`, `DestinationStationID`

### 9. TrainOperator

* Information on captains and co-captains
* Primary Key: `OperatorID`

### 10. Operates

* Operator-train assignment
* Foreign Keys: `TrainNumber`, `OperatorID`

### 11. MailingAddress

* Address details for customers
* Primary Key: `MailingAddressID`

### 12. Customer

* Customer information
* Foreign Key: `MailingAddressID`

### 13. CustomerEmailAddress

* Customer email contact
* Foreign Key: `CustomerID`

### 14. CustomerPhoneNumber

* Customer phone contact
* Foreign Key: `CustomerID`

### 15. Reservation

* Reservation details
* Foreign Keys: `CustomerID`, `TrainNumber`, `ReservationStateID`, `DepartureStation`, `DestinationStation`

## 📁 How to Use

1. Open your SQL environment
2. Create the database: `CREATE DATABASE SQLassignment;`
3. Use the database: `USE SQLassignment;`
4. Run the SQL script to create and populate tables

## 👥 Contributors
Created by: *\[mhasanain19 & aboodhasanain]*

---

Thank you for visiting this project!
