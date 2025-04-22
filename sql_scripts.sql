

/* for each director count the number of movies and tv shows created by them in separate columns
*/
select nd.director, count(distinct case when type='Movie' then 1 end) as no_of_movies,
count(distinct case when type='TV Show' then 1 end) as no_of_tv_Shows
from netflix n join netflix_directors nd
on n.show_id=nd.show_id
group by nd.director
having count(n.type)>1;

/* which country has highest no.of comedy movies*/
select nc.country, count(ng.show_id) as no_of_comedy_genres
from netflix n join netflix_countries nc 
on n.show_id=nc.show_id join netflix_genres ng
on nc.show_id=ng.show_id
where n.type='Movie' and ng.genre ='Comedies'
group by nc.country;

/* for each year (as per date added to netflix), which director has maximum number of movies released*/
with cte as(
select nd.director, year(date_added) as date_year, count(n.show_id) as no_of_movies
from netflix n join netflix_directors nd on n.show_id=nd.show_id
group by nd.director,year(date_added)
order by no_of_movies desc)
select *
from(
select *, rank() over(partition by date_year order by no_of_movies desc) rnk
from cte) x
where x.rnk=1;

/* what is the average duration of each genre*/
select ng.genre, round(avg(cast(replace(duration,'min','') as unsigned)),0) as avg_duration
from netflix n join netflix_genres ng
on n.show_id=ng.show_id
where type='Movie'
group by ng.genre;

/* find the list of directors who directed both horror and comedy genres and 
name the director and no of comedy and no of genres per director*/
select nd.director, count(case when genre like '%Comedies%' then 1 end) as no_of_comedies,
count(case when genre like '%Horror%' then 1 end) as no_of_horror
from netflix n join netflix_directors nd 
on n.show_id=nd.show_id join netflix_genres ng
on nd.show_id=ng.show_id
group by nd.director;










