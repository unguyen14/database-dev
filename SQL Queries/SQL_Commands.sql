SELECT PAYMENT.CustomerID, SUM(DISTINCT PAYMENT.PaymentAmount) AS "Total Paid", SUM(DISTINCT PACKAGES.PackagePrice) AS "Total Purchased", 
SUM(DISTINCT PAYMENT.PaymentAmount) - SUM(DISTINCT PACKAGES.PackagePrice) AS "Balance" FROM PAYMENT INNER JOIN CUSTOMER_ACQUIRES_PACKAGES 
ON CUSTOMER_ACQUIRES_PACKAGES.CustomerID = PAYMENT.CustomerID INNER JOIN PACKAGES ON PACKAGES.PackageID = CUSTOMER_ACQUIRES_PACKAGES.PackageID GROUP BY PAYMENT.CustomerID;

SELECT EVNT.PLACEID, PLC.PSTREETADD, PLC.PCITY, PLC.PPROVINCE, COUNT(EVNT.PLACEID)
FROM EVENT EVNT JOIN PLACE PLC ON EVNT.PLACEID = PLC.PLACEID
GROUP BY EVNT.PLACEID, PLC.PSTREETADD, PLC.PCITY, PLC.PPROVINCE
ORDER BY COUNT(EVNT.PLACEID) DESC;

SELECT PAYMENT.CUSTOMERID, SUM(DISTINCT PAYMENT.PAYMENTAMOUNT) AS "TOTAL PAID", SUM(DISTINCT PACKAGES.PACKAGEPRICE) AS "TOTAL PURCHASED", 
SUM(DISTINCT PAYMENT.PAYMENTAMOUNT) - SUM(DISTINCT PACKAGES.PACKAGEPRICE) AS "NEGATIVE BALANCES" 
FROM PAYMENT INNER JOIN CUSTOMER_ACQUIRES_PACKAGES CAP
ON CAP.CUSTOMERID = PAYMENT.CUSTOMERID INNER JOIN PACKAGES ON PACKAGES.PACKAGEID = CAP.PACKAGEID INNER JOIN CUSTOMER ON PAYMENT.CUSTOMERID = CUSTOMER.CUSTOMERID
GROUP BY PAYMENT.CUSTOMERID HAVING SUM(DISTINCT PAYMENT.PAYMENTAMOUNT) - SUM(DISTINCT PACKAGES.PACKAGEPRICE) < 0 ORDER BY SUM(DISTINCT PAYMENT.PAYMENTAMOUNT) - SUM(DISTINCT PACKAGES.PACKAGEPRICE);

SELECT CAP.CUSTOMERID, PKG.EVENTCATEGORY, SUM(DISTINCT PKG.NUMBEROFEVENTS) AS "EVENTS ACQUIRED", COUNT(DISTINCT CAE.EVENTCATEGORY) AS "EVENTS ATTENDED",  
(SUM(DISTINCT PKG.NUMBEROFEVENTS) - COUNT(DISTINCT CAE.EVENTCATEGORY)) AS "BALANCE" FROM (CUSTOMER_ACQUIRES_PACKAGES CAP INNER JOIN PACKAGES PKG ON CAP.PACKAGEID = PKG.PACKAGEID) 
INNER JOIN CUSTOMER_ATTENDS_EVENTS CAE ON CAP.CUSTOMERID = CAE.CUSTOMERID 
GROUP BY CAP.CUSTOMERID, PKG.EVENTCATEGORY 
HAVING (SUM(DISTINCT PKG.NUMBEROFEVENTS) - COUNT(DISTINCT CAE.EVENTCATEGORY)) > 7 
ORDER BY CAP.CUSTOMERID;

SELECT EVENTCATEGORY, EVENTDATE, COUNT(CUSTOMERID) AS "NUMBER OF PARTICIPANTS"
FROM CUSTOMER_ATTENDS_EVENTS 
GROUP BY EVENTCATEGORY, EVENTDATE
ORDER BY COUNT(CUSTOMERID) DESC;

