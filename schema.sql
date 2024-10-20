CREATE TABLE Users 
(
    user_id INT,
    username VARCHAR(24) UNIQUE,
    join_date DATE,
    PRIMARY KEY (user_id)
);

CREATE TABLE Fanfic
(
    fanfic_id INT,
    title VARCHAR(50),
    words INT,
    complete BOOLEAN,
    create_date DATE,
    update_date DATE,
    CHECK (create_date <= update_date),
    PRIMARY KEY (fanfic_id)
);

CREATE TABLE Fandom
(
    fandom_name VARCHAR(50),
    fandom_type VARCHAR(20),
    descript VARCHAR(250),
    PRIMARY KEY (fandom_name)
);

CREATE TABLE Comment
(
    comment_id INT,
    content VARCHAR(1000),
    posted_date DATE,
    PRIMARY KEY (comment_id)
);

CREATE TABLE Tag
(
    tag_name VARCHAR(30),
    tag_descript VARCHAR(250),
    PRIMARY KEY (tag_name)
);

--NOTE: We can't model the paticipation constraint yet in SQL.
CREATE TABLE Writes
(
    user_id INT,
    fanfic_id INT,
    PRIMARY KEY (user_id, fanfic_id),
    FOREIGN KEY (user_id) REFERENCES Users,
    FOREIGN KEY (fanfic_id) REFERENCES Fanfic
);

--NOTE: We can't model the paticipation constraint yet in SQL.
CREATE TABLE Belongs_To
(
    fanfic_id INT,
    fandom_name VARCHAR(50),
    PRIMARY KEY (fanfic_id, fandom_name),
    FOREIGN KEY (fanfic_id) REFERENCES Fanfic,
    FOREIGN KEY (fandom_name) REFERENCES Fandom
);

-- Merged Fictional_Character and Part_Of tables
CREATE TABLE Character_Part_Of
(
    fandom_name VARCHAR(50) NOT NULL,
    char_name VARCHAR(50),
    gender VARCHAR(20),
    PRIMARY KEY (char_name), --key constraint
    FOREIGN KEY (fandom_name) REFERENCES Fandom
);

CREATE TABLE In_Relationship
(
    first_char VARCHAR(50),
    second_char VARCHAR(50),
    relation_type VARCHAR(1),
    PRIMARY KEY (first_char, second_char),
    FOREIGN KEY (first_char) REFERENCES Character_Part_Of,
    FOREIGN KEY (second_char) REFERENCES Character_Part_Of,
    CHECK (first_char <= second_char)  -- Enforces alphabetic order to remove duplicate pairings
);

CREATE TABLE Rates
(
    user_id INT NOT NULL,
    fanfic_id INT,
    rate_date DATE,
    rate_value INT,
    CHECK (rate_value >= 1 and rate_value <= 10),
    PRIMARY KEY (user_id, fanfic_id),
    FOREIGN KEY (user_id) REFERENCES Users,
    FOREIGN KEY (fanfic_id) REFERENCES Fanfic
);

--NOTE: We can't model the paticipation constraint yet in SQL.
CREATE TABLE Comments_On
(
    comment_id INT,
    user_id INT NOT NULL,
    fanfic_id INT,
    PRIMARY KEY (comment_id, fanfic_id), --key constraint
    FOREIGN KEY (comment_id) REFERENCES Comment,
    FOREIGN KEY (user_id) REFERENCES Users,
    FOREIGN KEY (fanfic_id) REFERENCES Fanfic
);

--NOTE: We can't model the paticipation constraint yet in SQL.
CREATE TABLE Tagged_With
(
    fanfic_id INT,
    tag_name VARCHAR(30),
    PRIMARY KEY (fanfic_id, tag_name),
    FOREIGN KEY (fanfic_id) REFERENCES Fanfic,
    FOREIGN KEY (tag_name) REFERENCES Tag
);

CREATE TABLE Parent_Of
(
    child_id INT,
    parent_id INT NOT NULL,
    PRIMARY KEY (child_id),  -- key constraint
    FOREIGN KEY (child_id) REFERENCES Comment,
    FOREIGN KEY (parent_id) REFERENCES Comment,
    CHECK(parent_id != child_id)
);