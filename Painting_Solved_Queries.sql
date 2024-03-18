
-- 1.) 
select count(*) from museum where country='USA'

-- 2.) 
select artist.* from artist left outer join work on artist.artist_id=work.artist_id
left outer join museum on work.museum_id=museum.museum_id where museum.name='The Museum of Modern Art'

-- 3.)
select artist.* from artist join work on artist.artist_id=work.artist_id 
join museum on work.museum_id=museum.museum_id where museum.museum_id=43


-- 4.) 
SELECT museum.name AS museum_name, COUNT(DISTINCT artist.artist_id) AS artist_count
FROM museum
JOIN work ON museum.museum_id = work.museum_id
JOIN artist ON work.artist_id = artist.artist_id
GROUP BY museum.name;


-- 5.) 
select work.*,artist.full_name from work join artist on work.artist_id = artist.artist_id 


-- 6.) 
select work_id as id,work.name as work,museum.name as museum_name from work,museum where  museum.museum_id = work.museum_id

-- 7.) 
select name from work where artist_id in
(select artist_id from artist where nationality='German')

-- 8.)
select max(sale_price) as highest_price from product_size

-- 9.) 
SELECT work_id, name, work_id + 100 AS incremented_id
FROM work;

-- 10.)
select concat(full_name,' - ',len(full_name)) as full_name_length from artist where len(full_name)>10

select max(museum_id) from work where style='Symbolism' and museum_id is not null
select * from product_size
-- 11.) 
select name,city from  museum where  museum_id in (
select  museum_id from  museum_hours where day in('Sunday','Monday'))

-- 12.) 
select s.subject from subject s where work_id in
(select top 10 work_id from product_size order by sale_price)

-- 13.) 
select day,count(*) as total from museum_hours where museum_id in
(select museum_id from museum) group by day order by total

-- 14.) 
SELECT m.name AS museum_name
FROM museum m
JOIN (
    SELECT museum_id, COUNT(DISTINCT style) AS max_styles
    FROM work
    GROUP BY museum_id
) AS max_styles_per_museum ON m.museum_id = max_styles_per_museum.museum_id
WHERE max_styles_per_museum.max_styles = (
    SELECT MAX(max_styles)
    FROM (
        SELECT COUNT(DISTINCT style) AS max_styles
        FROM work
        GROUP BY museum_id
    ) AS max_styles_per_museum
)
 