DROP DATABASE AmazonBrands_db;

CREATE SCHEMA AmazonBrands_db;
USE AmazonBrands_db;

CREATE TABLE Brand (
    Brand_ID INT PRIMARY KEY,     
    Brand_Name VARCHAR(255) NOT NULL,            
    Registered_Date DATE NOT NULL,               
    Contact_Person VARCHAR(255) NOT NULL,        
    Email VARCHAR(255) NOT NULL UNIQUE,          
    Phone_Number VARCHAR(20) NOT NULL,           
    Brand_Status ENUM('active', 'suspended') NOT NULL, 
    Number_of_Products INT DEFAULT 0             
);

CREATE TABLE Product (
    Product_ID INT PRIMARY KEY,          
    Product_Name VARCHAR(255) NOT NULL,                 
    Transparency_Code ENUM('Green', 'Red') NOT NULL,    
    Launch_Date DATE NOT NULL,                          
    Status ENUM('Available', 'Unavailable') NOT NULL,         
    Units_Sold INT DEFAULT 0,                           
    Number_of_Complaints INT DEFAULT 0,                 
    Category ENUM('Electronic', 'Clothing', 'Furniture') NOT NULL, 
    Brand_ID INT,                                           
    FOREIGN KEY (Brand_ID) REFERENCES Brand(Brand_ID)
);

CREATE TABLE Electronic (
    EProductID INT PRIMARY KEY,                
    Warranty_Period VARCHAR(50) NOT NULL,     
    Model_Number VARCHAR(255) NOT NULL,       
    FOREIGN KEY (EProductID) REFERENCES Product(Product_ID) 
);

CREATE TABLE Clothing (
    CProductID INT PRIMARY KEY,                
    Size VARCHAR(50) NOT NULL,                
    Color VARCHAR(50) NOT NULL,               
    FOREIGN KEY (CProductID) REFERENCES Product(Product_ID) 
);

CREATE TABLE Furniture (
    FProductID INT PRIMARY KEY,               
    Material VARCHAR(255) NOT NULL,           
    Weight DECIMAL(10, 2) NOT NULL,           
    FOREIGN KEY (FProductID) REFERENCES Product(Product_ID) 
);

CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(255) NOT NULL,
    Customer_Email VARCHAR(255) NOT NULL UNIQUE,
    Phone_Number VARCHAR(20) NOT NULL,
    Customer_Address VARCHAR(255) NOT NULL,
    Registration_Date DATE NOT NULL
);

CREATE TABLE Transaction (
    Transaction_ID INT AUTO_INCREMENT PRIMARY KEY,
    Transaction_Date DATE NOT NULL,
    Quantity INT NOT NULL,
    Total_Amount DECIMAL(10, 2) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Customer_ID INT NOT NULL,
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
);

CREATE TABLE Matching_Product_Transaction (
    Product_ID INT NOT NULL,
    Transaction_ID INT NOT NULL,
    PRIMARY KEY (Product_ID, Transaction_ID),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
    FOREIGN KEY (Transaction_ID) REFERENCES Transaction(Transaction_ID)
);

CREATE TABLE Customer_Purchase_History (
    Customer_ID INT NOT NULL,
    PurchaseHistory VARCHAR(255) NOT NULL,
    PRIMARY KEY (Customer_ID, PurchaseHistory),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
);

CREATE TABLE Complaint (
    Complaint_ID INT PRIMARY KEY,
    Complaint_Date DATE NOT NULL,
    Complaint_Description TEXT NOT NULL,
    Complaint_Status ENUM('Closed', 'Rejected', 'In Progress') NOT NULL,
    Resolution_Date DATE DEFAULT NULL,
    Customer_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);

CREATE TABLE Investigation (
    Investigation_ID INT PRIMARY KEY,
    Investigation_Start_Date DATE NOT NULL,
    Assigned_Person VARCHAR(255) NOT NULL,
    Investigation_Status ENUM('Open', 'In Progress', 'Complete') NOT NULL,
    Findings TEXT DEFAULT NULL,
    Conclusion TEXT DEFAULT NULL,
    Complaint_ID INT NOT NULL,
    FOREIGN KEY (Complaint_ID) REFERENCES Complaint(Complaint_ID)
);

