-- How many taxi trips were totally made on January 15?

select 
	count(*)
from green_taxi_data
where cast(lpep_pickup_datetime as date) = '2019-01-15' 
    and cast(lpep_dropoff_datetime as date) = '2019-01-15' ;

-- Which was the day with the largest trip distance Use the pick up time for your calculations?
select
	cast(lpep_pickup_datetime as date),
	max(trip_distance) largest_trip_distance
from green_taxi_data
group by 1
order by 2 desc
limit 1;

--  In 2019-01-01 how many trips had 2 and 3 passengers?
select 
	passenger_count,
	count(*) total_trips
from green_taxi_data
where cast(lpep_pickup_datetime as date) = '2019-01-01' 
group by passenger_count
having passenger_count in (2,3);

-- For the passengers picked up in the Astoria Zone which was the drop off zone that had the largest tip? 
-- We want the name of the zone, not the id.
select 
	puz."Zone" pickup_zone,
	doz."Zone" dropoff_zone,
	max(td."tip_amount") "largest_tip"
from green_taxi_data td
left join taxi_zones puz
	on td."PULocationID" = puz."LocationID"
left join taxi_zones doz
	on td."DOLocationID" = doz."LocationID"
where puz."Zone" = 'Astoria'
group by 1,2
order by 3 desc
limit 1