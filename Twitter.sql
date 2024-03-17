CREATE TABLE tweets
(
UserID varchar,
Gender varchar(20),
LocationID INT,
City char(30),
State char(40),
StateCode varchar(20),
Country char(40),
TweetID varchar(30),
Hour int,
Day int,
Weekday char(15),
IsReshare char(10),
Reach int,
RetweetCount int,
Likes int,
Klout int,
Sentiment float,
Lang char(15),
text varchar
);






COPY tweets (UserID, Gender, LocationID, City, State, StateCode, Country, TweetID, Hour, Day, Weekday, IsReshare, Reach, RetweetCount, Likes, Klout, Sentiment, Lang, text)
FROM 'C:\Users\Siddhesh\Desktop\SQL\Reference\tweets-engagement-metrics\tweets.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM tweets;

--1-Retrieve the total number of tweets in the dataset.

SELECT COUNT(TweetID) AS TOTAL_NO_OF_TWEETS
FROM tweets;

--2-Find the number of distinct users (UserID) in the dataset.

SELECT COUNT(DISTINCT(UserID)) FROM tweets;

--3-Calculate the average number of likes per tweet.

SELECT tweetid, ROUND(AVG(likes), 2) AS AVG_LIKES
FROM tweets
GROUP BY tweetid
ORDER BY AVG_LIKES DESC;

--4-Identify tweets where the sentiment is 'Positive.' Display the TweetID and sentiment.

SELECT tweetid, sentiment
FROM tweets
WHERE sentiment > 0;

--5-Count the number of tweets where IsReshare is true (1).

SELECT COUNT(tweetid) AS No_of_Tweets FROM tweets
WHERE isreshare = 'TRUE';

--6-List the top 5 users with the highest Reach. Display their UserID and Reach

SELECT userid, reach
FROM tweets
ORDER BY reach DESC, userid
LIMIT 5;

--7-Find the most common language (Lang) used in tweets.

SELECT lang, COUNT(lang) AS NO
FROM tweets
GROUP BY lang
ORDER BY NO desc
LIMIT 1;

--8-Determine the average Klout score for male (Gender = 'Male') users.

SELECT ROUND(AVG(klout), 2) AS Avg_male_klout_score
FROM tweets
WHERE gender = 'Male';

--9-Retrieve tweets posted on weekdays (Monday to Friday).

SELECT tweetid, text
FROM tweets
WHERE weekday NOT IN ('Saturday', 'Sunday');

--10-Identify tweets with a Klout score greater than 50. Display the TweetID and Klout.

SELECT tweetid, klout
FROM tweets
WHERE klout > 50;

--11-Count the number of tweets posted from the United States (Country = 'United States').

SELECT COUNT(tweetid)
FROM tweets
WHERE country = 'United States';

--12-List tweets with the highest number of retweets. Display the TweetID and RetweetCount.

SELECT tweetid, retweetcount
FROM tweets
ORDER BY retweetcount DESC
LIMIT 5;

--13-Find tweets with sentiment 'Negative' and Klout score less than 40.

SELECT tweetid, text
FROM tweets
WHERE sentiment < 0 AND klout < 40;

--14-Calculate the average Likes for tweets posted on weekends (Saturday and Sunday).

SELECT weekday, ROUND(AVG(likes), 2) AS Avg_Likes
FROM tweets
WHERE weekday IN ('Saturday', 'Sunday')
GROUP BY weekday;

--15-Retrieve tweets posted in the city of 'New York.'

SELECT tweetid, text
FROM tweets
WHERE city = 'New York City';

--16-Identify tweets where Reach is greater than 1000. Display the TweetID and Reach.

SELECT tweetid, reach
FROM tweets
WHERE reach > 1000;

--17-Find the user (UserID) with the highest total engagement (sum of RetweetCount and Likes).

WITH cte AS (
SELECT userid, SUM(retweetcount) as a, SUM(likes) as b
FROM tweets
GROUP BY userid
)
SELECT userid, a, b
FROM cte
WHERE a = (SELECT MAX(a) FROM cte) AND b = (SELECT MAX(b) FROM cte);

--18-List tweets with sentiment 'Neutral' and Lang as 'English.'

SELECT tweetid, text
FROM tweets
WHERE sentiment = 0 and lang = 'en';

--19-Calculate the total engagement (sum of RetweetCount and Likes) for each tweet.

SELECT tweetid, text, (SUM(retweetcount) + SUM(likes)) as Total_Engagement
FROM tweets
GROUP BY tweetid, text
ORDER BY Total_Engagement DESC;

--20-Retrieve tweets with sentiment 'Positive' or 'Neutral' and Lang as 'English' or 'Spanish.'

SELECT tweetid, text, sentiment, lang
FROM tweets
WHERE sentiment = 0 OR sentiment > 0 and lang = 'en' or lang = 'es';
