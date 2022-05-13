/* calculating and printing the maximum, minimum and average duration of the ride (in mins)
	dependoing on whether the rider is a subscriber or not.
*/

select member_casual, MAX(ride_length_mins) as 'max_ride_length', MIN(ride_length_mins) as 'min_ride_length',
		AVG(ride_length_mins) as 'avg_ride_length'
	from dbo.divvy_trips_2021
	group by member_casual;

-------------------------------------------------------------------------------------------------------------

/* calculating and printing the maximum, minimum and average duration of the ride (in mins)
   depending on the type of the bike.
*/

select rideable_type, MAX(ride_length_mins) as 'max_ride_length', MIN(ride_length_mins) as 'min_ride_length',
		AVG(ride_length_mins) as 'avg_ride_length'
	from dbo.divvy_trips_2021
	group by rideable_type;

-------------------------------------------------------------------------------------------------------------

/* calculating and printing day_of_week from the table
	when casual people rode the bike maximum no of times.
*/

with cte as ( select member_casual, day_of_week, COUNT(*) as 'counting'
				from dbo.divvy_trips_2021
				group by member_casual, day_of_week
				)

			select top 1 day_of_week
				from cte
				where member_casual = 'casual'
				order by counting desc;

/* calculating and printing day_of_week from the table
	when members rode the bike maximum no of times.
*/

with cte as ( select member_casual, day_of_week, COUNT(*) as 'counting'
				from dbo.divvy_trips_2021
				group by member_casual, day_of_week
				)

			select top 1 day_of_week
				from cte
				where member_casual = 'member'
				order by counting desc;

-------------------------------------------------------------------------------------------------------------

/* calculating and printing day_of_week from the table
	when people rode the electric bike maximum no of times.
*/

with cte as ( select rideable_type, day_of_week, COUNT(*) as 'counting'
				from dbo.divvy_trips_2021
				where rideable_type = 'electric_bike'
				group by rideable_type, day_of_week
				)
			select top 1 day_of_week
				from cte
				order by counting desc;

/* calculating and printing day_of_week from the table
	when people rode the classic bike maximum no of times.
*/

with cte as ( select rideable_type, day_of_week, COUNT(*) as 'counting'
				from dbo.divvy_trips_2021
				where rideable_type = 'classic_bike'
				group by rideable_type, day_of_week
				)

			select top 1 day_of_week
				from cte
				order by counting desc;

-------------------------------------------------------------------------------------------------------------

/* calculating and printing how many people use divvy rides every month
	depending on whether they are casual people or subscription members.
*/

select member_casual, FORMAT(started_at, 'MM-yy') as 'Month-Year', COUNT(*) as 'no_of_people'
	from dbo.divvy_trips_2021
	group by member_casual, FORMAT(started_at, 'MM-yy')
	order by 1, 2;

-------------------------------------------------------------------------------------------------------------

/* calculating and printing how many people use divvy rides every quarter
	depending on whether they are casual people or subscription members.
*/

with cte as (select member_casual, FORMAT(started_at, 'MM') as 'Months', COUNT(*) as 'no_of_people'
				from dbo.divvy_trips_2021
				group by member_casual, FORMAT(started_at, 'MM') )
			
			select q1.member_casual, q1.Quarters, sum(q1.no_of_people) as 'total_people'
				from
				(select member_casual,
						case when months = 1 or months = 2 Or months = 3 then 'Quarter_1'
							 when months = 4 or months = 5 Or months = 6 then 'Quarter_2'
							 when months = 7 or months = 8 Or months = 9 then 'Quarter_3'
							 else 'Quarter_4' end as 'Quarters',
						no_of_people
					from cte ) q1
				group by member_casual, Quarters
				order by 1, 2;
				
-------------------------------------------------------------------------------------------------------------
--select q1.*
--	from
--( select member_casual, start_station_name, end_station_name, counting, rank() over(partition by member_casual order by counting desc) as 'num_rank'
--	from
--		 (	select member_casual, start_station_name, end_station_name, COUNT(*) as 'counting'
--				from dbo.divvy_trips_2021
--				group by member_casual, start_station_name, end_station_name
--				--order by member_casual, start_station_name, end_station_name	
--				)
--				) q1
--		where q1.num_rank<=30;

/* calculating and printing the top 30 stations from where either casual riders travel or members travel.
*/

with cte as (select member_casual, start_station_name, end_station_name, COUNT(*) as 'counting'
				from dbo.divvy_trips_2021
				group by member_casual, start_station_name, end_station_name )

				select member_casual, start_station_name, end_station_name, rank_num
					from
					(	select member_casual, start_station_name, end_station_name, counting, RANK() over(partition by member_casual order by counting desc) as 'rank_num'
							from cte
					) q1
					where rank_num <=30;

-------------------------------------------------------------------------------------------------------------

/* Calculating and printing the percentage ride share between members and casual riders.
*/

with cte as ( select member_casual, COUNT(*) as counting
				from dbo.divvy_trips_2021
				group by member_casual )
			
			select member_casual, counting, (counting*100)/(select SUM(counting) from cte) as percentage_count
				from cte 

-------------------------------------------------------------------------------------------------------------
