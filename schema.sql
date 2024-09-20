CREATE TABLE User 
(
    user_id INT,
    username CHAR(24),
    join_date DATE ,
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
    avg_rating REAL,
    num_rates INT,
    PRIMARY KEY (fanfic_id)
)

CREATE TABLE Writes
(
    user_id INT,
    fanfic_id INT,
    PRIMARY KEY (user_id, fanfic_id),
    FOREIGN KEY (user_id) REFERENCES User,
    FOREIGN KEY (fanfic_id) REFERENCES Fanfic
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
    fandom_name TEXT,
    char_name TEXT,
    PRIMARY KEY (char_name),
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