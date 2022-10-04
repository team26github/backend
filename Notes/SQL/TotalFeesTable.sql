CREATE schema __;
USE __;

-- create the tables
-- Sponsor, Driver, Purchase Made by Driver
CREATE TABLE TotalFees (
  UserID  INT   FOREIGN KEY,
  PurchaseTotal INT,
  AmountInFees  INT
);

-- Total purchases by sponsor, Date, Time, Amount we collect from total from sponsor
CREATE TABLE TotalFeesLog (
  UserID  INT   FOREIGN KEY,
  PurchaseTime     DATETIME   NOT NULL,
  PurchaseDat    DATETIME   NOT NULL
);