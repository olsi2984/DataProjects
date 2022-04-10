-- Covid data exploration SQL project from Alex the Analyst website. 
--I have used IBM DB2 to upload the data and create the tables.

Select *
From COVIDDEATHS
Where continent is not null 
order by 3,4;

Select Location, date, total_cases, new_cases, total_deaths, population
From COVIDDEATHS
Where continent is not null 
order by 1,2;

--Total cases vs total deaths in a specific country

Select Location, date, total_cases, total_deaths
, (total_deaths * 1.0 / total_cases * 1.0)*100 as DeathPercentage
From COVIDDEATHS
where location like 'Albania'
order by 1,2;

-- Total cases vs population

Select Location, date, total_cases, population
, (total_cases * 1.0 /population * 1.0) * 100 as InfectedPercentage
From COVIDDEATHS
where location like 'Albania'
order by 1,2;

-- countries with highest infections rates

Select Location, MAX(total_cases) as HighestInfectCount, population
, MAX((total_cases * 1.0 /population * 1.0) * 100) as InfectedPercentage
From COVIDDEATHS
Group by Location, population
order by InfectedPercentage desc;

-- countries with highes death count

Select Location, MAX(total_deaths) as TotalDeaths
From COVIDDEATHS
where continent is not null and total_cases is not null
Group by Location
order by TotalDeaths desc;

-- by continent

Select continent, MAX(total_deaths) as TotalDeaths
From COVIDDEATHS
where continent is not null 
Group by continent
order by TotalDeaths desc;

Select Location, MAX(total_deaths) as TotalDeaths
From COVIDDEATHS
where continent is null
Group by Location
order by TotalDeaths desc;

--global numbers for each date

Select date, SUM(new_cases) as total_cases, 
SUM(cast(new_deaths as int)) as total_deaths, 
SUM(new_deaths * 1.0)/SUM(new_cases * 1.0)*100 as DeathPercentage
From COVIDDEATHS
where continent is not null 
Group By date
order by 1,2;

-- global numbers unfiltered

Select SUM(new_cases) as total_cases, 
SUM(cast(new_deaths as int)) as total_deaths, 
SUM(new_deaths * 1.0)/SUM(new_cases * 1.0)*100 as DeathPercentage
From COVIDDEATHS
where continent is not null 
--Group By date
order by 1,2;

--- join the two tables 

Select *
From COVIDVACC vac
join COVIDDEATHS dea 
on dea.location = vac.location 
and dea.date = vac.date;

--- total population and new vaccinations

Select dea.continent, dea.location, dea.date, dea.population,
vac.new_vac
From COVIDVACC vac
join COVIDDEATHS dea 
on dea.location = vac.location 
and dea.date = vac.date
where dea.continent is not null
order by 2,3;

-- with vaccination rolling number

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vac
, SUM(vac.new_vac) OVER (Partition by dea.Location 
Order by dea.location, dea.Date) as RollingPeopleVaccinated
From COVIDDEATHS dea
Join COVIDVACC vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3;

--- vaccination percentage using a CTE

With PopvsVac (Continent, Location, Date, Population, New_Vac, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vac
, SUM(vac.new_vac) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From COVIDDEATHS dea
Join COVIDVACC vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
)
Select *, (RollingPeopleVaccinated/Population)*100 as Percentage
From PopvsVac

