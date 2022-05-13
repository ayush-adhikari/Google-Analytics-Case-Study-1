
/*checking rows from the divvy_trips_2021 table
 where time at which ride started was greater than time at which it ended.
*/

select *
	from dbo.Divvy_Trips_2021
	where started_at > ended_at;

-------------------------------------------------------------------------------------------------------------

/* printing out different types of bikes available and count of each type.
*/

select rideable_type, count(*)  as 'count_of'
	from dbo.divvy_trips_2021
	group by rideable_type;

-------------------------------------------------------------------------------------------------------------

/* printing the ride started time, ride ended time and total trip duration in mins for the docked type of bikes
*/

select rideable_type, started_at, ended_at, ride_length_mins
	from dbo.divvy_trips_2021
	where rideable_type = 'docked_bike';

-------------------------------------------------------------------------------------------------------------

/* checking if there are any duplicate ride id's
*/

select ride_id, COUNT(*)
	from dbo.divvy_trips_2021
	group by ride_id
	having COUNT(*)>1;

-------------------------------------------------------------------------------------------------------------

/* calculating the day number from the respective started_at column
*/
 select started_at, Datepart(weekday, started_at)
	from dbo.divvy_trips_2021;

-------------------------------------------------------------------------------------------------------------

/* printing stations where both start station and end station fields have no value.
*/

select *
	from dbo.divvy_trips_2021
	where start_station_name is null and end_station_name is null;

-------------------------------------------------------------------------------------------------------------

/* printing stations where either start station field has no value or end station field has no value.
*/

select *
	from dbo.divvy_trips_2021
	where start_station_name is null or end_station_name is null;

-------------------------------------------------------------------------------------------------------------

/* printing fields where total ride length is 0 or less mins.
*/

select *
	from dbo.divvy_trips_2021
	where ride_length_mins<=0;

-------------------------------------------------------------------------------------------------------------

/* printing fields where ride started at the base warehouse and ended at the base warehouse.
*/

select *
	from divvy_trips_2021
	where (upper(start_station_name) like '%BASE%WAREHOUSE%' and upper(end_station_name) like '%BASE%WAREHOUSE%');
-------------------------------------------------------------------------------------------------------------

/* Printing fields from the divvy_trips table where the ride either started at or ended at the base warehouse.
*/

select *
	from dbo.divvy_trips_2021
	where (upper(start_station_name) like '%BASE%WAREHOUSE%' and upper(end_station_name) like '%BASE%WAREHOUSE%'); 

-------------------------------------------------------------------------------------------------------------

