CREATE schema CPSC4620test;
USE CPSC4620test;

-- create the tables
CREATE TABLE Price (
  PriceID  INT   PRIMARY KEY  AUTO_INCREMENT,
  Size     VARCHAR(20)    NOT NULL,
  Crust    VARCHAR(20)   NOT NULL,
  Price    DECIMAL(10,2)  NOT NULL,
  Cost	DECIMAL(10,2) NOT NULL
);

CREATE TABLE Topping (
  ToppingID   INT   PRIMARY KEY  AUTO_INCREMENT,
  Name    VARCHAR(20)    NOT NULL,
  Price   DECIMAL(10,2)   NOT NULL,
  Cost    DECIMAL(10,2)  NOT NULL,
  Inventory	VARCHAR(20) NOT NULL,
  Small_Size DECIMAL(10,2) NOT NULL,
  Medium_Size DECIMAL(10,2) NOT NULL,
  Large_Size DECIMAL(10,2) NOT NULL,
  Extra_Large_Size DECIMAL(10,2) NOT NULL
);

CREATE TABLE Discount (
  DiscountID      INT   PRIMARY KEY  AUTO_INCREMENT,
  Name    VARCHAR(20)    NOT NULL,
  Percent_Off   DECIMAL(10,2),
  Money_Off   DECIMAL(10,2)
);

CREATE TABLE Pizza (
  PizzaID      INT   PRIMARY KEY  AUTO_INCREMENT,
  Crust_Type    VARCHAR(20)    NOT NULL,
  Size   Varchar(20),
  Price   DECIMAL(10,2),
  Cost    DECIMAL(10,2),
  Completed_By_Kitchen   BIT(1) DEFAULT(1)
);

CREATE TABLE Customer (
  CustomerID      INT   PRIMARY KEY  AUTO_INCREMENT,
  Name   Varchar(20),
  Phone_Number   VARCHAR(15),
  Address    VARCHAR(50)
);

CREATE TABLE Orders (
  primary key(OrderID,PizzaID),
  foreign key(Pickup_Customer) references Customer(CustomerID),
  OrderID      INT,
  PizzaID      INT,
  Order_Type   Varchar(10),
  Total_Cost   DECIMAL(10,2),
  Order_Time    DATETIME,
  Total_Price   DECIMAL(10,2),
  Table_Number   INT,
  Seat_Number   VARCHAR(20),
  Pickup_Customer   INT
);

CREATE TABLE PizzaTopping (
  primary key(ToppingID,PizzaID),
  PizzaID      INT,
  ToppingID   INT,
  Extra_Topping   BIT(1),
  Topping_Price   DECIMAL(10,2),
  Topping_Cost   DECIMAL(10,2)
);

CREATE TABLE PizzaDiscount (
  primary key(DiscountID,PizzaID),
  PizzaID      INT,
  DiscountID   INT,
  Pizza_Price   DECIMAL(10,2),
  Discount_Money_Off  DECIMAL(10,2),
  Discount_Percent_Off  DECIMAL(10,2)
);

CREATE TABLE OrderDiscount (
  primary key(DiscountID,OrderID),
  OrderID      INT,
  DiscountID   INT,
  Order_Price   DECIMAL(10,2),
  Discount_Money_Off  DECIMAL(10,2),
  Discount_Percent_Off  DECIMAL(10,2)
);