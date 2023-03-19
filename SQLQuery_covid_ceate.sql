CREATE TABLE [dbo].[death] (
    [location]                            VARCHAR (50) NULL,
    [iso_code]                            VARCHAR (50) NULL,
    [date]                                DATE         NULL,
    [total_vaccinations]                  INT          NULL,
    [people_vaccinated]                   INT          NULL,
    [people_fully_vaccinated]             INT          NULL,
    [total_boosters]                      INT          NULL,
    [daily_vaccinations_raw]              INT          NULL,
    [daily_vaccinations]                  INT          NULL,
    [total_vaccinations_per_hundred]      INT          NULL,
    [people_vaccinated_per_hundred]       INT          NULL,
    [people_fully_vaccinated_per_hundred] INT          NULL,
    [total_boosters_per_hundred]          INT          NULL,
    [daily_vaccinations_per_million]      INT          NULL,
    [daily_people_vaccinated]             INT          NULL,
    [daily_people_vaccinated_per_hundred] INT          NULL
);

