/*
    Names - Helena He (UNI: hh3090) and Sophia Ling (UNI: sl4909)
    PostgreSQL Account for Database - hh3090
*/

/*
    Find the most popular fandoms by returning the number of fanfics in each fandom. 
    In order for a fanfic to count in this calculation, it should have at least 1,000 words. 
    Finally, we want to sort the fandoms from most popular to least popular.
    Note: if a fandom does not have any fanfics written yet, it will not be returned.
*/
SELECT B.fandom_name, COUNT(F.fanfic_id) AS num_fics
FROM Belongs_To B NATURAL JOIN Fanfic F
WHERE F.words >= 1000
GROUP BY B.fandom_name
ORDER BY num_fics DESC;

/*
    For each fanfic, list its title, fandom, and averate rating given by users.
    The average rating should be rounded to 2 decimal places.
    If the fanfic hasn't been rated, return 0 for its average rating.
*/
SELECT F.title, B.fandom_name, COALESCE(ROUND(AVG(R.rate_value), 2), 0) AS avg_rating
FROM Belongs_To B 
JOIN Fanfic F ON B.fanfic_id = F.fanfic_id 
LEFT JOIN Rates R ON B.fanfic_id = R.fanfic_id
GROUP BY F.title, B.fandom_name;

/*
    Find the most popular tag in each fandom. Popularity is based on how many fanfics are written
    with each tag. If the fandom doesn't have any fanfics with tags, it will not be included in the
    result. Additionally, if the fandom has multiple tags with the same count, it will return tuples
    for both tags.
*/
WITH TagPopularity AS (
    SELECT B.fandom_name, T.tag_name, COUNT(T.fanfic_id) AS tag_count
    FROM Tagged_With T NATURAL JOIN Belongs_To B
    GROUP BY B.fandom_name, T.tag_name
),
MaxTagCounts AS (
    SELECT fandom_name, MAX(tag_count) AS max_tag_count
    FROM TagPopularity
    GROUP BY fandom_name
)
SELECT TP.fandom_name, TP.tag_name, TP.tag_count
FROM TagPopularity TP
JOIN MaxTagCounts MTC ON TP.fandom_name = MTC.fandom_name AND TP.tag_count = MTC.max_tag_count
ORDER BY TP.fandom_name;