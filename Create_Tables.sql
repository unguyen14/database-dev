CREATE TABLE CUSTOMER(
    CustomerID INT,
    FName VARCHAR(35) NOT NULL,
    LName VARCHAR(35) NOT NULL,
    DoB DATE NOT NULL,
    CStreetAdd VARCHAR(100),
    CCity VARCHAR(20),
    CProvince VARCHAR(20),
    CZIPCode VARCHAR(9),
    RegistrationDate DATE NOT NULL,
    PRIMARY KEY (CustomerID)
);


CREATE TABLE PAYMENT(
    PaymentID INT,
    PaymentDate DATE NOT NULL,
    PaymentAmount DECIMAL NOT NULL CHECK(PaymentAmount > 0),
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON DELETE SET NULL,
    PRIMARY KEY (PaymentID)
);

CREATE TABLE EVENT_CATEGORY(
    EventCategory VARCHAR(20),
    RequiredEquipment VARCHAR(50),
    PRIMARY KEY (EventCategory)
);

CREATE TABLE PACKAGES(
    PackageID INT,
    PackagePrice DECIMAL NOT NULL CHECK(PackagePrice > 0),
    EventCategory VARCHAR(20) NOT NULL,
    NumberOfEvents SMALLINT NOT NULL CHECK(NumberOfEvents > 0),
    PRIMARY KEY (PackageID),
    FOREIGN KEY (EventCategory) REFERENCES EVENT_CATEGORY(EventCategory) ON DELETE CASCADE
);

CREATE TABLE PLACE(
    PlaceID INT,
    PStreetAdd VARCHAR(100) NOT NULL,
    PCity VARCHAR(20) NOT NULL,
    PProvince VARCHAR(20) NOT NULL,
    PZIPCode VARCHAR(9) NOT NULL,
    EstimatedHours SMALLINT CHECK(EstimatedHours > 0 AND EstimatedHours < 12),
    ChallengeLevel SMALLINT CHECK(ChallengeLevel >= 0 AND ChallengeLevel <= 10),
    Topography VARCHAR(10) NOT NULL,
    PRIMARY KEY (PlaceID)
);

CREATE TABLE MOUNTAIN(
    PlaceID INT,
    Elevation VARCHAR(15),
    PRIMARY KEY (PlaceID),
    FOREIGN KEY (PlaceID) REFERENCES PLACE(PlaceID) ON DELETE CASCADE
);


CREATE TABLE EVENT(
    EventCategory VARCHAR(20),
    EventDate DATE, 
    StartingTime VARCHAR(8) NOT NULL,
    Duration SMALLINT CHECK(Duration > 0 AND Duration < 12) NOT NULL,
    PlaceID INT,
    PRIMARY KEY(EventCategory, EventDate),
    FOREIGN KEY (EventCategory) REFERENCES EVENT_CATEGORY(EventCategory) ON DELETE CASCADE,
    FOREIGN KEY (PlaceID) REFERENCES PLACE(PlaceID) ON DELETE SET NULL
);

CREATE TABLE PHOTO(
    Directory VARCHAR(60),
    EventCategory VARCHAR(20),
    EventDate DATE, 
    PRIMARY KEY (Directory),
    FOREIGN KEY (EventCategory, EventDate) REFERENCES EVENT(EventCategory, EventDate) ON DELETE SET NULL
);

CREATE TABLE CUSTOMER_ATTENDS_EVENTS(
    CustomerID INT,
    EventCategory VARCHAR(20),
    EventDate DATE, 
    PRIMARY KEY (CustomerID,EventCategory, EventDate),
    FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustomerID) ON DELETE CASCADE,
    FOREIGN KEY (EventCategory, EventDate) REFERENCES EVENT(EventCategory, EventDate) ON DELETE CASCADE
);

CREATE TABLE CUSTOMER_ACQUIRES_PACKAGES(
    CustomerID INT,
    PackageID INT,
    DateOfAcquisition DATE NOT NULL,
    PRIMARY KEY (CustomerID, PackageID), 
    FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustomerID) ON DELETE CASCADE,
    FOREIGN KEY (PackageID) REFERENCES PACKAGES(PackageID) ON DELETE CASCADE
);

CREATE TABLE PAYMENT_IS_LINKED_TO_PACKAGE(
    PaymentID INT,
    PackageID INT,
    PRIMARY KEY (PaymentID,PackageID),
    FOREIGN KEY (PackageID) REFERENCES PACKAGES (PackageID) ON DELETE CASCADE,
    FOREIGN KEY (PaymentID) REFERENCES PAYMENT (PaymentID) ON DELETE CASCADE
);

CREATE TABLE CUSTOMER_TELEPHONE_NUMBERS(
    CustomerID INT,
    TelNumber NUMERIC(10,0) NOT NULL,
    PRIMARY KEY (CustomerID, TelNumber),
    FOREIGN KEY (CustomerID) REFERENCES CUSTOMER (CustomerID) ON DELETE CASCADE
);

