--*********************************************************************
--CS 2258                               		B.Senthil Kumar
--DBMS Lab						Asst. Prof
--	      		      Computer Science & Engineering Department
--            		     		     SSN College of Engineering 
--	                   	     		     senthil@ssn.edu.in
--*********************************************************************
-- 	          	AIRLINES DATASET
--                 	  Version 1.0
--               	February 05, 2013
--*********************************************************************
Sources:  this is a synthesized dataset. 

***********************************************************************

This file describes the contents of the AIRLINE dataset
developed for the CS2258, Database Management Systems Lab,
course at SSN College of Engg.

The dataset contains information about the aircraft and its 
pilots who are certified, also the other employees as well.
The dataset also contains the information about flights
for different routes and the schedule of flights from 
12 April to 22 April 2005.


General Conventions.

 1. All files in the dataset are script(SQL) files.
 2. First line of air_pop file provides the names of
    columns. Second line may be empty, or may contain
    the first row of the data.
 3. All string values are enclosed in single quotes (')


  The dataset consists of the following files:

   - air_cre.sql : to create a airlines database
   - air_pop.sql : to populate the airlines database


 Description of individual relations:

**************************************************************************

 Aircraft: describes the aircraft and its type

          aid: unique identifier of the aircraft
        aname: name of an aircraft
         type: the type of an aircraft to which it belongs to
cruisingrange: the maximum distance that an aircraft can travel and return


**************************************************************************

 Employee: describes pilots and other kinds of employees as well.

          eid: unique identifier of an employee
        ename: name of an employee
       salary: the salary of an employee (in dollars)


**************************************************************************

 Certified: every pilot is certified for some aircraft and only pilots are
	    certified to fly.

         eid: the employee who is certifed for an aircraft (see employee.EID)
         aid: the aircraft to which the employee is certified for (see aircraft.AID)


**************************************************************************

 Routes: describes the route information - from and to

     routeid: unique identifier of the route
orig_airport: describes the airport from where the flight starts
dest_airport: describes the airport from where the flight ends
    distance: distance covered during the flight


**************************************************************************

 Flights: Flight is the process by which an aircraft moves, through an 
          atmosphere (especially the air)
        : describes information about the different flight for each route

    flightno: unique identifier of flight
         rid: the route of the flight (see routes.RID)
         aid: the aircraft being used for this flight (see aircraft.AID)


**************************************************************************

 Fl_schedule: describes the schedule of flights from 12 to 22 April 2005.

        flno: flight that is scheduled (see flights.FLIGHTNO)
     departs: the date of flight departure from the originating airport.
       dtime: the time of departure in 24Hrs format
     arrives: the date of flight arrival to the destination airport.
       atime: the time of arrival in 24Hrs format
       price: the cost/person (in dollars)


**************************************************************************
**************************************************************************

Permission granted to use and distribute this dataset in its current form, 
provided this file  is kept unchanged and is distributed together with the 
data.

Permission granted to modify and expand this dataset, provided this
file is updated accordingly with new information.

**************************************************************************
**************************************************************************
