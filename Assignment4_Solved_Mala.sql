
/*
Create two tables PASSENGER and PRICE with the 
following attributes and properties 

PASSENGER
 (Passenger_name varchar 
  Category               varchar
   Gender                 varchar
   Boarding_City      varchar
   Destination_City   varchar
  Distance                int
  Bus_Type             varchar
);

PRICE
(
             Bus_Type              varchar
             Distance                 int
              Price                      int
          )
*/

Create Database if not exists `travel-details` ;
use `travel-details`;

CREATE TABLE PASSENGER
 (Passenger_name varchar(20), 
  Category               varchar(20),
   Gender                 varchar(20),
   Boarding_City      varchar(20),
   Destination_City   varchar(20),
  Distance                int,
  Bus_Type             varchar(20)
);


CREATE TABLE PRICE
(
             Bus_Type   varchar(20),
             Distance    int,
              Price      int
          );
          
          --------------------------------------------------

/* 2)	Insert the following data in the tables
  
Passenger_nam    Category	Gender	Boarding_City	Destination_City	  Distance   Bus_Type
Sejal	          AC          F	    Bengaluru	    Chennai	              350	Sleeper
Anmol	          Non-AC	  M	    Mumbai	        Hyderabad	700	Sitting
Pallavi	          AC          F  	Panaji	        Bengaluru	600	Sleeper
Khusboo	          AC          F     Chennai	        Mumbai	    1500	Sleeper
Udit	          Non-AC	  M	    Trivandrum	    panaji	    1000	Sleeper
Ankur	          AC	      M	    Nagpur	        Hyderabad	500	Sitting
Hemant	          Non-AC	  M	    panaji	        Mumbai	    700	Sleeper
Manish            Non-AC      M     Hyderabad       Bengaluru            500         Sitting
Piyush            AC          M     Pune            Nagpur                 700          Sitting



Bus_Type	Distance	Price
Sleeper	    350	        770
Sleeper	    500	       1100
Sleeper	    600	       1320
Sleeper	    700	       1540
Sleeper	   1000	       2200
Sleeper	   1200	       2640
Sleeper    1500        2700
Sitting	    500	        620
Sitting	    600         744
Sitting	    700	        868
Sitting	   1000	       1240
Sitting	   1200	       1488
Sitting	   1500	       1860
*/

insert into passenger values('Sejal','AC','F','Bengaluru','Chennai',350,'Sleeper');
insert into passenger values('Anmol','Non-AC','M','Mumbai','Hyderabad',700,'Sitting');
insert into passenger values('Pallavi','AC','F','panaji','Bengaluru',600,'Sleeper');
insert into passenger values('Khusboo','AC','F','Chennai','Mumbai',1500,'Sleeper');
insert into passenger values('Udit','Non-AC','M','Trivandrum','panaji',1000,'Sleeper');
insert into passenger values('Ankur','AC','M','Nagpur','Hyderabad',500,'Sitting');
insert into passenger values('Hemant','Non-AC','M','Panaji','Mumbai',700,'Sleeper');
insert into passenger values('Manish','Non-AC','M','Hyderabad','Bengaluru',500,'Sitting');
insert into passenger values('Piyush','AC','M','Pune','Nagpur',700,'Sitting');

select * from passenger;

insert into price values('Sleeper',350,770);
insert into price values('Sleeper',500,1100);
insert into price values('Sleeper',600,1320);
insert into price values('Sleeper',700,1540);
insert into price values('Sleeper',1000,2200);
insert into price values('Sleeper',1200,2640);
insert into price values('Sleeper',1500,2700);
insert into price values('Sitting',500,620);
insert into price values('Sitting',600,744);
insert into price values('Sitting',700,868);
insert into price values('Sitting',1000,1240);
insert into price values('Sitting',1200,1488);
insert into price values('Sitting',1500,1860);

select * from price;
-------------------------------------------------------------
/*
3)	How many females and how many male passengers 
travelled for a minimum distance of 600 KMs?
*/

select Gender, count(Gender) 
FROM Passenger 
where Distance>=600 group by Gender ;

------------------------------------------------------

/*
4) 	Find the minimum ticket price for Sleeper Bus
*/

select min(Price) from Price where Bus_Type = 'Sleeper';

---------------------------------------------------------------

/*
5) Select passenger names whose names start with character 'S' 
*/

select Passenger_Name 
FROM Passenger
where Passenger_Name like 'S%' order by Passenger_Name;

---------------------------------------------------------

/*
6) Calculate price charged for each passenger 
displaying Passenger name, Boarding City, Destination City,
 Bus_Type, Price in the output
 */
 
 select a.Passenger_name,a.Boarding_City,a.Destination_City,
 a.Bus_type,b.Price 
 from Passenger a , Price b 
 where (a.Bus_Type = b.Bus_Type and a.Distance = b.Distance);
 
 ----------------------------------------------------------
 
 /*
 7)	What are the passenger name/s and his/her ticket price 
 who travelled in the Sitting bus  for a distance of 700 KMs
 */
 
select a.Passenger_name,b.Price 
from Passenger a ,Price b 
where (a.Bus_Type = "Sitting" and b.Bus_Type = "Sitting" 
and a.Distance = 700 and b.Distance=700);

----------------------------------------------------

/*
8) What will be the Sitting and Sleeper bus charge 
   for Pallavi to travel from Bangalore to Panaji?
*/

SELECT Price,Bus_Type 
FROM price 
where Distance=(SELECT distinct Distance 
                FROM passenger 
                where Passenger_name = "Pallavi");
                
----------------------------------------------------

/*
9) List the distances from the "Passenger"
 table which are unique (non-repeated distances) 
 in descending order. 
 */
 
 SELECT distinct(Distance) 
 FROM Passenger order by distance desc;
 
 --------------------------------------------------------
 
 /*
 10) Display the passenger name and percentage 
 of distance travelled by that passenger from the total 
 distance travelled by all passengers without using 
 user variables 
 */
 
 with total as ( select sum(distance) as total from Passenger)
select passenger_Name,(distance / total.total)*100 
as percentage_travel 
from Passenger,total ;

----------------------------------------------------------

/* 
11) Display the distance, price in three categories in table Price
a)	Expensive if the cost is more than 1000
b)	Average Cost if the cost is less than 1000 and greater than 500
c)	Cheap otherwise
*/

SELECT Distance, Price,
CASE 
WHEN
 Price > 1000 THEN "Expensive"
 WHEN Price <1000 and Price > 500 THEN "Average Cost"
 ELSE "cheap" END as Cost FROM price;
 
 --------------------------------------------------------


