CREATE TABLE User 
(
    user_id INT,
    username TEXT UNIQUE,
    join_date DATE,
    PRIMARY KEY (user_id)
)

CREATE TABLE Fanfic
(
    fanfic_id INT,
    title TEXT,
    words INT,
    complete BOOLEAN,
    create_date DATE,
    update_date DATE,
    CHECK (create_date <= update_date),
    PRIMARY KEY (fanfic_id)
)

CREATE TABLE Fandom
(
    fandom_name TEXT,
    fandom_type TEXT,
    descript TEXT,
    PRIMARY KEY (fandom_name)
)

CREATE TABLE Comment
{
    comment_id TEXT,
    content TEXT,
    posted_date DATE,
    PRIMARY KEY (comment_id)
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

-- Merged Fictional_Character and Part_Of tables
CREATE TABLE Character_Part_Of
(
    fandom_name TEXT NOT NULL,
    char_name TEXT,
    gender TEXT,
    PRIMARY KEY (char_name), --key constraint
    FOREIGN KEY (fandom_name) REFERENCES Fandom
)

CREATE TABLE In_Relationship
(
    first_char TEXT,
    second_char TEXT,
    relation_type TEXT,
    PRIMARY KEY (first_char, second_char),
    FOREIGN KEY (first_char) REFERENCES Character_Part_Of,
    FOREIGN KEY (second_char) REFERENCES Character_Part_Of,
    CHECK (first_char <= second_char)  -- Enforces alphabetic order to remove duplicate pairings
)

CREATE TABLE Rates
{
    user_id INT NOT NULL,
    fanfic_id INT,
    rate_date DATE,
    rate_value INT,
    CHECK (rate_value >= 1 and rate_value <= 10),
    PRIMARY KEY (user_id, fanfic_id),
    FOREIGN KEY (user_id) REFERENCES User,
    FOREIGN KEY (fanfic_id) REFERENCES Fanfic
}

--NOTE: We can't model the paticipation constraint yet in SQL.
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
    FOREIGN KEY (tag_name) REFERENCES Tag
}

CREATE TABLE Parent_Of
{
    child_id INT,
    parent_id INT NOT NULL,
    PRIMARY KEY (child_id),  -- key constraint
    FOREIGN KEY (child_id) REFERENCES Comment,
    FOREIGN KEY (parent_id) REFERENCES Comment
}