use ig_clone;

# Identify the five oldest users on Instagram from the provided database.
select id, username, created_at
from users
order by created_at asc
limit 5;

# Task 1: Identify users who have never posted a single photo on Instagram.
select users.id, username
from users
left join photos on users.id = photos.user_id
where photos.user_id is null;

# TRask 2: user with the most likes on a single photo wins.
select username, photos.id, photos.image_url, photos.created_dat, count(likes.user_id) as Total_likes
from photos
inner join likes on likes.photo_id = photos.id
inner join users on photos.user_id = users.id
group by photos.id
order by Total_likes desc
limit 1;

use ig_clone;


#Task 3: Identify and suggest the top five most commonly used hashtags on the platform.
Select tags.tag_name, count(*) as Total
from photo_tags
join tags on photo_tags.tag_id = tags.id
group by tags.id
order by Total desc 
limit 5;


#Task 4: Determine the day of the week when most users register on Instagram.
Select dayname(created_at) as Day, count(*) as Total
from users
group by Day
order by Total desc
limit 1;


# Task 5: Calculate the average number of posts per user on Instagram. Also, provide the total number of photos on Instagram divided by the total number of users.
Select (select count(*) from photos) / (select count(*) from users) as Avg;


# Task 6: Identify users (potential bots) who have liked every single photo on the site, as this is not typically possible for a normal user.
select user_id, count(*) as Num_of_likes
from likes
group by user_id
having Num_of_likes = (select count(*) from photos);

Select users.username, count(*) as Num_of_likes
from users
join likes on users.id = likes.user_id
group by users.id
having Num_of_likes = (select count(*) from photos);






