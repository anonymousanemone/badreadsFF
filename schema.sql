CREATE TABLE User 
(
    user_id INT,
    username CHAR(24),
    join_date DATE 
    PRIMARY KEY(user_id)
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
    PRIMARY KEY(fanfic_id)
)

CREATE TABLE Writes
(
    user_id INT,
    fanfic_id INT,
    PRIMARY KEY(user_id, fanfic_id),
    FOREIGN KEY (user_id) REFERENCES User,
    FOREIGN KEY (fanfic_id) REFERENCES Fanfic
)