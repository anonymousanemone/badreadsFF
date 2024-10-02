CREATE TABLE User 
(
    user_id INT,
    username CHAR(24),
    join_date DATE,
    PRIMARY KEY (user_id)
)

CREATE TABLE Fanfic
(
    fanfic_id INT,
    words INT,
    title TEXT,
    complete BOOLEAN,
    create_date DATE,
    update_date DATE,
    PRIMARY KEY (fanfic_id)
)

CREATE TABLE Fandom
(
    fandom_name TEXT,
    fandom_type TEXT,
    descript TEXT,
    PRIMARY KEY (fandom_name)
)

CREATE TABLE Fictional_Character
(
    char_name TEXT,
    gender TEXT,
    PRIMARY KEY (char_name)
)

CREATE TABLE Comment
{
    comment_id TEXT,
    content TEXT,
    posted_date DATE,
    PRIMARY KEY (comment_id)
}

CREATE TABLE Rating
{
    rating_id INT,
    rate_value INT,
    rate_date DATE,
    PRIMARY KEY (rating_id)
}

CREATE TABLE Tag
{
    tag_name TEXT,
    tag_descript TEXT,
    PRIMARY KEY (tag_name)
}

--NOTE: We can't model the paticipation constraint yet in SQL.
CREATE TABLE Writes
(
    user_id INT,
    fanfic_id INT,
    PRIMARY KEY (user_id, fanfic_id),
    FOREIGN KEY (user_id) REFERENCES User,
    FOREIGN KEY (fanfic_id) REFERENCES Fanfic
)

--NOTE: We can't model the paticipation constraint yet in SQL.
CREATE TABLE Belongs_To
(
    fanfic_id INT,
    fandom_name TEXT,
    PRIMARY KEY (fanfic_id, fandom_name),
    FOREIGN KEY (fanfic_id) REFERENCES Fanfic,
    FOREIGN KEY (fandom_name) REFERENCES Fandom
)

CREATE TABLE Part_Of
(
    fandom_name TEXT NOT NULL,
    char_name TEXT,
    PRIMARY KEY (char_name), --key constraint
    FOREIGN KEY (fandom_name) REFERENCES Fandom,
    FOREIGN KEY (char_name) REFERENCES Fictional_Character
)

CREATE TABLE Relationship
(
    first_char TEXT,
    second_char TEXT,
    relation_type TEXT,
    PRIMARY KEY (first_char, second_char),
    FOREIGN KEY (first_char) REFERENCES Fictional_Character,
    FOREIGN KEY (second_char) REFERENCES Fictional_Character
)

CREATE TABLE Rates
{
    rating_id INT,
    user_id INT NOT NULL,
    fanfic_id INT,
    PRIMARY KEY (rating_id, fanfic_id),  -- key constraint
    FOREIGN KEY (rating_id) REFERENCES Rating,
    FOREIGN KEY (user_id) REFERENCES User,
    FOREIGN KEY (fanfic_id) REFERENCES Fanfic
}

CREATE TABLE Comments_On
{
    comment_id TEXT,
    user_id INT NOT NULL,
    fanfic_id INT,
    PRIMARY KEY (comment_id, fanfic_id), --key constraint
    FOREIGN KEY (comment_id) REFERENCES Comments,
    FOREIGN KEY (user_id) REFERENCES User,
    FOREIGN KEY (fanfic_id) REFERENCES Fanfic
}

--NOTE: We can't model the paticipation constraint yet in SQL.
CREATE TABLE Tagged_With
{
    fanfic_id INT,
    tag_name TEXT,
    PRIMARY KEY (fanfic_id, tag_name),
    FOREIGN KEY (fanfic_id) REFERENCES Fanfic,
    FOREIGN KEY (tag_name) REFERENCES Tag,
}

CREATE TABLE Parent_Of
{
    child_id INT,
    parent_id INT NOT NULL,
    PRIMARY KEY (child_id),  -- key constraint
    FOREIGN KEY (child_id) REFERENCES Comment
    FOREIGN KEY (parent_id) REFERENCES Comment
}