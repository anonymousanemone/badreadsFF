/*
    Names - Helena He (UNI: hh3090) and Sophia Ling (UNI: sl4909)
    PostgreSQL Account for Database - hh3090
*/

/*
    Find the most popular fandoms by returning the number of fanfics in each fandom. 
    In order for a fanfic to count in this calculation, it should have at least 1,000 words. 
    Finally, we want to sort the fandoms from most popular to least popular.
*/
SELECT B.fandom_name, COUNT(F.fanfic_id) AS num_fics
FROM Belongs_To B NATURAL JOIN Fanfic F
WHERE F.words >= 1000
GROUP BY B.fandom_name
ORDER BY num_fics DESC;

/*
    For each fanfic, list its title, fandom, and averate rating given by users.
    If the fanfic hasn't been rated, return 0 for its average rating.
*/
SELECT F.title, B.fandom_name, COALESCE(AVG(R.rate_value), 0) AS avg_rating
FROM Belongs_To B 
JOIN Fanfic F ON B.fanfic_id = F.fanfic_id 
LEFT JOIN Rates R ON B.fanfic_id = R.fanfic_id
GROUP BY F.title, B.fandom_name;

/*
    Find the top romantic pairing in each fandom, excluding crossover ships).
*/
WITH PairingCounts(fandom_name, first_char, second_char, pair_count) AS (
    SELECT C1.fandom_name, R.first_char, R.second_char, COUNT(*) AS pair_count
    FROM In_Relationship R 
    JOIN Character_Part_Of C1 ON R.first_char = C1.char_name
    JOIN Character_Part_Of C2 ON R.second_char = C2.char_name
    WHERE C1.fandom_name = C2.fandom_name AND R.relation_type = 'Romantic'
    GROUP BY C1.fandom_name, R.first_char, R.second_char
)
SELECT fandom_name, first_char, second_char
FROM PairingCounts
WHERE pair_count = (SELECT MAX(pair_count)
                    FROM PairingCounts PC
                    WHERE PC.fandom_name = PairingCounts.fandom_name);