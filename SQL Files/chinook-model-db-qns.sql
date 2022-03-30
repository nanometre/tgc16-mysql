-- 1 - Display all Sales Support Agents with their first name and last name
SELECT Employee.FirstName, Employee.LastName 
    FROM Employee
    WHERE Title = "Sales Support Agent";

-- 2 - Display all employees hired between 2002 and 2003, and display their first name and last name
SELECT Employee.FirstName, Employee.LastName
    FROM Employee
    WHERE YEAR(HireDate) >= '2002' AND YEAR(HireDate) <= 2003;

-- 3 - Display all artists that have the word 'Metal' in their name
SELECT * 
    FROM Artist
    WHERE Name LIKE '%metal%';

-- 4 - Display all employees who are in sales (sales manager, sales rep etc.)
SELECT * 
    FROM Employee 
    WHERE Title LIKE "%sales%";

-- 5 - Display the titles of all tracks which has the genre "easy listening"
SELECT * 
    FROM Genre JOIN Track 
    ON Genre.GenreId = Track.GenreId
    WHERE Genre.Name LIKE 'easy listening';

-- 6 - Display all the tracks from all albums along with the genre of each track
SELECT * FROM Album 
    LEFT JOIN Track 
    ON Album.AlbumId = Track.AlbumId
    LEFT JOIN Genre
    ON Track.GenreId = Genre.GenreId
    LIMIT 10;

-- 7 - Using the Invoice table, show the average payment made for each country
SELECT BillingCountry, AVG(Total) FROM Invoice
    GROUP BY BillingCountry;

-- 8 - Using the Invoice table, show the average payment made for each country, but only for countries that paid more than $5.50 in total average
SELECT BillingCountry, AVG(Total) FROM Invoice
    GROUP BY BillingCountry
    HAVING AVG(Total) > 5.5;

-- 9 - Using the Invoice table, show the average payment made for each customer, but only for customer reside in Germany and only if that customer has paid more than 10in total
SELECT CustomerId, AVG(Total) FROM Invoice
    WHERE BillingCountry LIKE "Germany" AND Total > 10
    GROUP BY CustomerId;

-- 10 - Display the average length of Jazz song (that is, the genre of the song is Jazz) for each album
SELECT Genre.Name, AVG(Track.Milliseconds) FROM Album 
    LEFT JOIN Track 
    ON Album.AlbumId = Track.AlbumId
    LEFT JOIN Genre
    ON Track.GenreId = Genre.GenreId
    GROUP BY Genre.Name
    HAVING Genre.Name="Jazz";