use [SqlPortfolio Project]

select * 
from [SqlPortfolio Project]..CovidDeaths$;

select * 
from [SqlPortfolio Project]..CovidVaccinations$
order by 3,4


select location,date,total_cases,new_cases,total_deaths,population
from [SqlPortfolio Project]..CovidDeaths$ 

--death percentage in different countries
select location,date,total_cases, total_deaths,(total_deaths/total_cases)*100 as Death_percentage 
from [SqlPortfolio Project]..CovidDeaths$ 
where location='United states' and  continent is not null
order by Death_percentage desc 

--Total cases vs Population also percentage of covid cases 
--specified countries
select location,date,population,total_cases,(total_cases/population)*100 as case_percentage 
from [SqlPortfolio Project]..CovidDeaths$ 
where location='United states' 
order by date

--in general all counries
select location,date,population,total_cases,(total_cases/population)*100 as case_percentage 
from [SqlPortfolio Project]..CovidDeaths$ 
order by 1,2
 
 -- Looking at countries with highest infection rate compared to population
select location,population,max(total_cases) as Highestinfectioncount,max(total_cases/population)*100 as case_percentage 
from [SqlPortfolio Project]..CovidDeaths$ 
--where location ='India'and 
where continent is not null
group by location,population
order by 4 desc

 
 ---highest death count based on their population
select location,max(cast(total_deaths as int)) as Total_deathCount
from [SqlPortfolio Project]..CovidDeaths$ 
--where location='India' and
where continent is  not null
group by location
order by 2 desc


---breaking the data by continent

select location,max(cast(total_deaths as int)) as Total_deathCount
from [SqlPortfolio Project]..CovidDeaths$ 
--where location='India' and
where continent is null
group by location
order by 2 desc

select continent,max(cast(total_deaths as int)) as Total_deathCount
from [SqlPortfolio Project]..CovidDeaths$ 
--where location='India' and
where continent is not null
group by continent
order by 2 desc

--continent with max death count
select location,max(cast(total_deaths as int)) as Total_deathCount
from [SqlPortfolio Project]..CovidDeaths$ 
--where location='India' and
where continent is null
group by location
order by 2 desc

--GLOBAL Numbers
select date,sum(new_cases)as Total_cases,sum(cast(new_deaths as int))as Total_deaths,sum(cast(new_deaths as int))/sum(new_cases)*100 as Deathpercent
from [SqlPortfolio Project]..CovidDeaths$ 
--where location='United states' and 
where continent is not null
--order by Death_percentage desc 
group by date 
order by 1,2

--overall death percentage 

select sum(new_cases)as Total_cases,sum(cast(new_deaths as int))as Total_deaths,sum(cast(new_deaths as int))/sum(new_cases)*100 as Deathpercent
from [SqlPortfolio Project]..CovidDeaths$ 
where continent is not null

--Total vaccinations

select cd.continent,cd.location,cd.date,cd.population,cv.new_vaccinations ,
sum(cast(cv.new_vaccinations as int)) over(partition by cd.location order by cd.date,cd.location) as  totaldaily_vaccinations
from
[SqlPortfolio Project]..CovidDeaths$ as cd
join
[SqlPortfolio Project]..CovidVaccinations$ as cv 
on cd.location=cv.location and cd.date= cv.date
where cd.continent is not null
order by 2,3

select cd.continent,cd.location,
max(cast(cv.new_vaccinations as int)) as  totaldaily_vaccinations
from
[SqlPortfolio Project]..CovidDeaths$ as cd
join
[SqlPortfolio Project]..CovidVaccinations$ as cv 
on cd.location=cv.location and cd.date=cv.date
where cd.continent is not null
group by cd.continent,cd.location
order by 1,2

--total vaccination in each continent

select cd.location,
max(cast(cv.new_vaccinations as int)) as  totaldaily_vaccinations
from
[SqlPortfolio Project]..CovidDeaths$ as cd
join
[SqlPortfolio Project]..CovidVaccinations$ as cv 
on cd.location=cv.location and cd.date=cv.date
where cd.continent is  null
group by cd.location
order by 1

select cd.continent,
max(cast(cv.new_vaccinations as int)) as  totaldaily_vaccinations
from
[SqlPortfolio Project]..CovidDeaths$ as cd
join
[SqlPortfolio Project]..CovidVaccinations$ as cv 
on cd.location=cv.location and cd.date=cv.date
where cd.continent is  not null
group by cd.continent
order by 1

--total vaccination based on location
select cd.location,
max(cast(cv.new_vaccinations as int)) as  totaldaily_vaccinations
from
[SqlPortfolio Project]..CovidDeaths$ as cd
join
[SqlPortfolio Project]..CovidVaccinations$ as cv 
on cd.location=cv.location and cd.date=cv.date
where cd.continent is not null
group by cd.location
order by 1


---total population and total vaccination

select cd.continent,cd.location,cd.date,cd.population,cv.new_vaccinations ,
sum(cast(cv.new_vaccinations as int)) over(partition by cd.location order by cd.date,cd.location) as  totaldaily_vaccinations
from
[SqlPortfolio Project]..CovidDeaths$ as cd
join
[SqlPortfolio Project]..CovidVaccinations$ as cv 
on cd.location=cv.location and cd.date= cv.date
where cd.continent is not null
order by 2,3

--with cte
with pop_vs_vacc (continent,location,date,population,new_vaccinations,totaldailyvaccinations)
as
(
select cd.continent,cd.location,cd.date,cd.population,cv.new_vaccinations ,
sum(cast(cv.new_vaccinations as int)) over(partition by cd.location order by cd.date,cd.location) as  totaldaily_vaccinations
from
[SqlPortfolio Project]..CovidDeaths$ as cd
join
[SqlPortfolio Project]..CovidVaccinations$ as cv 
on cd.location=cv.location and cd.date= cv.date
where cd.continent is not null
--order by 2,3
)
select * ,(totaldailyvaccinations/population)*100 as vaccination_percent
from pop_vs_vacc

--Creating new to store the select query table

create table percentpopulationvaccinated
(
continent nvarchar(255),
location nvarchar(255),
date date,
population bigint,
new_vaccinations bigint,
totaldaily_vaccinations bigint);

insert into percentpopulationvaccinated
select cd.continent,cd.location,cd.date,cd.population,cv.new_vaccinations ,
sum(cast(cv.new_vaccinations as int)) over(partition by cd.location order by cd.date,cd.location) as  totaldaily_vaccinations
from
[SqlPortfolio Project]..CovidDeaths$ as cd
join
[SqlPortfolio Project]..CovidVaccinations$ as cv 
on cd.location=cv.location and cd.date= cv.date
--where cd.continent is not null
--order by 2,3

select * ,(totaldaily_vaccinations/population)*100 as vaccination_percent
from percentpopulationvaccinated

drop table percentpopulationvaccinated



--creating view for later vew in the query

create view viewpercentpopulationvaccinated as
select cd.continent,cd.location,cd.date,cd.population,cv.new_vaccinations ,
sum(cast(cv.new_vaccinations as int)) over(partition by cd.location order by cd.date,cd.location) as  totaldaily_vaccinations
from
[SqlPortfolio Project]..CovidDeaths$ as cd
join
[SqlPortfolio Project]..CovidVaccinations$ as cv 
on cd.location=cv.location and cd.date= cv.date
where cd.continent is not null
--order by 2,3

select * from viewpercentpopulationvaccinated