CREATE TABLE Enforcement_Action (
    Action_ID INT PRIMARY KEY,
    Action_Date DATE NOT NULL,
    Action_Status ENUM('Approved', 'Rejected', 'On Hold') NOT NULL,
    Outcome TEXT DEFAULT NULL,
    Action_Type ENUM('Legal', 'Operational') NOT NULL,
    Investigation_ID INT NOT NULL,
    FOREIGN KEY (Investigation_ID) REFERENCES Investigation(Investigation_ID)
);
CREATE TABLE Legal_Action (
    LActionID INT PRIMARY KEY,
    Penalty_Amount DECIMAL(10, 2) DEFAULT NULL,
    Legal_Warning TEXT DEFAULT NULL,
    Court_Involvement BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (LActionID) REFERENCES Enforcement_Action(Action_ID)
);

CREATE TABLE Operational_Action (
    OActionID INT PRIMARY KEY,
    Hold_Transactions BOOLEAN DEFAULT FALSE,
    Remove_Listing BOOLEAN DEFAULT FALSE,
    Block_Account BOOLEAN DEFAULT FALSE,
    Blacklist_Seller BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (OActionID) REFERENCES Enforcement_Action(Action_ID)
);

INSERT INTO Brand (Brand_ID, Brand_Name, Registered_Date, Contact_Person, Email, Phone_Number, Brand_Status, Number_of_Products)
VALUES
(1, 'Apple Store', '2022-01-23', 'Benn Palke', 'Benn.p@apple.com', '(757) 911-7615', 'active', 2),
(2, 'Amazon', '2022-01-31', 'Claudell Philipeaux', 'Claudellphilip@amazon', '(661) 723-1854', 'active', 2),
(3, 'Real Amazon', '2022-02-18', 'Jeffy Bezos', 'Realjeff1994@yahoo.com', '(724) 312-4018', 'suspended', 3),
(4, 'Zara', '2022-04-29', 'Saundra Blaza', 'Saundra.b@zara.com', '(614) 128-4933', 'active', 1),
(5, 'Levi', '2022-06-14', 'Orelie Deye', 'Orelie.d@levi.com', '(254) 744-3498', 'active', 1),
(6, 'Lulu Lemonade', '2022-06-30', 'Taylor Swiffy', 'Cruelwinter@gmail.com', '(412) 293-2916', 'active', 2),
(7, 'IKEA', '2022-07-28', 'Cissiee Buttel', 'Cissiee1980@ikea.com', '(702) 211-4848', 'active', 1),
(8, 'Lowe', '2022-07-29', 'Sebastien Farfolomeev', 'Sebastien.far@lowe.com', '(202) 776-0642', 'active', 1),
(9, 'Pottery Barn', '2022-10-15', 'Mychal Leitch', 'Mychal.leitch@potterybarn.com', '(203) 276-8548', 'active', 1),
(10, 'Addidas', '2022-10-31', 'Ollie Sidnell', 'ollie.sidnell@addidas.com', '(915) 494-8354', 'active', 1),
(11, 'Home Living', '2022-12-23', 'Cleavland Frankiss', 'cleavland.frankiss@live.com', '(813) 460-8860', 'active', 1),
(12, 'Samsung', '2023-01-01', 'Horton Quarrington', 'horton.quarrington@samsung.com', '(305) 035-3258', 'active', 1),
(13, 'Abercrombie', '2023-02-01', 'Anissa Chmarny', 'anissa.chmarny@abercrombie.com', '(417) 168-0567', 'active', 1);