SELECT SUBSTR(REGISTRATIONDATE,1,2) AS "Month", COUNT(CUSTOMERID) AS "Packages Acquired" 
FROM CUSTOMER GROUP BY SUBSTR(REGISTRATIONDATE,1,2) 
ORDER BY SUBSTR(REGISTRATIONDATE,1,2);

SELECT SUBSTR(EVENTDATE,7,4) AS "Year", COUNT(EVENTCATEGORY) AS "Events per Year" FROM EVENT GROUP BY SUBSTR(EVENTDATE,7,4) ORDER BY SUBSTR(EVENTDATE,7,4);

SELECT CAE.CUSTOMERID, P.DIRECTORY AS "Photos to Send"
FROM PHOTO P INNER JOIN CUSTOMER_ATTENDS_EVENTS CAE ON P.EVENTDATE = CAE.EVENTDATE AND P.EVENTCATEGORY=CAE.EVENTCATEGORY
ORDER BY CAE.CUSTOMERID;

UPDATE PACKAGES SET PackagePrice = PackagePrice * 1.1 WHERE EventCategory = 'Hiking Overhaul' OR EventCategory = 'Intermediate Hike';

SELECT CustomerID, EventCategory, COUNT(CustomerID) AS "Events Attended" FROM CUSTOMER_ATTENDS_EVENTS GROUP BY CustomerID, EventCategory ORDER BY COUNT(CustomerID) DESC;

DELETE FROM PACKAGES WHERE EventCategory = 'Easy Peasy Hike';

DELETE FROM PLACE WHERE PCity = 'Chilliwak';

CREATE VIEW AdvancedPhotos AS SELECT * FROM Photo WHERE EventCategory = 'Hiking Overhaul' OR  EventCategory = 'Intermediate Hike';

CREATE VIEW BegginerPhotos AS SELECT * FROM Photo WHERE EventCategory = 'Easy Peasy Hike' OR  EventCategory = 'Easy Stroll' OR  EventCategory = 'Walk in Park';

SELECT CustomerID, SUM(PaymentAmount) AS "Total Payments" FROM PAYMENT GROUP BY CustomerID ORDER BY CustomerID;

SELECT PaymentDate, PaymentID, PaymentAmount, PaymentAmount*0.2 AS "Total Taxes" FROM PAYMENT ORDER BY PaymentDate;

SELECT CustomerID, COUNT(CustomerID) AS "Events Attended", EventCategory FROM CUSTOMER_ATTENDS_EVENTS 
WHERE (EventCategory = 'Easy Peasy Hike' AND CustomerID IN (SELECT CustomerID FROM CUSTOMER_ATTENDS_EVENTS WHERE EventCategory = 'Easy Stroll')) 
OR (EventCategory = 'Easy Stroll' AND CustomerID IN (SELECT CustomerID FROM CUSTOMER_ATTENDS_EVENTS WHERE EventCategory = 'Easy Peasy Hike'))  GROUP BY CustomerID, EventCategory;

SELECT PackageID, COUNT(PackageID) AS "Total Number of Acquisitions" FROM CUSTOMER_ACQUIRES_PACKAGES GROUP BY PackageID ORDER BY COUNT(PackageID) DESC;

SELECT CUSTOMERID,  MAX(EVENTDATE) AS "Last Event Attended" FROM CUSTOMER_ATTENDS_EVENTS GROUP BY CUSTOMERID HAVING MAX(EVENTDATE) <= '01/01/2019' ORDER BY MAX(EVENTDATE);

SELECT CUSTOMER_ACQUIRES_PACKAGES.CustomerID, PACKAGES.EventCategory, PACKAGES.NumberOfEvents 
FROM CUSTOMER_ACQUIRES_PACKAGES INNER JOIN PACKAGES ON  CUSTOMER_ACQUIRES_PACKAGES.PackageID = PACKAGES.PackageID;
