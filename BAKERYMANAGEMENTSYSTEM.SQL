MariaDB [(none)]> CREATE DATABASE BakerySuppliesDB;
Query OK, 1 row affected (0.002 sec)

MariaDB [(none)]> USE BakerySuppliesDB;
Database changed
MariaDB [BakerySuppliesDB]> SHOW DATABASES
    -> SHOW DATABASES;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'SHOW DATABASES' at line 2
MariaDB [BakerySuppliesDB]> SHOW DATABASES;
+------------------------+
| Database               |
+------------------------+
| BCS25                  |
| BakeryManagement       |
| BakeryManagementDB     |
| BakeryManagementSystem |
| BakerySuppliesDB       |
| LIBRARYDB              |
| LibraryDB              |
| Southwind              |
| home                   |
| information_schema     |
| mysql                  |
| performance_schema     |
| phpmyadmin             |
| test                   |
+------------------------+
14 rows in set (0.001 sec)

MariaDB [BakerySuppliesDB]> CREATE TABLE Suppliers (
    ->     SupplierID INT AUTO_INCREMENT PRIMARY KEY,
    ->     SupplierName VARCHAR(100) NOT NULL,
    ->     ContactPerson VARCHAR(100),
    ->     PhoneNumber VARCHAR(15),
    ->     Email VARCHAR(100)
    -> );
Query OK, 0 rows affected (0.028 sec)

MariaDB [BakerySuppliesDB]> DESC Suppliers;
+---------------+--------------+------+-----+---------+----------------+
| Field         | Type         | Null | Key | Default | Extra          |
+---------------+--------------+------+-----+---------+----------------+
| SupplierID    | int(11)      | NO   | PRI | NULL    | auto_increment |
| SupplierName  | varchar(100) | NO   |     | NULL    |                |
| ContactPerson | varchar(100) | YES  |     | NULL    |                |
| PhoneNumber   | varchar(15)  | YES  |     | NULL    |                |
| Email         | varchar(100) | YES  |     | NULL    |                |
+---------------+--------------+------+-----+---------+----------------+
5 rows in set (0.007 sec)

MariaDB [BakerySuppliesDB]> CREATE TABLE Ingredients (
    ->     IngredientID INT AUTO_INCREMENT PRIMARY KEY,
    ->     IngredientName VARCHAR(100) NOT NULL,
    ->     Unit VARCHAR(20), -- e.g., 'kg', 'grams', 'liters'
    ->     CurrentStock DECIMAL(10, 2),
    ->     ReorderLevel DECIMAL(10, 2) -- Alert level for low stock
    -> );DESC Ingredients;
Query OK, 0 rows affected (0.019 sec)

+----------------+---------------+------+-----+---------+----------------+
| Field          | Type          | Null | Key | Default | Extra          |
+----------------+---------------+------+-----+---------+----------------+
| IngredientID   | int(11)       | NO   | PRI | NULL    | auto_increment |
| IngredientName | varchar(100)  | NO   |     | NULL    |                |
| Unit           | varchar(20)   | YES  |     | NULL    |                |
| CurrentStock   | decimal(10,2) | YES  |     | NULL    |                |
| ReorderLevel   | decimal(10,2) | YES  |     | NULL    |                |
+----------------+---------------+------+-----+---------+----------------+
5 rows in set (0.005 sec)

MariaDB [BakerySuppliesDB]> CREATE TABLE Staff (
    ->     StaffID INT AUTO_INCREMENT PRIMARY KEY,
    ->     FirstName VARCHAR(50),
    ->     LastName VARCHAR(50),
    ->     JobRole VARCHAR(50)
    -> );DESC Staff;
Query OK, 0 rows affected (0.018 sec)

+-----------+-------------+------+-----+---------+----------------+
| Field     | Type        | Null | Key | Default | Extra          |
+-----------+-------------+------+-----+---------+----------------+
| StaffID   | int(11)     | NO   | PRI | NULL    | auto_increment |
| FirstName | varchar(50) | YES  |     | NULL    |                |
| LastName  | varchar(50) | YES  |     | NULL    |                |
| JobRole   | varchar(50) | YES  |     | NULL    |                |
+-----------+-------------+------+-----+---------+----------------+
4 rows in set (0.004 sec)

MariaDB [BakerySuppliesDB]> CREATE TABLE Supply_Orders (
    ->     OrderID INT AUTO_INCREMENT PRIMARY KEY,
    ->     OrderDate DATE,
    ->     SupplierID INT,
    ->     StaffID INT,
    ->     FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID),
    ->     FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
    -> );DESC Supply_Orders;
Query OK, 0 rows affected (0.024 sec)

+------------+---------+------+-----+---------+----------------+
| Field      | Type    | Null | Key | Default | Extra          |
+------------+---------+------+-----+---------+----------------+
| OrderID    | int(11) | NO   | PRI | NULL    | auto_increment |
| OrderDate  | date    | YES  |     | NULL    |                |
| SupplierID | int(11) | YES  | MUL | NULL    |                |
| StaffID    | int(11) | YES  | MUL | NULL    |                |
+------------+---------+------+-----+---------+----------------+
4 rows in set (0.004 sec)

MariaDB [BakerySuppliesDB]> CREATE TABLE Order_Details (
    ->     OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    ->     OrderID INT,
    ->     IngredientID INT,
    ->     QuantityOrdered DECIMAL(10, 2),
    ->     UnitPrice DECIMAL(10, 2),
    ->     FOREIGN KEY (OrderID) REFERENCES Supply_Orders(OrderID),
    ->     FOREIGN KEY (IngredientID) REFERENCES Ingredients(IngredientID)
    -> );DESC Order_Details;
Query OK, 0 rows affected (0.029 sec)

+-----------------+---------------+------+-----+---------+----------------+
| Field           | Type          | Null | Key | Default | Extra          |
+-----------------+---------------+------+-----+---------+----------------+
| OrderDetailID   | int(11)       | NO   | PRI | NULL    | auto_increment |
| OrderID         | int(11)       | YES  | MUL | NULL    |                |
| IngredientID    | int(11)       | YES  | MUL | NULL    |                |
| QuantityOrdered | decimal(10,2) | YES  |     | NULL    |                |
| UnitPrice       | decimal(10,2) | YES  |     | NULL    |                |
+-----------------+---------------+------+-----+---------+----------------+
5 rows in set (0.004 sec)


