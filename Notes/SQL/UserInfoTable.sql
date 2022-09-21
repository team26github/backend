CREATE schema __;
USE __;

-- create the tables
-- User ID, Password (encrypted), Username, User Type
CREATE TABLE UserInfo (
  UserID  INT   PRIMARY KEY  AUTO_INCREMENT,
  Passwd     VARCHAR(20)    NOT NULL,
  Username    VARCHAR(20)   NOT NULL,
  UserType    VARCHAR(20)  NOT NULL,
  Email     VARCHAR(40)     NOT NULL,
  Points    INT     
);

-- Username, Time of update, Date of update, Type of update
CREATE TABLE UserUpdateLog (
  UserID  INT   FOREIGN KEY,
  UpdateTime     DATETIME   NOT NULL,
  UpdateDate    DATETIME   NOT NULL,
  UpdateType    VARCHAR(20) NOT NULL
);