INSERT INTO Product (Product_ID, Brand_ID, Product_Name, Transparency_Code, Category, Launch_Date, Status, Units_Sold, Number_of_Complaints)
VALUES
(1, 1, 'iPhone 16 charger', 'Green', 'Electronic', '2023-05-08', 'Available', 638902, 638),
(2, 1, 'Macbook pro', 'Green', 'Electronic', '2023-08-08', 'Available', 954687, 954),
(3, 2, 'Alexa', 'Green', 'Electronic', '2023-10-04', 'Available', 91802, 91),
(4, 2, 'Alexa 2.0', 'Green', 'Electronic', '2023-11-20', 'Available', 792609, 500),
(5, 3, 'Alexa pro plus', 'Red', 'Electronic', '2024-01-01', 'Available', 595603, 99000),
(6, 3, 'Alexa 16 plus', 'Red', 'Electronic', '2024-01-06', 'Available', 748602, 315000),
(7, 3, 'Alexa with Siri', 'Red', 'Electronic', '2024-01-11', 'Available', 548189, 255000),
(8, 4, 'Red Christmas sweat', 'Green', 'Clothing', '2024-01-27', 'Available', 951980, 951),
(9, 5, 'Blue jean', 'Green', 'Clothing', '2024-03-25', 'Available', 820671, 820),
(10, 6, 'Tayloy Swift T-shirt', 'Green', 'Clothing', '2024-04-04', 'Available', 797987, 45000),
(11, 6, 'Red sock', 'Green', 'Clothing', '2024-04-12', 'Available', 565584, 50000),
(12, 7, 'Dinning table', 'Green', 'Furniture', '2024-05-05', 'Available', 947860, 947),
(13, 8, 'Bed frame', 'Green', 'Furniture', '2024-06-03', 'Available', 882804, 882),
(14, 9, 'Shoe rack', 'Green', 'Furniture', '2024-06-06', 'Available', 979317, 979),
(15, 10, 'Stan Smith short', 'Green', 'Clothing', '2024-06-25', 'Available', 156017, 156),
(16, 10, 'Addidas Sportswear', 'Green', 'Clothing', '2024-06-29', 'Available', 491050, 491),
(17, 11, 'Benchwright Extending Dining Table', 'Green', 'Furniture', '2024-07-08', 'Available', 550407, 550),
(18, 10, 'Essential Sweatpant', 'Green', 'Clothing', '2024-07-12', 'Available', 884410, 884),
(19, 12, 'Galaxy Buds3 Pro', 'Green', 'Electronic', '2024-07-19', 'Available', 941468, 941),
(20, 13, 'Sherpa-Lined Zip Workwear Jacket', 'Green', 'Clothing', '2024-08-15', 'Available', 668379, 668);

INSERT INTO Electronic (EProductID, Warranty_Period, Model_Number)
VALUES 
(1, 12, 'IX0437-E1'),
(2, 12, 'GU4981-G6'),
(3, 24, 'BG0663-T0'),
(4, 24, 'DP8553-B7'),
(5, 6, 'BP5935-M4'),
(6, 6, 'BD3907-O9'),
(7, 3, 'BE4265-D4'),
(19, 12, 'SSB2024-A2');

INSERT INTO Clothing (CProductID, Size, Color)
VALUES 
(8, 'XXL', 'Red'),
(9, 'S', 'Blue'),
(10, 'M', 'Red'),
(11, 'M', 'Red'),
(15, 'L', 'Green'),
(16, 'L', 'Black'),
(18, 'L', 'Base'),
(20, 'S', 'Pink');

INSERT INTO Furniture (FProductID, Material, Weight)
VALUES 
(12, 'Plastic', 214),
(13, 'Wood', 250),
(14, 'Bamboo', 745),
(17, 'Wood', 1000);

