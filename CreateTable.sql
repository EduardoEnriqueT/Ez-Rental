--------------------- Company Table ------------------------

CREATE TABLE COMPANY(

CompanyID SMALLINT NOT NULL CHECK(CompanyID BETWEEN 1 AND 20000),
CompanyName VARCHAR(50) UNIQUE NOT NULL,
AddressLine1 VARCHAR(50) NOT NULL,
AddressLine2 VARCHAR(50) NULL,
City VARCHAR(30) NOT NULL,
StateCode CHAR(2) NOT NULL,
ZipCode VARCHAR(10) NOT NULL,
Country VARCHAR(50) NOT NULL,
CompanyRepName VARCHAR(50) NOT NULL,
ContactPhone VARCHAR(20) NOT NULL,
ContactEmail VARCHAR(100) UNIQUE NOT NULL,
CorporateDiscountPercentageRate DECIMAL(2,1) NOT NULL,

CONSTRAINT pk_CompanyID PRIMARY KEY(CompanyID),

);

--------------------- Corporate Customer Table ------------------------

CREATE TABLE CORPORATECUSTOMER(

CustomerID  INT ,
CompanyID SMALLINT NOT NULL,


CONSTRAINT pk_CorporateID PRIMARY KEY(CustomerID),

CONSTRAINT fk_CorporateCustomerID
FOREIGN KEY (CustomerID)
REFERENCES  CUSTOMER(CustomerID)
ON DELETE CASCADE ON UPDATE CASCADE,

CONSTRAINT fk_CompanyID
FOREIGN KEY (CompanyID)
REFERENCES  COMPANY(CompanyID)
ON DELETE CASCADE ON UPDATE CASCADE,
);

--------------------- Country Table ------------------------

CREATE TABLE COUNTRY(
CountryID  TINYINT PRIMARY KEY NOT NULL CHECK(CountryID BETWEEN 1 AND 250),
CountryCode2Char CHAR(2) UNIQUE NOT NULL,
CountryCode3Char CHAR(3) UNIQUE NOT NULL,
CountryName VARCHAR(100) NOT NULL,

);

--------------------- US STATE Table ------------------------

CREATE TABLE USSTATE (

StateID TINYINT PRIMARY KEY NOT NULL CHECK(StateID BETWEEN 1 AND 75),
StateCode2Char CHAR(2) UNIQUE NOT NULL,
StateName VARCHAR(50) NOT NULL,


);


-----------------Discount -------------
CREATE TABLE DISCOUNT (

DiscountID INT,
DiscountCode VARCHAR(10) UNIQUE NOT NULL,
DiscountCodeDesc VARCHAR(100) NOT NULL,

CONSTRAINT pk_discount PRIMARY KEY(DiscountID)
);

-----------------EZPLUS -------------

CREATE TABLE EZPLUS(

EZPlusID INT,
EZPlusRewardsCode VARCHAR(13) UNIQUE NOT NULL,
EZPlusRewardsEarnedPoints INT NULL,

CONSTRAINT pk_EZplus PRIMARY KEY(EZPlusID)

);

-----------------RETAIL CUSTOMER -------------

CREATE TABLE RETAILCUSTOMER (

CustomerID INT ,
DiscountID INT UNIQUE NULL,
EZPlusID INT UNIQUE NULL,


CONSTRAINT pk_RetailCustomerID PRIMARY KEY (CustomerID),

CONSTRAINT fk_RetailCustomerID
FOREIGN KEY (CustomerID)
REFERENCES  CUSTOMER(CustomerID)
ON DELETE CASCADE ON UPDATE CASCADE,

CONSTRAINT fk_DiscountID
FOREIGN KEY (DiscountID)
REFERENCES DISCOUNT(DiscountID)
ON DELETE CASCADE ON UPDATE CASCADE,

CONSTRAINT fk_EzPlusID
FOREIGN KEY (EZPlusID)
REFERENCES EZPLUS(EZPlusID)
ON DELETE CASCADE ON UPDATE CASCADE,

);

---------------- CREDIT CARD MERCHANT ----------------------

CREATE TABLE CREDITCARDMERCHANT(

MerchantCode TINYINT CHECK(MerchantCode BETWEEN 1 AND 20) ,
MerchantName VARCHAR(35) NOT NULL,


CONSTRAINT pk_MerchantCode PRIMARY KEY (MerchantCode)
);

