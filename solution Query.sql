DESC USERS;
SELECT * FROM USERS;
# Markating Based
#1. TO FIND THE 5 OLDEST USERS
select username, created_at from users
order by created_at 
limit 5;

#2. Find users who never posted photoes in instagram
select * from photos,users;
select u.username from
users u 
left join photos p on p.user_id = u.id
where p.image_url is null
order by username;

# 3. Find the winner of the contest and provide the details to the team
select * from likes,photos,users;
select * from likes;

select l.photo_id,u.username, count(l.user_id) as Total_Likes
from likes l
inner join photos p on p.id = l.photo_id
inner join users u on u.id = p.user_id
group by l.photo_id, u.username
order by Total_Likes desc;

# 4. Identify and suggest top 5 most commenly used hastags on the platform
select * from photos;
select * from photo_tags;
select t.tag_name, count(pt.photo_id) as ht
from photo_tags pt 
inner join tags t on t.id= pt.tag_id
group by t.tag_name
order by ht desc
limit 5;

# 5. Which day of the week most users register on? provide insite on when to schedule ad campain
select date_format((created_at), '%W') as dayy, count(username) from users 
group by 1 
order by 2 desc;

#Investment  based
#6. Provide how many time a average does a average user posts on instagram. Also provide the total number of photos on instagram/ total number of users
select * from photos,users;
with base as(
select u.id as userids, count(p.id) as photoid  
from users u
inner join photos p on p.user_id = u.id
group by u.id)
select sum(photoid) as TotalPhotos, count(userids) as TotalUsers, sum(photoid)/count(userids) as PhotoPerUser 
from base;

#7. Provide data on users(bots) who have liked every single photo on the site(since any normal user would not be able to do this)

with base as (
select u.username, count(l.photo_id) as Likess
from likes l 
inner join users u on u.id = l.user_id
group by u.username)
select username, likess from base where likess = (select count(*) from photos) 
order by username;