INSERT INTO Customer (Customer_ID, Customer_Name, Customer_Email, Phone_Number, Customer_Address, Registration_Date) 
VALUES 
(1, 'Karmen Tizard', 'karmen.tizard@gmail.com', '(309) 565-6638', '5760 Grey Dove Lane, Peoria, Illinois, United States, 61651', '2023-04-04'),
(2, 'Ky Rasher', 'ky.rasher@hotmail.fr', '(816) 632-7665', '7990 Black Stone Place, Kansas City, Missouri, United States, 64130', '2023-05-29'),
(3, 'Raynor Meffin', 'raynor.meffin@gmail.com', '(254) 513-1733', '13683 Venable Court, Waco, Texas, United States, 76705', '2023-10-15'),
(4, 'Judye Pebworth', 'judye.pebworth@yahoo.com', '(228) 970-7444', '1385 Peachtree Avenue, Biloxi, Mississippi, United States, 39534', '2023-12-19'),
(5, 'Whittaker Press', 'whittaker.press@t-online.de', '(212) 774-6875', '8223 Dyals Court, New York City, New York, United States, 10260', '2023-06-03'),
(6, 'Daveta OLoughlin', 'daveta.oloughlin@wanadoo.fr', '(310) 013-0875', '9959 Charlene Place, Palo Alto, California, United States, 94302', '2023-07-16'),
(7, 'Matthus DAlessio', 'matthus.dalessio@gmail.com', '(412) 253-3093', '8492 Donna Avenue, Pittsburgh, Pennsylvania, United States, 15220', '2023-06-10'),
(8, 'Delly Falvey', 'delly.falvey@yahoo.com', '(860) 309-7698', '1530 Thistledown Way, West Hartford, Connecticut, United States, 06127', '2023-12-23'),
(9, 'Eirena Benneton', 'eirena.benneton@gmail.com', '(304) 534-8410', '11399 Barnhill Lane, Huntington, West Virginia, United States, 25716', '2023-08-20'),
(10, 'Khalil Warrack', 'khalil.warrack@tiscali.it', '(484) 484-9924', '10997 Linden Lane, Reading, Pennsylvania, United States, 19605', '2023-08-10'),
(11, 'Archaimbaud Tointon', 'archaimbaud.tointon@hotmail.fr', '(937) 875-2039', '2522 Janeann Terrace, Dayton, Ohio, United States, 45403', '2024-09-23'),
(12, 'Tailor Yann', 'tailor.yann@yahoo.com', '(952) 949-6006', '9687 Huckleberry Street, Young America, Minnesota, United States, 55573', '2024-10-07'),
(13, 'Ban Blanchette', 'ban.blanchette@yahoo.com', '(831) 867-0228', '10710 Oxbow Drive, Santa Cruz, California, United States, 95064', '2024-07-02'),
(14, 'Lyda Cardon', 'lyda.cardon@gmail.com', '(775) 724-2859', '13248 Dillon Lane, Reno, Nevada, United States, 89505', '2024-07-30'),
(15, 'Lindsey Whytock', 'lindsey.whytock@hotmail.com', '(818) 467-9430', '9953 Varnville Way, Glendale, California, United States, 91205', '2024-05-26');

INSERT INTO Transaction (Transaction_ID, Customer_ID, Transaction_Date, Quantity, Price, Total_Amount)
VALUES 
(1, 1, '2024-01-08', 3, 50, 150),
(2, 1, '2024-02-08', 1, 1500, 1500),
(3, 2, '2024-02-11', 5, 80, 400),
(4, 3, '2024-03-11', 2, 100, 200),
(5, 4, '2024-04-11', 5, 15, 75),
(6, 5, '2024-04-11', 3, 20, 60),
(7, 6, '2024-05-15', 4, 30, 120),
(8, 7, '2024-06-11', 1, 150, 150),
(9, 7, '2024-06-19', 1, 129, 129),
(10, 8, '2024-06-29', 1, 200, 200),
(11, 9, '2024-07-29', 4, 5, 20),
(12, 10, '2024-08-20', 1, 550, 550),
(13, 10, '2024-08-23', 1, 650, 650),
(14, 10, '2024-08-22', 2, 150, 300),
(15, 10, '2024-08-24', 2, 5, 10),
(16, 11, '2024-08-25', 1, 229, 229),
(17, 12, '2024-08-26', 2, 115, 230),
(18, 13, '2024-08-27', 1, 1499, 1499),
(19, 12, '2024-08-18', 1, 99, 99),
(20, 14, '2024-08-29', 1, 199, 199),
(21, 15, '2024-08-30', 1, 169, 169);

INSERT INTO Matching_Product_Transaction (Product_ID, Transaction_ID)
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(11, 15),
(15, 16),
(16, 17),
(17, 18),
(18, 19),
(19, 20),
(20, 21);