-------------------- CREDIT CARD --------------------------

CREATE TABLE CREDITCARD(

CreditCardNumber VARCHAR(16) NOT NULL,
CreditCardOwnerName VARCHAR(50) NOT NULL,
CreditCardIssuingCompany VARCHAR(50) NOT NULL,
MerchantCode TINYINT NOT NULL, 
ExpDate DATE NOT NULL,
AddressLine1 VARCHAR(50) NOT NULL,
AddressLine2 VARCHAR(50) NULL,
City VARCHAR(35) NOT NULL,
StateCode CHAR(2) NOT NULL,
Zipcode VARCHAR(10) NOT NULL,
Country VARCHAR(50) NOT NULL,
CreditCardLimit DECIMAL(6,2) NOT NULL,
CreditCardBalance DECIMAL(6,2) NOT NULL,
ActivationStatus BIT NOT NULL,

CONSTRAINT pk_CreditCardNumber PRIMARY KEY (CreditCardNumber),

CONSTRAINT fk_MerchantCode
FOREIGN KEY (MerchantCode)
REFERENCES  CREDITCARDMERCHANT(MerchantCode)
ON DELETE CASCADE ON UPDATE CASCADE,
);


-------------------CUSTOMER CREDIT CARD ------------------

CREATE TABLE CUSTOMER_CREDITCARD(

CreditCardNumber VARCHAR(16) NOT NULL ,
CustomerID INT NOT NULL, 

CONSTRAINT pk_CreditCard_CustomerID PRIMARY KEY(CreditCardNumber,CustomerID),

CONSTRAINT fk_CustomerID
FOREIGN KEY (CustomerID)
REFERENCES  CUSTOMER(CustomerID)
ON DELETE CASCADE ON UPDATE CASCADE,

CONSTRAINT fk_CreditCardNumber
FOREIGN KEY (CreditCardNumber)
REFERENCES  CREDITCARD(CreditCardNumber)
ON DELETE CASCADE ON UPDATE CASCADE,


);

----------------------------CUSTOMER USERACCOUNT----------------
CREATE TABLE CUSTOMERUSERACCOUNT (

CustomerUserAccountID UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
Username VARCHAR(15) UNIQUE NOT NULL,
Password VARCHAR(50) NOT NULL,
Email VARCHAR(100) UNIQUE NOT NULL,

CONSTRAINT pk_CustomerUserAccountID PRIMARY KEY (CustomerUserAccountID)

);

----------------------------DRIVERLICENSE----------------

CREATE TABLE DRIVERLICENSE (

DriverLicenseNumber VARCHAR(25),
DriverLicenseExpDate DATE NOT NULL, 
DriverLicenseState CHAR(2) NOT NULL

CONSTRAINT pk_DriverLicenseNumber PRIMARY KEY (DriverLicenseNumber)

);

----------------------------CUSTOMER----------------

CREATE TABLE CUSTOMER (

CustomerID  INT  NOT NULL,
FirstName  VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
BirthDate DATE NOT NULL,
AddressLine1 VARCHAR(50) NOT NULL,
AddressLine2 VARCHAR(50) NULL,
City VARCHAR(30) NOT NULL,
StateCode CHAR(2) NOT NULL,
Zipcode VARCHAR(10) NOT NULL,
Country VARCHAR(50) NOT NULL,
Phone VARCHAR(20) NOT NULL,
Email VARCHAR(100) UNIQUE NOT NULL,
DriverLicenseNumber VARCHAR(25) UNIQUE NOT NULL,
CustomerUserAccountID UNIQUEIDENTIFIER NULL,
CustomerType CHAR(2) NOT NULL,


CONSTRAINT pk_CustomerID PRIMARY KEY (CustomerID),

CONSTRAINT fk_Customer_DL
FOREIGN KEY (DriverLicenseNumber)
REFERENCES  DRIVERLICENSE(DriverLicenseNumber)
ON DELETE CASCADE ON UPDATE CASCADE,

CONSTRAINT fk_Customer_USERID
FOREIGN KEY (CustomerUserAccountID)
REFERENCES  CUSTOMERUSERACCOUNT(CustomerUserAccountID)
ON DELETE CASCADE ON UPDATE CASCADE,
);