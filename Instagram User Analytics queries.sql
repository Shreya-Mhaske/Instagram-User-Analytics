USE ig_clone;

-- A) Marketing Analysis
-- 1. Identify the five oldest users on Instagram from the provided database. 

select * from users
order by created_at asc
limit 5;

-- 2. Identify users who have never posted a single photo on Instagram.

select u.username, u.id as users_id
from users u 
left join photos p on u.id = p.user_id
where p.id is null
order by u.id;

-- 3. Determine the winner of the contest and provide their details to the team.

select photo_id,count(*) as like_count
from likes
group by photo_id
order by like_count Desc
limit 1;

-- 4. Identify and suggest the top five most commonly used hashtags on the platform

select t.tag_name,count(*) as tags_count
from tags t
join photo_tags pt on t.id = pt.tag_id
group by t.tag_name
order by tags_count desc
limit 5;

-- 5. Determine the day of the week when most users register on Instagram. Provide insights on when to schedule an ad campaign. 

select dayname(created_at) as day_name, count(*) as total_users_registered
from users
group by day_name
order by total_users_registered desc;

-- B) Investor Metrics:
-- 1.Calculate the average number of posts per user on Instagram. Also, provide the total number of photos on Instagram divided by the total number of users.

select count(*) / count(distinct user_id) as avg_post_per_user
from photos;

-- 2.Identify users (potential bots) who have liked every single photo on the site, as this is not typically possible for a normal user.

select id, username 
from users 
where id in
 ( select user_id from likes
 group by user_id 
 having count(user_id) = ( select count(id) from photos));
 