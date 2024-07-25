------------创建db
-- USE master;
-- GO
-- IF NOT EXISTS (
--       SELECT name
--       FROM sys.databases
--       WHERE name = N'EV_cars'
--       )
--    CREATE DATABASE [EV_cars];
-- GO


-- select *,
-- ROW_NUMBER() over( partition by company, industry, total_laid_off,percentage_laid_off order by company ) as rownum

--------------------------检查有没有重复的数据
-- with cte_ev as (
--     select *, 
-- row_number() over (partition by VIN_1_10, County, City, Model_Year, Make, Electric_Range, Vehicle_Location, DOL_Vehicle_ID order by VIN_1_10) as rownum
-- FROM EV_cars.dbo.Electric_Vehicle_Population_Data
-- )
-- select * from cte_ev
-- where rownum >1
--------------------检查完毕没有 继续清理



---------------找出纯电续航大于300的车 ===>the cars are good quality electric vehicles
-- select * 
-- from EV_cars.dbo.Electric_Vehicle_Population_Data
-- where Electric_Range>300

--------------纯电续航小于200 生产日期大于2016年
-- select * 
-- from EV_cars.dbo.Electric_Vehicle_Population_Data
-- where Electric_Range<200
-- and electric_vehicle_type = 'Battery Electric Vehicle (BEV)'
-- and model_year >2016
-------------=====> these cars are mostly rubbish quality brand in the market, remind the clients & investors


---------选出car maker =null 的 删掉
-- select * 
-- from EV_cars.dbo.Electric_Vehicle_Population_Data
-- where make = '' or make is null 

-----------there are 286 values cars aint legislative in any districts
-- select * 
-- from EV_cars.dbo.Electric_Vehicle_Population_Data
-- where legislative_district = '' or legislative_district is null 


-----load these data as a form first for backup and then delete them from main table
-- DELETE from EV_cars.dbo.Electric_Vehicle_Population_Data
-- where legislative_district = '' or legislative_district is null 

-----update the new table, order by year
-- select * 
-- from EV_cars.dbo.Electric_Vehicle_Population_Data
-- order by Model_Year


------some calculation
----calculate average electric_range, select those whos above, those whos below.
-- select AVG(electric_range)
-- from EV_cars.dbo.Electric_Vehicle_Population_Data
-------AVG(electric_range)=87
-- select  * 
-- from EV_cars.dbo.Electric_Vehicle_Population_Data
-- where electric_range>87

----calculate average legislative_district number, found those makers brand above average number(they ofc have a great marketing team)
-- select AVG(legislative_district)
-- from EV_cars.dbo.Electric_Vehicle_Population_Data
--------AVG(legislative_district)=29, so find those who is above this
-- select  * 
-- from EV_cars.dbo.Electric_Vehicle_Population_Data
-- where legislative_district>29
-- and electric_range>87


-- select  * 
-- from EV_cars.dbo.Electric_Vehicle_Population_Data
-- where legislative_district>29
-- and electric_range<87

---- select those base_MSRP whos above zero, see if covid affects the car price?


-- select  * 
-- from EV_cars.dbo.Electric_Vehicle_Population_Data
-- where base_MSRP>0
-- order by model_year DESC

-- select  AVG(base_MSRP)
-- from EV_cars.dbo.Electric_Vehicle_Population_Data
---------- AVG(base_MSRP)=$1794

-----------====check if the 2020 covid affect the base_msrp, 
-- select 
-- AVG(case when model_year=2018 then base_MSRP else null end),
--  AVG (case when model_year=2019 then base_MSRP else null end),
--  AVG (case when Model_Year=2020 then base_MSRP else null end) 

-- from EV_cars.dbo.Electric_Vehicle_Population_Data

--------data shows since 2018 base_msrp is dropping so covid made price drop, HOWEVER, this data model is lagging behind the real markt flow. 

select *
FROM EV_cars.dbo.Electric_Vehicle_Population_Data