INSERT INTO Customer_Purchase_History (Customer_ID, PurchaseHistory)
VALUES 
(1, 'iPhone 16 charger'),
(1, 'Macbook pro'),
(2, 'Alexa'),
(3, 'Alexa 2.0'),
(4, 'Alexa pro plus'),
(5, 'Alexa 16 plus'),
(6, 'Alexa with Siri'),
(7, 'Red Christmas sweat'),
(7, 'Blue jean'),
(8, 'Tayloy Swift T-shirt'),
(9, 'Red sock'),
(10, 'Dinning table'),
(10, 'Bed frame'),
(10, 'Shoe rack'),
(10, 'Red sock'),
(11, 'Stan Smith short'),
(12, 'Addidas Sportswear'),
(13, 'Benchwright Extending Dining Table'),
(12, 'Essential Sweatpant'),
(14, 'Galaxy Buds3 Pro'),
(15, 'Sherpa-Lined Zip Workwear Jacket');

INSERT INTO Complaint (Complaint_ID, Customer_ID, Product_ID, Complaint_Date, Complaint_Description, Complaint_Status, Resolution_Date)
VALUES
(1, 4, 5, '2024-04-13', 'Alexa cannot connect to wifi', 'Closed', '2024-05-13'),
(2, 5, 6, '2024-04-15', 'I call Alexa name but it does not respond to my command', 'Closed', '2024-05-15'),
(3, 6, 7, '2024-05-22', 'The Alexa is broken after I bought it only a week ago', 'Closed', '2024-06-04'),
(4, 8, 10, '2024-07-03', 'This is not a product from Lululemon. The finishing is very bad', 'Rejected', '2024-08-16'),
(5, 9, 11, '2024-08-03', 'They are orange, not red!', 'In Progress', NULL),
(6, 10, 11, '2024-08-25', 'They are not red socks', 'In Progress', NULL),
(7, 11, 15, '2024-09-23', 'The green color of the short is not what I expected', 'Rejected', '2024-09-25'),
(8, 13, 17, '2024-09-24', 'The table height is much higher than the picture on Amazon', 'Closed', '2024-10-01'),
(9, 14, 19, '2024-09-26', 'The battery of earbuds is running out fast. It does not last 8 hours as marketed.', 'Closed', '2024-10-15'),
(10, 15, 20, '2024-09-27', 'The jacket is slightly bigger.', 'In Progress', NULL);

INSERT INTO Investigation (Investigation_ID, Investigation_Start_Date, Assigned_Person, Investigation_Status, Findings, Conclusion, Complaint_ID)
VALUES 
(1, '2024-04-16', 'Mitchael Keeney', 'Complete', 'Product imported with falsified documents', 'Legal action initiated', 1),
(2, '2024-04-18', 'Joscelin Cobleigh', 'Complete', 'Unauthorized seller', 'Seller account suspended', 2),
(3, '2024-05-26', 'Mindy Greenrde', 'Complete', 'Unauthorized seller', 'Seller account suspended', 3),
(4, '2024-08-15', 'Phyllys Cridlin', 'Complete', 'Not listed as a Lululemon seller', 'No action required', 4),
(5, '2024-08-25', 'Sherri Vurley', 'Open', NULL, NULL, 5),
(6, '2024-08-25', 'Jakob Bruffell', 'Open', NULL, NULL, 6),
(7, '2024-09-23', 'Gaby Alexis', 'Complete', 'Color matches product description', NULL, 7),
(8, '2024-09-24', 'Tally Tapenden', 'Complete', 'Table height off by 5 cm', NULL, 8),
(9, '2024-09-26', 'Alexandrina Spurden', 'Complete', 'Battery drains faster than expected', NULL, 9),
(10, '2024-09-27', 'Brnaby Terbeek', 'Open', NULL, NULL, 10);

