--drop table dbo.Divvy_trips;
/* combining the imported data from each table into a single table
*/

Insert into dbo.divvy_trips_2021(ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual) 
    (
	select * from dbo.Divvy_Trips_2021_01
	union
	select * from dbo.Divvy_Trips_2021_02
	union
	select * from dbo.Divvy_Trips_2021_03
	union
	select * from dbo.Divvy_Trips_2021_04
	union
	select * from dbo.Divvy_Trips_2021_05
	union
	select * from dbo.Divvy_Trips_2021_06
	union
	select * from dbo.Divvy_Trips_2021_07
	union
	select * from dbo.Divvy_Trips_2021_08
	union
	select * from dbo.Divvy_Trips_2021_09
	union
	select * from dbo.Divvy_Trips_2021_10
	union
	select * from dbo.Divvy_Trips_2021_11
	union
	select * from dbo.Divvy_Trips_2021_12
	)
;

-------------------------------------------------------------------------------------------------------------

/* deleting records where started_at time is greater than ended_at time
*/

delete from dbo.Divvy_Trips_2021
	where started_at > ended_at;

-------------------------------------------------------------------------------------------------------------

/*
	adding new column 'ride_length_mins'
*/

alter table dbo.Divvy_trips_2021
	add ride_length_mins int;

-------------------------------------------------------------------------------------------------------------

/*
	updating values in the 'ride_length_mins' columns to
	the minute difference between the started_at column and ended_at column
*/

update dbo.Divvy_Trips_2021
	set ride_length_mins = datediff(minute, started_at, ended_at);

-------------------------------------------------------------------------------------------------------------

/*
	adding new column 'day_of_week'
*/

alter table dbo.Divvy_trips_2021
	add day_of_week int;

-------------------------------------------------------------------------------------------------------------

/*
	updating values in the 'day_of_week' columns to
	the day number of its respective started_date column. 
	Day number means Sunday = 0, Monday = 1, Tuesday = 2, Wednesday = 3 and so on and so forth.
*/

update dbo.Divvy_Trips_2021
	set day_of_week = Datepart(weekday, started_at);

-------------------------------------------------------------------------------------------------------------

/* deleting fields from Divvy_Trips table where both start station and end station fields have no value.
*/

delete from dbo.divvy_trips_2021
	where start_station_name is null and end_station_name is null;
	
-------------------------------------------------------------------------------------------------------------

/* deleting fields from Divvy_Trips where either start station field has no value or end station field has no value.
*/

delete from dbo.divvy_trips_2021
	where start_station_name is null or end_station_name is null;

-------------------------------------------------------------------------------------------------------------

/* deleting fields from Divvy_Trips where ride_length field has a value of 0 or less.
*/

delete from dbo.divvy_trips_2021
	where ride_length_mins<=0;

-------------------------------------------------------------------------------------------------------------

/* Deleting fields from the divvy_trips table where the ride started at and ended at the base warehouse.
*/

delete from dbo.divvy_trips_2021
		where (upper(start_station_name) like '%BASE%WAREHOUSE%' and upper(end_station_name) like '%BASE%WAREHOUSE%'); 

-------------------------------------------------------------------------------------------------------------

/* Deleting fields from the divvy_trips table where the ride either started at or ended at the base warehouse.
*/

delete from dbo.divvy_trips_2021
	where (upper(start_station_name) like '%BASE%WAREHOUSE%' or upper(end_station_name) like '%BASE%WAREHOUSE%'); 

-------------------------------------------------------------------------------------------------------------

select *
	from dbo.Divvy_Trips_2021
	order by started_at;

-------------------------------------------------------------------------------------------------------------