INSERT INTO Enforcement_Action (Action_ID, Action_Date, Action_Status, Outcome, Action_Type, Investigation_ID)
VALUES 
(1, '2024-05-13', 'Approved', 'Legal actions executed', 'Legal', 1),
(2, '2024-05-15', 'Approved', 'Seller account suspended', 'Legal', 2),
(3, '2024-06-04', 'Approved', 'Seller account suspended', 'Legal', 3),
(4, '2024-09-15', 'Rejected', 'Seller intent not fraudulent', 'Operational', 4),
(5, '2024-09-25', 'On Hold', NULL, 'Operational', 5),
(6, '2024-09-25', 'On Hold', NULL, 'Operational', 6),
(7, '2024-09-25', 'Rejected', 'Seller intent not fraudulent', 'Operational', 7),
(8, '2024-10-01', 'Approved', 'Hold transaction until quality improves', 'Operational', 8),
(9, '2024-10-15', 'Approved', 'Hold transaction until quality improves', 'Operational', 9);

INSERT INTO Legal_Action (LActionID, Penalty_Amount, Legal_Warning, Court_Involvement)
VALUES 
(1, 100000, 'Falsified documentation.', 1),
(2, 75000, '1st degree false branding.', 0),
(3, 50000, '2nd degree false branding.', 0);

INSERT INTO Operational_Action (OActionID, Hold_Transactions, Remove_Listing, Block_Account, Blacklist_Seller)
VALUES 
(4, 0, 0, 0, 0),
(5, 1, 0, 0, 0),
(6, 1, 0, 0, 0),
(7, 0, 0, 0, 0),
(8, 1, 0, 1, 1),
(9, 1, 0, 1, 1);


-- Questions
-- 1. Are there specific product categories more prone to fraud?
SELECT 
    p.Category,
    SUM(p.Units_Sold) AS Total_Units_Sold,
    SUM(p.Number_of_Complaints) AS Total_Complaints,
    ROUND((SUM(p.Number_of_Complaints) / SUM(p.Units_Sold)) * 100, 2) AS Complaint_Rate
FROM 
    Product p
GROUP BY 
    p.Category
ORDER BY 
    Complaint_Rate DESC;

-- 2. Are there any seasonal trends in complaint rates?
SELECT 
    MONTH(c.Complaint_Date) AS Complaint_Month,
    COUNT(c.Complaint_ID) AS Total_Complaints,
    ROUND(COUNT(c.Complaint_ID) * 100.0 / (SELECT COUNT(*) FROM Complaint), 2) AS Complaint_Percentage
FROM 
    Complaint c
GROUP BY 
    Complaint_Month


-- 3. Which brands in these categories contribute to the high number of complaints?
SELECT 
    b.Brand_Name,
    p.Category,
    SUM(p.Units_Sold) AS Total_Units_Sold,
    SUM(p.Number_of_Complaints) AS Total_Complaints,
    ROUND((SUM(p.Number_of_Complaints) / SUM(p.Units_Sold)) * 100, 2) AS Complaint_Rate
FROM 
    Brand b
JOIN 
    Product p ON b.Brand_ID = p.Brand_ID
WHERE 
    p.Category IN ('Electronic', 'Clothing')
GROUP BY 
    b.Brand_Name, p.Category
ORDER BY 
	Category,
    Complaint_Rate DESC;

-- 4. Who is the contact person for these problematic brands?
SELECT 
    b.Brand_Name,
    b.Contact_Person,
    b.Email,
    b.Phone_Number
FROM 
    Brand b
WHERE 
    b.Brand_Name IN ('Real Amazon', 'Lulu Lemonade');



-- 5. What are the specific customer complaints about these brands?
SELECT 
    c.Complaint_ID,
    c.Complaint_Description,
    c.Complaint_Status,
    c.Resolution_Date,
    p.Product_Name,
    b.Brand_Name
FROM 
    Complaint c
JOIN 
    Product p ON c.Product_ID = p.Product_ID
JOIN 
    Brand b ON p.Brand_ID = b.Brand_ID
WHERE 
    b.Brand_Name IN ('Real Amazon', 'Lulu Lemonade');

-- 6. Have we taken any action to investigate these brands?
SELECT 
    i.Investigation_ID, i.Assigned_Person, i.Investigation_Status,
    i.Findings, i.Conclusion, b.Brand_Name
FROM 
    Investigation i
JOIN 
    Complaint c ON i.Complaint_ID = c.Complaint_ID
JOIN 
    Product p ON c.Product_ID = p.Product_ID
JOIN 
    Brand b ON p.Brand_ID = b.Brand_ID
WHERE 
    b.Brand_Name IN ('Real Amazon', 'Lulu Lemonade');

-- 7. What is the average time taken to investigate and close complaints?
SELECT 
    ROUND(AVG(DATEDIFF(c.Resolution_Date, c.Complaint_Date)), 2) AS Avg_Resolution_Time,
    ROUND(AVG(DATEDIFF(i.Investigation_Start_Date, c.Complaint_Date)), 2) AS Avg_Investigation_Start_Time
FROM 
    Complaint c
JOIN 
    Investigation i ON c.Complaint_ID = i.Complaint_ID
WHERE 
    c.Complaint_Status = 'Closed';
    

    

-- Final Question: "How effective is the current complaint resolution and investigation process in mitigating high-risk products and protecting the brand's reputation?"
SELECT 
    ROUND((SUM(CASE WHEN c.Complaint_Status = 'Closed' THEN 1 ELSE 0 END) / COUNT(c.Complaint_ID)) * 100, 2) AS Resolution_Efficiency_Percentage,
    ROUND(AVG(DATEDIFF(c.Resolution_Date, c.Complaint_Date)), 2) AS Avg_Resolution_Time,
    ROUND((SUM(CASE WHEN i.Investigation_Status = 'Complete' THEN 1 ELSE 0 END) / COUNT(i.Investigation_ID)) * 100, 2) AS Investigation_Efficiency_Percentage
FROM Complaint c
LEFT JOIN Product p ON c.Product_ID = p.Product_ID
LEFT JOIN Brand b ON p.Brand_ID = b.Brand_ID
LEFT JOIN Investigation i ON c.Complaint_ID = i.Complaint_ID
GROUP BY b.Brand_Name
ORDER BY Total_Complaints DESC
LIMIT 1;

-- 1.High Risk Product Percentage
SELECT
    ROUND((SUM(CASE WHEN (p.Number_of_Complaints / p.Units_Sold) > 0.05 AND 
    p.Number_of_Complaints > 50 THEN 1 ELSE 0 END)/ COUNT(DISTINCT p.Product_ID))* 100, 2) 
    AS High_Risk_Product_Percentage
FROM Product p
LEFT JOIN Brand b ON p.Brand_ID = b.Brand_ID
WHERE b.Brand_Status = 'active';

-- 2.Resolution efficiency percentage
SELECT 
    ROUND((SUM(CASE WHEN c.Complaint_Status = 'Closed' THEN 1 ELSE 0 END)
    / COUNT(c.Complaint_ID)) * 100, 2) AS Resolution_Efficiency_Percentage
FROM Complaint c;


-- 3. Average resolution time
SELECT 
    ROUND(AVG(DATEDIFF(c.Resolution_Date, c.Complaint_Date)), 2) AS Avg_Resolution_Time
FROM Complaint c
WHERE c.Complaint_Status = 'Closed';

-- 4.Investigate efficiency percentage

SELECT 
    ROUND((SUM(CASE WHEN i.Investigation_Status = 'Complete' THEN 1 ELSE 0 END) 
    / COUNT(i.Investigation_ID)) * 100, 2) AS Investigation_Efficiency_Percentage
FROM Investigation i;

-- 5.Top complaint brand (Active)

SELECT
	b.Brand_Name AS Top_Complaint_Brand,
    COUNT(c.Complaint_ID) AS Total_Complaints
FROM Brand b
JOIN Product p ON p.Brand_ID = b.Brand_ID
JOIN Complaint c ON c.Product_ID = p.Product_ID
WHERE 
    b.Brand_Status = 'active'
GROUP BY 
    b.Brand_Name
ORDER BY 
    Total_Complaints DESC
LIMIT 1;


