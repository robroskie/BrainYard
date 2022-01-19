-- CREATE DATABASE brainYard;
-- GO;
-- USE brainYard;

DROP TABLE if exists UserLog;
DROP TABLE if exists UStatus;
DROP TABLE if exists GraveYard;
DROP TABLE if exists PayMethod;
DROP TABLE if exists Questions;
DROP TABLE if exists Currency;
DROP TABLE if exists Transactions;
DROP TABLE if exists Ratings;
DROP TABLE if exists Answers;
DROP TABLE if exists Categories;
DROP TABLE if exists BUser;
DROP TABLE if exists CorAnswers;

CREATE TABLE BUser(
    StudentEmail VARCHAR(50),
    Faculty VARCHAR(75),
    UserStatus INTEGER,
    University VARCHAR(100),
    UserName VARCHAR(20),
    Password VARCHAR(20) NOT NULL,
    GPA DECIMAL(2,1),
    UserId INTEGER UNIQUE,
    CurrentYear VARCHAR(10),
    PreferredEmail VARCHAR(50),
    CorAnsTot INTEGER,
    profilepic VARCHAR(15),
    admin VARCHAR(5),
    PRIMARY KEY (StudentEmail, UserId)
);

CREATE TABLE Categories(
    CategoryId INTEGER PRIMARY KEY,
    subjTitle CHAR(40),
    Faculty CHAR(40),
    Difficulty INTEGER,
    CHECK (Difficulty >= 0 AND Difficulty<= 5)
);

CREATE TABLE Answers(
    AnsId INTEGER NOT NULL IDENTITY,
    userId INTEGER,
    PTime DATETIME,
    Category INTEGER DEFAULT 0,
    QId INTEGER,
    Description NVARCHAR(2500),
    AvgRating DECIMAL(3,2) DEFAULT 0.0,
    PRIMARY KEY (AnsId),
    FOREIGN KEY (Category) REFERENCES Categories(CategoryId) ON DELETE SET NULL ON UPDATE SET NULL
);

CREATE TABLE Ratings(
    UserId INTEGER,
    AnsId INTEGER,
    RatingId INTEGER PRIMARY KEY IDENTITY,
    Score INTEGER,
    PTime DATETIME,
    CHECK (Score >= 0 AND Score <= 5),
    FOREIGN KEY (UserId) REFERENCES BUser(UserId) ON DELETE SET NULL ON UPDATE SET NULL,
    FOREIGN KEY (AnsId) REFERENCES Answers(AnsId) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Transactions (
    Transactionid INTEGER UNIQUE,
    Status INTEGER,
    UserId INTEGER,
    CurrTimes   DATETIME,
    DogeAmo INTEGER,
    EtheAmo INTEGER,
    BitAmo INTEGER,
    PRIMARY KEY (transactionid),
    FOREIGN KEY (userId) REFERENCES BUser(UserId)
);

CREATE TABLE Currency (
    bitprice DECIMAL(10,2),
    etheprice DECIMAL(10,2),
    dogeprice DECIMAL(10,2),
    CurTime DATETIME
);

CREATE TABLE Questions(
    QId INTEGER NOT NULL IDENTITY,
    UserId INTEGER,
    Description NVARCHAR(2500),
    Category INTEGER,
    TimeUntilClose DATETIME,
    postTime DATETIME,
    PRIMARY KEY (QId),
    FOREIGN KEY (Category) REFERENCES Categories(CategoryId),
    FOREIGN KEY (UserId) REFERENCES BUser(UserId)
);

CREATE TABLE PayMethod (
    UserId INTEGER PRIMARY KEY,
    DogeAd VARCHAR(50),
    BitAd  VARCHAR(50),
    EthAd  VARCHAR(50),
    DogeAmount  INTEGER,
    BitAmount   INTEGER,
    EthAmount   INTEGER,
    FOREIGN KEY (UserId) REFERENCES BUser(UserId)
);




CREATE TABLE GraveYard (
    YardId INTEGER PRIMARY KEY,
    AnsId INTEGER,
    Status  CHAR(40),
    QId  INTEGER,
    FOREIGN KEY (AnsId) REFERENCES Answers(AnsId),
    FOREIGN KEY (QId) REFERENCES Questions(QId)
);


CREATE TABLE UStatus(
    StatId INTEGER PRIMARY KEY,
    Name VARCHAR(10),
    DogX INTEGER,
    BitX DECIMAL(6,4),
    EthX DECIMAl(6,4),
    CHECK (StatId >= 0 AND StatId <= 5)
);


CREATE TABLE UserLog(
  StudentEmail VARCHAR(50),
  UserId INTEGER,
  LogId INTEGER,
  AccessIp  INTEGER,
  StartTime DATETIME,
  EndTime DATETIME,
  PRIMARY KEY (StudentEmail, LogId),
  FOREIGN KEY (StudentEmail, UserId) REFERENCES BUser(StudentEmail, UserId)

);

CREATE TABLE CorAnswers(
    Qid INTEGER,
    userId INTEGER,
    Description NVARCHAR(2500),
    Avgscore DECIMAL(4,3)
);

                 



INSERT BUser(StudentEmail, Faculty, UserStatus, University, UserName, Password, GPA, UserId, CurrentYear, PreferredEmail, CorAnsTot, profilepic, admin) VALUES ('joegaspari@ubc.com', 'Biochemistry', 2, 'UBC', 'jgaspari', 'hello1', 4.0, 1, 'Comp', 'joegaspari6@gmail.com', null, 'Avatars/1.png','true');
INSERT BUser(StudentEmail, Faculty, UserStatus, University, UserName, Password, GPA, UserId, CurrentYear, PreferredEmail, CorAnsTot, profilepic, admin) VALUES ('kevindowel@sfu.com', 'English', 1, 'Simon-Fraser-University', 'bookGod', '2smart4u', 3.4, 2, '3', 'kDowel@hotmail.com', null, 'Avatars/2.png', 'false');
INSERT BUser(StudentEmail, Faculty, UserStatus, University, UserName, Password, GPA, UserId, CurrentYear, PreferredEmail, CorAnsTot, profilepic, admin) VALUES ('alexking@capilanou.ca', 'Art-History', 1, 'Capilano-University', 'ArtPOP', '12345', 2.4, 3, '2', 'artpopqueen@gmail.com', null, 'Avatars/3.png', 'false');
INSERT BUser(StudentEmail, Faculty, UserStatus, University, UserName, Password, GPA, UserId, CurrentYear, PreferredEmail, CorAnsTot, profilepic, admin) VALUES ('ninasorini@tru.ca', 'Economics', 4, 'Trinity-Western University', 'ninaS1234', 'ninas12345', 4.0, 4, '4', 'ninasorini6@yahoo.ca', null, 'Avatars/4.png', 'false');
INSERT BUser(StudentEmail, Faculty, UserStatus, University, UserName, Password, GPA, UserId, CurrentYear, PreferredEmail, CorAnsTot, profilepic, admin) VALUES ('lucascollings@ubc.ca', 'Math', 2, 'UBC', 'LCollings', 'mathisfun12', 2.5, 5, '4', 'lcollings@hotmail.com', null, 'Avatars/5.png', 'false');
INSERT BUser(StudentEmail, Faculty, UserStatus, University, UserName, Password, GPA, UserId, CurrentYear, PreferredEmail, CorAnsTot, profilepic, admin) VALUES ('trevorMcdown@ucalgary.ca', 'Cultural-Studies', 3, 'University-of-Calgary', 'Mcdownknows', 'hay1234', 3.5, 6, '1', null, null, 'Avatars/6.png', 'false');
INSERT BUser(StudentEmail, Faculty, UserStatus, University, UserName, Password, GPA, UserId, CurrentYear, PreferredEmail, CorAnsTot, profilepic, admin) VALUES ('giuliano@tru.ca', 'Computer-Science', 5, 'Trinity-Western-University', 'GaryIuliano1', 'irapsag123', 3.4, 7, '4', 'giuliano45@hotmail.com', null, 'Avatars/7.png', 'false');
INSERT BUser(StudentEmail, Faculty, UserStatus, University, UserName, Password, GPA, UserId, CurrentYear, PreferredEmail, CorAnsTot, profilepic, admin) VALUES ('williamchen@ubc.ca', 'Biology', 1, 'UBC', 'CHEN242', '12345CHEN', 2.0, 8, 'Comp', 'will.Chen@gmail.com', null, 'Avatars/8.png', 'false');
INSERT BUser(StudentEmail, Faculty, UserStatus, University, UserName, Password, GPA, UserId, CurrentYear, PreferredEmail, CorAnsTot, profilepic, admin) VALUES ('jacobharding@sfu.com', 'Chemisty', 3, 'Simon-Fraser-University', 'JakeRakes', 'rakesincash', 4.0, 9, '2', 'jake.harding@yahoo.ca', null, 'Avatars/9.png', 'false');
INSERT BUser(StudentEmail, Faculty, UserStatus, University, UserName, Password, GPA, UserId, CurrentYear, PreferredEmail, CorAnsTot, profilepic, admin) VALUES ('junekang@tru.ca', 'Data-Science', 5, 'Trinity-Western-University', 'KINGKang', 'Jun-21', 3.2, 10, '3', 'jkang@hotmail.com', null, 'Avatars/10.png', 'false');

INSERT Categories(CategoryID, subjTitle, Faculty, Difficulty) VALUES (0,'null','null',0);
INSERT Categories(CategoryID, subjTitle, Faculty, Difficulty) VALUES (1,'Anthropology','Arts and Science',2);
INSERT Categories(CategoryID, subjTitle, Faculty, Difficulty) VALUES (2,'Applied Science','Applied Sciences',5);
INSERT Categories(CategoryID, subjTitle, Faculty, Difficulty) VALUES (3,'Art History','Creative and Critical Studies',3);
INSERT Categories(CategoryID, subjTitle, Faculty, Difficulty) VALUES (4,'Biology','Arts and Science',4);
INSERT Categories(CategoryID, subjTitle, Faculty, Difficulty) VALUES (5,'Chemistry','Arts and Science',4);
INSERT Categories(CategoryID, subjTitle, Faculty, Difficulty) VALUES (6,'Creative Writing','Creative and Critical Studies',2);
INSERT Categories(CategoryID, subjTitle, Faculty, Difficulty) VALUES (7,'Computer Science','Arts and Science',4);
INSERT Categories(CategoryID, subjTitle, Faculty, Difficulty) VALUES (8,'Economics','Arts and Sciences',3);
INSERT Categories(CategoryID, subjTitle, Faculty, Difficulty) VALUES (9,'Environmental Sciences','Arts and Sciences',2);
INSERT Categories(CategoryID, subjTitle, Faculty, Difficulty) VALUES (10,'Psychology','Arts and Sciences',2);
INSERT Categories(CategoryID, subjTitle, Faculty, Difficulty) VALUES (11,'Mathematics ','Arts and Sciences',5);
INSERT Categories(CategoryID, subjTitle, Faculty, Difficulty) VALUES (12,'History','Arts and Sciences',1);
INSERT Categories(CategoryID, subjTitle, Faculty, Difficulty) VALUES (13,'Physics','Arts and Sciences', 3);
INSERT Categories(CategoryID, subjTitle, Faculty, Difficulty) VALUES (14,'Management','Managment',2);





INSERT Answers(userId, PTime, Category, QId, Description) VALUES (2, '2011-01-14 12:12', 4, 1, 'The large surface area of a mycelium makes them such effective decomposers');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (1, '2011-01-20 12:12', 4, 1, 'They grow towards dead tissues');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (3, '2011-01-21 12:12', 4, 1, 'They secrete a strong acidic substance that rapidly breaks down proteins');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (8, '2012-04-12 12:12', 4, 2, 'Using a gRNA protein sequence that includes the desired cut peptide sequence');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (9, '2012-04-15 12:12', 4, 2, 'Two proteins bind to dna and cut it');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (1, '2012-04-16 12:12', 5, 3, 'It can bed light at a different polarity');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (8, '2012-04-17 12:12', 5, 3, 'The molecule has a copy or mirror image of itself that has different chemical properties');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (7, '2012-04-19 12:12', 5, 3, 'The molecule has S/R properties that define the trigonometry of it in 3D space');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (5, '2012-04-20 12:12', 5, 3, 'It has the ability to bend light at a different angle');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (3, '2012-04-22 12:12', 5, 3, 'It means it can react to acids more intensely');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (4, '2015-07-12 12:12', 12, 4, 'Hans Janssen');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (5, '2015-07-15 12:12', 12, 4, 'Pasture');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (7, '2015-11-21 12:12', 13, 5, 'density');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (8, '2015-11-26 12:12', 13, 5, 'Purity');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (9, '2015-11-27 12:12', 13, 5, 'Viscosity');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (8, '2015-11-21 12:12', 4, 6, 'Hemoglobin Myoglobin and BS albumin would all be included. Myosin and Galatin would not be included and Vitamin B12 and C would fraction out completely');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (9, '2016-01-04 12:12', 4, 6, 'Hemoglobin BS albumin would all be included. Myosin+Myoglobin+Galatin would not be included and Vitamin B12 and C would fraction out completely');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (4, '2016-01-11 12:12', 3, 8, 'Leonardo Da Vinci');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (8, '2016-01-14 12:12', 3, 8, 'Pablo Picaso');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (10, '2016-02-08 12:12', 3, 8, 'Grant Wood');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (2, '2016-01-15 12:12', 6, 9, 'Neoclassicism as a label is applied to a period of English literature lasting from 1660 the Restoration of Charles II till about 1800');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (1, '2016-02-01 12:12', 6, 9, 'The prefix neo means new while classical refers to a return to the ideologies set in place by Greeks and Romans during the Classic period');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (5, '2016-01-23 12:12', 8, 10, 'Macro looks at the big picture while Micro looks at individuals and the small relationships amongst them');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (9, '2016-01-27 12:12', 8, 10, 'Economics is divided into two categories: microeconomics and macroeconomics. Microeconomics is the study of individuals and business decisions while macroeconomics looks at the decisions of countries and governments');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (4, '2016-01-29 12:12', 8, 10, 'Microeconomics is the study of particular markets and segments of the economy. It looks at issues such as consumer behaviour individual labour markets and the theory of firms.Macro economics is the study of the whole economy. It looks at aggregate variables such as aggregate demand national output and inflation.');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (1, '2016-02-20 12:12', 7, 11, 'Int size = 5 for (int x=0 x<=size x++)');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (10, '2016-02-22 12:12', 7, 11, 'for (int x=0 x<=size x++) as we use int x to be a counter of a sort that increments upwards we check the condition. We exit the loop once the constraint is met. Best to set the constraint outside the loop as it will need to be initialized to continually check your constraint');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (2, '2017-01-26 12:12', 6, 12, 'Formalist Criticism designates an approach to understanding narratives that is rooted in close attention to how meaning is conveyed. It begins from the premise that form and content are closely related');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (10, '2017-02-11 12:12', 6, 12, 'The comparison of one thing to another in which there is a literal substitution her love is a tsunami.');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (1, '2017-02-12 12:12', 4, 13, 'IS the cyclic phosphorylation of ADP to form ATP which is then consumed as an energy source');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (8, '2017-02-27 12:12', 4, 13, 'The process most occurs in plants in photosystem 1');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (9, '2017-02-24 12:12', 4, 14, 'enzyme RuBisCO incorporates carbon dioxide into an organic molecule 3-PGa organic molecule is reduced using electrons supplied by NADPH RuBP molecule that starts the cycle is regenerated so that the cycle can continue');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (1, '2017-02-07 12:12', 10, 15, 'Alzheimers');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (9, '2017-02-20 12:12', 10, 15, 'Parkinsons Disease');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (10, '2017-02-21 12:12', 10, 15, 'Dopamine Deficiency');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (4, '2017-03-01 12:12', 4, 16, 'Taste-buds');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (5, '2017-03-02', 4, 16, 'papillae');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (3, '2017-02-20', 8, 17, 'Due to the possible presence of a third hidden variable unknown to both parties that is causing an unseen force that either positively or negatively influences the data');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (7, '2017-02-28 12:12', 8, 17, 'Behavior is too complex variable and reactive to allow for cause and effect determinations');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (1, '2017-03-04 12:12', 8, 17, 'If two variables are correlated then by definition one cannot cause the other');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (4, '2017-03-06 12:12', 8, 17, 'Correlational studies are not empirical');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (3, '2017-03-14 12:12', 12, 18, 'Philospher the mind body problem');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (4, '2017-03-15 12:12', 12, 18, 'Was both a physicist and philosopher whos work encompasses both the mind body problem and advances in fluid dynamics');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (10, '2017-04-20 12:12', 4, 19, 'Cerebellum');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (8, '2017-04-22 12:12', 4, 19, 'Cerebellum and Motor Cortex');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (1, '2017-05-12 12:12', 4, 19, 'Cerebellum and Motor Cortex');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (7, '2018-04-19 12:12', 10, 20, 'Through neurological mechanisms underlying observable behavior.');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (2, '2018-05-02 12:12', 10, 20, 'Mental processes such as memory perception and thought.');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (1, '2018-05-24 12:12', 4, 21, 'As the cell is in prophase it has 24');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (5, '2018-05-27 12:12', 4, 21, 'Has 48 as the cell is about to split');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (9, '2018-06-11 12:12', 4, 21, 'The cell is full and expressing normal numbers of 24');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (8, '2018-06-11 12:12', 4, 21, 'The cell is full and expressing normal numbers of 48');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (2, '2019-06-11 12:12', 12, 22, '19th century 1960s then 1990s');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (3, '2019-06-18 12:12', 12, 22, 'The strongest and most talked about is the third way from around 1990s onward');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (6, '2019-06-29 12:12', 12, 22, 'First wave – 19th century equal rights under law Second wave – 1960s personal is political reproductive rights Third wave – from mid 1990s – challenging fixed gender categories reclaiming of negative language (e.g. Slut-walk).');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (10, '2020-07-05 12:12', 10, 23, 'Lucid dreaming being aware in the dream');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (5, '2020-07-10 12:12', 10, 23, 'Having full memories of the dreams in a waking state as to cause a confusion with reality');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (4, '2020-07-14 12:12', 10, 23, 'Having an in-between like dream state where you feel awake');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (10, '2020-07-12 12:12', 5, 24, '6CO2 + 6H2O → C6H12O6 + 6O2.');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (9, '2020-07-15', 5, 24, 'six carbon dioxide molecules and six water molecules are converted by light energy captured by chlorophyll into a sugar molecule and six oxygen molecules');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (6, '2020-08-04 12:12', 1, 25, 'The use of paper for hygiene has been recorded in China in the 6th century AD with specifically manufactured toilet paper being mass-produced in the 14th century.Modern commercial toilet paper originated in the 19th century with a patent for roll-based dispensers being made in 1883');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (1, '2020-07-23 12:12', 4, 26, 'Controls the direction of the stemming of buds');
INSERT Answers(userId, PTime, Category, QId, Description) VALUES (8, '2020-07-25 12:12', 4, 26, 'Auxins are a powerful growth hormone produced naturally by plants. They are found in shoot and root tips and promote cell division stem and root growth. They can also drastically affect plant orientation by promoting cell division to one side of the plant in response to sunlight and gravity.');



INSERT Currency(bitprice, etheprice, dogeprice, CurTime) VALUES(41023.46, 2816.46, 000.20, '2021-08-05 16:07:45');


INSERT Questions(UserId, Description, Category, TimeUntilClose, postTime) VALUES (8, 'What adaptations make fungi such effective decomposers?', 4, '2011-01-12 12:12:12', '2021-08-08 12:12:12');
INSERT Questions(UserId, Description, Category, TimeUntilClose, postTime) VALUES (1, 'How does a Cas9 protein recognize its complementing genetic target sequence?', 4, '2021-04-11 12:12:12', '2021-05-11 12:12:12');
INSERT Questions(UserId, Description, Category, TimeUntilClose, postTime) VALUES (9, 'What does it mean for a molecule to have chirality?', 5, '2012-04-21 12:12:12', '2021-05-21 12:12:12');
INSERT Questions(UserId, Description, Category, TimeUntilClose, postTime) VALUES (8, 'Who invented the first microscope?', 12, '2015-07-08 12:12:12', '2021-08-08 12:12:12');
INSERT Questions(UserId, Description, Category, TimeUntilClose, postTime) VALUES (5, 'The measure of how greatly a substance slows the velocity of light is referred to as (blank)?', 13, '2015-11-19 12:12:12', '2021-01-19 12:12:12');
INSERT Questions(UserId, Description, Category, TimeUntilClose, postTime) VALUES (1, 'If a particular gel chromatography column is said to have a size exclusion range of 2000 - 100000 Daltons indicate after the name of the compound whether it would be fractionated completely included or completely excluded from the column? (2 marks)(Hemoglobin� 65000)(Myoglobin� 17000)(Myosin� 180000)(Galatin� 150000)(BS Albumin� 66430)(Vitamin B12 1350)(Vitamin C� 1760)', 4, '2015-11-20 12:12:12', '2021-08-28 12:12:12');
INSERT Questions(UserId, Description, Category, TimeUntilClose, postTime) VALUES (7, 'Consider a population governed by the discrete distribution p(x) where p(x) = _ for x = 1 and p(x) = 1 _ _ for x = 0 where _ _ [0 1]. Three independent observations are {0 1 0}. Find the likelihood function', 11, '2016-01-09 12:12:12', '2021-09-09 12:12:12');
INSERT Questions(UserId, Description, Category, TimeUntilClose, postTime) VALUES (6, 'Which painter is often associated with Francoise Gilot?', 3, '2016-01-09 12:12:12', '2016-08-09 12:12:12');

INSERT Questions(UserId, Description, Category, TimeUntilClose, postTime) VALUES (6, 'What are the features of neoclassical poetry?�', 6, '2021-01-15 19:08:05','2021-01-17 20:22:10');
INSERT Questions(UserId, Description, Category, TimeUntilClose, postTime) VALUES (2, 'What is the difference between micro and marco economics?', 8, '2021-11-05 21:50:43','2022-05-11 17:50:17');
INSERT Questions(UserId, Description, Category, TimeUntilClose, postTime) VALUES (4, 'How do you write a for loop in java??', 7, '2021-10-08 00:56:47','2022-01-10 18:26:11');
INSERT Questions(UserId, Description, Category, TimeUntilClose, postTime) VALUES (6, 'What is Formalist Criticism and how can it be used?', 6, '2021-07-16 07:54:35','2021-05-20 13:15:34');
INSERT Questions(UserId, Description, Category, TimeUntilClose, postTime) VALUES (5, 'What is cyclic phosphorylation?', 4, '2021-08-10 09:32:58','2021-08-31 18:24:25');
INSERT Questions(UserId, Description, Category, TimeUntilClose, postTime) VALUES (8, 'List the 3 phases of the Calvin Cycle', 4, '2021-03-24 06:00:23','2021-05-09 16:25:29');
INSERT Questions(UserId, Description, Category, TimeUntilClose, postTime) VALUES (8, 'The actor Michael J. Fox suffers from Parkinsons disease and John Nash subject of the movie A Beautiful Mind was a paranoid schizophrenic. The brains of both people can be characterized as having?', 10, '2020-12-03 03:18:53','2021-11-23 08:01:05');
INSERT Questions(UserId, Description, Category, TimeUntilClose, postTime) VALUES (10, 'What are the small visible bumps on the tongue called?', 4, '2021-01-24 05:26:34','2022-03-31 10:51:43');
INSERT Questions(UserId, Description, Category, TimeUntilClose, postTime) VALUES (5, 'Why can�t you claim a cause and effect relationship with correlational studies?', 8, '2021-05-15 22:37:37','2021-02-25 18:39:02');
INSERT Questions(UserId, Description, Category, TimeUntilClose, postTime) VALUES (10, 'Helmholtz was a(n) __________ who studied ________?', 12, '2020-12-31 23:52:10','2021-08-04 09:47:11');
INSERT Questions(UserId, Description, Category, TimeUntilClose, postTime) VALUES (3, 'What is the brain region that is associated with movement?', 4, '2021-08-31 13:01:57','2021-12-08 21:01:06');
INSERT Questions(UserId, Description, Category, TimeUntilClose, postTime) VALUES (6, 'How does cognitive psychology address the critiques of behaviorism through applying scientific methods to the study of what?', 10, '2020-10-24 13:16:12','2022-06-21 16:11:46');
INSERT Questions(UserId, Description, Category, TimeUntilClose, postTime) VALUES (7, 'A cell in prophase II of meiosis contains 12 chromosomes. How many chromosomes would be present in a cell from the same organism if it were in prophase of mitosis?', 4, '2018-05-22 12:12:12', '2021-08-22 12:12:12');
INSERT Questions(UserId, Description, Category, TimeUntilClose, postTime) VALUES (8, 'What were the three waves of the feminist movement?', 12, '2022-02-07 21:43:41','2021-04-18 08:11:57');
INSERT Questions(UserId, Description, Category, TimeUntilClose, postTime) VALUES (2, 'What is dream consciousness characterized by?', 10, '2020-06-29 12:12:12', '2020-08-29 12:12:12');
INSERT Questions(UserId, Description, Category, TimeUntilClose, postTime) VALUES (1, 'What is the chemical formula for photosynthesis', 5, '2020-06-30 12:12:12', '2020-07-30 12:12:12');
INSERT Questions(UserId, Description, Category, TimeUntilClose, postTime) VALUES (2, 'When was the earliest known use of toilet paper and how do we come to know the use of it today?', 1, '2020-07-05 12:12:12', '2021-08-06 12:12:12');
INSERT Questions(UserId, Description, Category, TimeUntilClose, postTime) VALUES (4, 'How does Auxin play a role in plant growth and development?', 4, '2020-08-06 12:12:12', '2021-08-20 11:11:11');

-- Extra sample questions for testing
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (8,'quis urna. Nunc quis arcu',11,'2021-01-15 19:08:05','2021-01-17 20:22:10');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (10,'pharetra. Quisque ac libero nec ligula',5,'2021-11-05 21:50:43','2022-05-11 17:50:17');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (7,'accumsan convallis, ante lectus convallis est,',12,'2021-10-08 00:56:47','2022-01-10 18:26:11');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (8,'et libero. Proin mi. Aliquam gravida mauris',3,'2021-07-16 07:54:35','2021-05-20 13:15:34');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (9,'vel turpis. Aliquam adipiscing lobortis',2,'2021-08-10 09:32:58','2021-07-31 18:24:25');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (7,'malesuada vel, convallis in, cursus et, eros.',1,'2021-03-24 06:00:23','2021-05-09 16:25:29');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (10,'mauris sit amet lorem semper auctor. Mauris',11,'2020-12-03 03:18:53','2021-11-23 08:01:05');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (1,'turpis non enim. Mauris quis turpis',12,'2021-01-24 05:26:34','2022-03-31 10:51:43');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (1,'nec tempus mauris erat eget',5,'2021-05-15 22:37:37','2021-02-25 18:39:02');

-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (8,'lorem semper auctor. Mauris vel turpis.',3,'2020-12-31 23:52:10','2021-08-04 09:47:11');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (2,'ligula. Aliquam erat volutpat. Nulla dignissim.',3,'2021-08-31 13:01:57','2021-12-08 21:01:06');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (7,'tempus mauris erat eget ipsum.',2,'2020-09-10 01:09:06','2021-08-28 21:05:59');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (8,'id risus quis diam luctus lobortis.',7,'2021-06-10 07:35:44','2022-07-16 04:50:29');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (1,'scelerisque mollis. Phasellus libero mauris, aliquam',2,'2021-09-03 09:12:53','2022-08-10 04:39:25');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (10,'vehicula aliquet libero. Integer in magna.',11,'2021-09-07 23:37:23','2022-01-14 12:39:27');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (9,'tempor erat neque non quam. Pellentesque',4,'2021-11-14 14:04:26','2021-10-03 11:50:41');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (2,'egestas hendrerit neque. In ornare',5,'2021-04-06 13:14:29','2022-05-06 08:10:43');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (2,'metus. In nec orci. Donec nibh. Quisque',2,'2022-06-11 22:46:24','2021-02-10 21:39:58');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (8,'ridiculus mus. Donec dignissim magna',7,'2021-11-25 03:39:58','2020-08-24 20:46:00');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (3,'montes, nascetur ridiculus mus. Aenean eget magna.',3,'2021-09-13 17:58:09','2022-07-02 05:10:48');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (8,'id, mollis nec, cursus a,',2,'2021-07-28 23:06:08','2021-06-08 07:20:26');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (7,'Aliquam vulputate ullamcorper magna. Sed',8,'2021-06-24 18:22:54','2022-03-17 07:33:29');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (8,'luctus felis purus ac tellus. Suspendisse sed',4,'2022-07-09 07:22:52','2021-06-06 01:33:49');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (6,'nisi dictum augue malesuada malesuada.',10,'2021-11-07 12:57:09','2020-11-14 23:50:03');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (8,'orci lacus vestibulum lorem, sit amet ultricies',10,'2022-03-17 22:16:20','2020-11-24 23:08:51');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (3,'orci. Donec nibh. Quisque nonummy',12,'2020-09-14 01:04:52','2022-06-22 12:55:53');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (8,'Lorem ipsum dolor sit amet, consectetuer',12,'2021-08-28 09:43:29','2022-07-22 11:11:02');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (9,'mauris, rhoncus id, mollis nec,',10,'2021-08-31 06:47:07','2020-09-24 22:15:18');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (9,'dis parturient montes, nascetur ridiculus mus.',3,'2022-04-26 09:07:39','2020-11-27 14:20:45');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (6,'diam vel arcu. Curabitur ut odio vel',5,'2022-03-07 05:51:52','2021-10-23 18:12:06');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (10,'eu enim. Etiam imperdiet dictum magna. Ut',8,'2022-02-06 23:10:24','2021-11-16 23:22:30');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (2,'sit amet, risus. Donec nibh',6,'2021-06-07 19:02:18','2021-10-22 13:04:13');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (7,'Aliquam ultrices iaculis odio. Nam',11,'2020-08-11 04:35:36','2022-02-02 06:44:41');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (8,'natoque penatibus et magnis dis parturient',6,'2021-09-28 22:21:41','2020-11-16 18:22:59');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (2,'hendrerit consectetuer, cursus et, magna.',11,'2021-06-07 04:21:24','2022-07-30 17:52:07');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (7,'lacinia orci, consectetuer euismod est',9,'2020-09-15 21:05:25','2021-05-24 17:42:07');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (4,'orci lobortis augue scelerisque mollis. Phasellus',6,'2022-04-23 12:36:54','2022-05-01 19:11:12');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (5,'in felis. Nulla tempor augue ac ipsum.',1,'2022-01-17 17:40:21','2022-01-14 10:42:50');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (10,'mauris erat eget ipsum. Suspendisse',1,'2021-06-12 11:33:40','2022-06-22 21:32:07');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (2,'eget, volutpat ornare, facilisis eget,',1,'2021-12-01 20:49:16','2022-02-15 07:36:18');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (3,'Curabitur consequat, lectus sit amet',3,'2021-12-31 03:17:39','2020-10-02 14:35:07');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (7,'nibh. Donec est mauris, rhoncus id, mollis',12,'2022-03-17 18:05:37','2021-09-16 03:25:02');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (10,'lacinia mattis. Integer eu lacus.',5,'2021-02-24 18:41:13','2022-05-18 03:57:19');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (8,'luctus felis purus ac tellus.',6,'2022-03-17 07:30:09','2021-10-29 00:24:17');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (9,'urna, nec luctus felis purus',11,'2021-12-20 08:50:03','2021-07-24 23:10:37');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (6,'in felis. Nulla tempor augue ac',10,'2021-03-25 03:35:14','2020-09-03 14:21:45');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (8,'at pede. Cras vulputate velit eu',12,'2021-05-20 07:31:01','2021-09-11 23:37:24');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (6,'neque non quam. Pellentesque habitant morbi',10,'2020-10-24 13:16:12','2022-06-21 16:11:46');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (7,'elit, dictum eu, eleifend nec,',6,'2020-10-29 19:06:39','2021-08-31 01:18:37');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (2,'nec, malesuada ut, sem. Nulla interdum.',5,'2020-09-16 23:54:56','2022-06-30 06:43:27');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (6,'nulla. Integer urna. Vivamus molestie',6,'2022-02-07 21:43:41','2021-04-18 08:11:57');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (4,'justo eu arcu. Morbi sit amet massa.',9,'2022-08-03 14:17:30','2022-08-10 16:55:24');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (2,'sed, hendrerit a, arcu. Sed',8,'2021-01-19 05:14:03','2021-01-18 16:25:37');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (8,'lectus rutrum urna, nec luctus felis',5,'2020-12-03 17:13:22','2021-04-02 04:22:53');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (9,'Phasellus libero mauris, aliquam eu, accumsan sed,',3,'2021-01-10 02:09:03','2021-07-31 13:39:18');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (2,'sit amet luctus vulputate, nisi sem semper',9,'2022-02-18 08:41:18','2022-07-27 16:06:19');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (10,'ornare egestas ligula. Nullam feugiat placerat',1,'2021-09-02 07:16:13','2021-10-05 02:37:13');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (4,'orci tincidunt adipiscing. Mauris molestie pharetra',7,'2021-07-21 12:35:50','2021-09-02 16:03:01');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (6,'erat vel pede blandit congue. In scelerisque',10,'2022-02-18 07:56:19','2020-12-04 16:14:48');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (4,'gravida sagittis. Duis gravida. Praesent eu nulla',11,'2021-12-30 05:22:54','2022-06-29 17:47:19');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (7,'lacinia orci, consectetuer euismod est arcu',7,'2020-09-26 10:13:15','2022-07-02 09:20:16');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (3,'aliquet, sem ut cursus luctus, ipsum leo',1,'2021-05-05 18:28:58','2020-08-13 14:44:54');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (1,'tellus. Suspendisse sed dolor. Fusce',9,'2022-01-30 15:15:01','2021-08-15 06:19:13');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (8,'faucibus orci luctus et ultrices',5,'2020-12-12 18:17:41','2021-02-16 21:20:09');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (6,'dictum eu, placerat eget, venenatis a, magna.',6,'2021-06-26 15:17:10','2021-09-27 02:20:55');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (2,'commodo at, libero. Morbi accumsan laoreet ipsum.',5,'2021-05-19 03:42:24','2021-04-10 15:46:09');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (5,'in sodales elit erat vitae',8,'2022-07-04 05:01:51','2022-04-17 13:14:50');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (7,'augue malesuada malesuada. Integer id magna et',8,'2022-03-09 02:39:33','2021-06-25 20:23:05');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (3,'neque sed sem egestas blandit.',6,'2020-08-26 21:11:32','2022-07-09 21:35:35');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (4,'Sed nunc est, mollis non, cursus non,',10,'2022-01-05 03:18:24','2021-07-11 23:18:25');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (6,'eget ipsum. Suspendisse sagittis. Nullam vitae diam.',12,'2022-06-28 13:15:43','2021-05-25 06:40:31');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (9,'sagittis. Nullam vitae diam. Proin dolor.',11,'2021-09-17 02:56:38','2021-12-15 21:40:26');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (10,'dui quis accumsan convallis, ante lectus',9,'2020-08-01 08:23:49','2021-07-22 14:51:11');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (10,'est tempor bibendum. Donec felis orci, adipiscing',4,'2022-05-14 12:13:32','2022-06-07 03:06:57');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (7,'neque vitae semper egestas, urna justo faucibus',11,'2021-01-21 21:29:44','2022-05-15 17:57:35');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (8,'nisl. Quisque fringilla euismod enim. Etiam',3,'2022-08-02 22:48:16','2021-04-03 22:59:21');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (10,'vitae erat vel pede blandit congue.',1,'2021-09-06 17:01:45','2021-01-28 19:08:39');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (5,'vel sapien imperdiet ornare. In',9,'2022-01-14 14:19:56','2022-08-05 05:24:24');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (10,'Morbi metus. Vivamus euismod urna.',10,'2021-10-16 21:22:04','2022-05-26 21:32:09');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (9,'Cras eu tellus eu augue porttitor interdum.',7,'2022-04-04 08:21:41','2020-10-25 03:55:19');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (3,'mi enim, condimentum eget, volutpat ornare, facilisis',10,'2020-09-17 02:37:52','2022-04-28 23:41:46');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (7,'lorem tristique aliquet. Phasellus fermentum convallis',7,'2021-12-08 10:00:07','2022-03-18 10:27:30');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (10,'in consectetuer ipsum nunc id',6,'2020-09-08 16:42:48','2021-12-06 19:38:58');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (10,'pharetra nibh. Aliquam ornare, libero',6,'2021-10-08 12:22:02','2022-01-28 14:21:44');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (7,'at, velit. Cras lorem lorem, luctus',11,'2021-12-31 08:29:39','2021-05-14 09:14:52');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (9,'sit amet nulla. Donec non',10,'2020-11-06 12:16:59','2021-12-22 01:54:29');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (3,'odio, auctor vitae, aliquet nec,',8,'2021-12-22 16:51:45','2020-08-15 21:37:11');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (2,'sit amet ultricies sem magna nec',11,'2021-01-29 02:53:13','2021-04-05 14:58:36');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (9,'neque non quam. Pellentesque habitant morbi',10,'2022-04-30 10:12:39','2022-06-07 09:37:22');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (4,'tincidunt pede ac urna. Ut tincidunt',4,'2020-12-01 21:56:38','2022-05-10 21:25:19');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (9,'mauris sit amet lorem semper auctor.',12,'2022-04-07 06:26:55','2022-06-23 20:54:31');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (1,'hendrerit id, ante. Nunc mauris',10,'2021-04-29 17:55:52','2021-04-22 05:54:44');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (10,'sem elit, pharetra ut, pharetra sed, hendrerit',6,'2021-09-28 16:00:18','2021-11-26 23:32:14');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (9,'leo elementum sem, vitae aliquam eros',7,'2022-02-13 19:56:58','2022-07-22 09:52:54');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (5,'non, feugiat nec, diam. Duis',4,'2021-07-08 20:30:01','2021-10-04 10:41:53');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (8,'bibendum sed, est. Nunc laoreet lectus',12,'2021-10-21 12:25:30','2022-01-07 01:22:02');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (1,'iaculis aliquet diam. Sed diam',5,'2021-01-27 18:03:43','2022-08-04 00:02:31');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (7,'Nam interdum enim non nisi. Aenean',12,'2021-01-14 06:30:31','2021-03-31 22:07:53');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (5,'Etiam ligula tortor, dictum eu, placerat eget,',3,'2021-03-15 08:36:24','2020-09-16 18:50:38');
-- INSERT INTO Questions (UserId,Description,Category,TimeUntilClose,postTime) VALUES (2,'orci sem eget massa. Suspendisse',6,'2021-04-12 00:14:01','2022-06-24 20:39:29');


INSERT PayMethod(UserId, DogeAd, BitAd, EthAd) VALUES (1,'1111','2222','3333');
INSERT PayMethod(UserId, DogeAd, BitAd, EthAd) VALUES (2,'AAAA','BBBB','CCCC');
INSERT PayMethod(UserId, DogeAd, BitAd, EthAd) VALUES (3,'DDDD','EEEE','FFFF');
INSERT PayMethod(UserId, DogeAd, BitAd, EthAd) VALUES (4,'aaaa','bbbb','bbbb');
INSERT PayMethod(UserId, DogeAd, BitAd, EthAd) VALUES (5,'4444','5555','6666');
INSERT PayMethod(UserId, DogeAd, BitAd, EthAd) VALUES (6,'9999','8888','7777');
INSERT PayMethod(UserId, DogeAd, BitAd, EthAd) VALUES (7,'1010','2020','3030');
INSERT PayMethod(UserId, DogeAd, BitAd, EthAd) VALUES (8,'6060','5050','4040');
INSERT PayMethod(UserId, DogeAd, BitAd, EthAd) VALUES (9,'7070','8080','9090');
INSERT PayMethod(UserId, DogeAd, BitAd, EthAd) VALUES (10,'a1a1','b2b2','c3c3');

INSERT UStatus(StatId, Name, DogX, BitX, EthX) VALUES(1,'Fresh Meat', 35, 00.0000, 00.0000);
INSERT UStatus(StatId, Name, DogX, BitX, EthX) VALUES(2,'Bronze', 20, 00.0001, 00.0011);
INSERT UStatus(StatId, Name, DogX, BitX, EthX) VALUES(3,'Silver', 35, 00.0001, 00.0250);
INSERT UStatus(StatId, Name, DogX, BitX, EthX) VALUES(4,'Gold', 35, 00.0010, 00.0015);
INSERT UStatus(StatId, Name, DogX, BitX, EthX) VALUES(5,'Platinum', 35, 00.0010, 00.0250);


INSERT INTO CorAnswers(Qid, userId, Description, Avgscore) VALUES(1,2,'The large surface area of a mycelium makes them such effective decomposers', 4.5);
INSERT INTO CorAnswers(Qid, userId, Description, Avgscore) VALUES(2,8,'Using a gRNA protein sequence that includes the desired cut peptide sequence', 4.5);
INSERT INTO CorAnswers(Qid, userId, Description, Avgscore) VALUES(3,7,'The molecule has S/R properties that define the trigonometry of it in 3D space', 4.0);
INSERT INTO CorAnswers(Qid, userId, Description, Avgscore) VALUES(4,4,'Hans Janssen', 4.33);
INSERT INTO CorAnswers(Qid, userId, Description, Avgscore) VALUES(5,9,'Viscosity', 4.0);
INSERT INTO CorAnswers(Qid, userId, Description, Avgscore) VALUES(6,8,'Hemoglobin Myoglobin and BS albumin would all be included. Myosin and Galatin would not be included and Vitamin B12 and C would fraction out completely', 4.67);
INSERT INTO CorAnswers(Qid, userId, Description, Avgscore) VALUES(8,8,'Pablo Picaso', 3.8);
INSERT INTO CorAnswers(Qid, userId, Description, Avgscore) VALUES(9,1,'The prefix neo means new while classical refers to a return to the ideologies set in place by Greeks and Romans during the Classic period', 3.67);
INSERT INTO CorAnswers(Qid, userId, Description, Avgscore) VALUES(10,4,'Microeconomics is the study of particular markets and segments of the economy. It looks at issues such as consumer behaviour individual labour markets and the theory of firms.Macro economics is the study of the whole economy. It looks at aggregate variables such as aggregate demand national output and inflation.', 4.2);
INSERT INTO CorAnswers(Qid, userId, Description, Avgscore) VALUES(11,10,'for (int x=0:x<=size:x++) as we use int x to be a counter of a sort that increments upwards we check the condition. We exit the loop once the constraint is met. Best to set the constraint outside the loop as it will need to be initialized to continually check your constraint', 4.33);
INSERT INTO CorAnswers(Qid, userId, Description, Avgscore) VALUES(12,2,'Formalist Criticism designates an approach to understanding narratives that is rooted in close attention to how meaning is conveyed. It begins from the premise that form and content are closely related', 5.0);
INSERT INTO CorAnswers(Qid, userId, Description, Avgscore) VALUES(13,1,'IS the cyclic phosphorylation of ADP to form ATP which is then consumed as an energy source	', 3.75);
INSERT INTO CorAnswers(Qid, userId, Description, Avgscore) VALUES(14,9,'enzyme RuBisCO incorporates carbon dioxide into an organic molecule 3-PGa organic molecule is reduced using electrons supplied by NADPH RuBP molecule that starts the cycle is regenerated so that the cycle can continue', 2.75);
INSERT INTO CorAnswers(Qid, userId, Description, Avgscore) VALUES(15,10,'Dopamine Deficiency', 4.0);
INSERT INTO CorAnswers(Qid, userId, Description, Avgscore) VALUES(16,5,'Papillae', 5.0);
INSERT INTO CorAnswers(Qid, userId, Description, Avgscore) VALUES(17,3,'Due to the possible presence of a third hidden variable unknown to both parties that is causing an unseen force that either positively or negatively influences the data', 4.25);
INSERT INTO CorAnswers(Qid, userId, Description, Avgscore) VALUES(18,4,'Was both a physicist and philosopher whos work encompasses both the mind body problem and advances in fluid dynamics', 5.0);
INSERT INTO CorAnswers(Qid, userId, Description, Avgscore) VALUES(19,8,'Cerebellum and Motor Cortex	', 4.67);
INSERT INTO CorAnswers(Qid, userId, Description, Avgscore) VALUES(20,2,'Mental processes such as memory perception and thought.	', 5.0);
INSERT INTO CorAnswers(Qid, userId, Description, Avgscore) VALUES(21,1,'As the cell is in prophase it has 24', 4.0);
INSERT INTO CorAnswers(Qid, userId, Description, Avgscore) VALUES(22,6,'First wave – 19th century equal rights under law Second wave – 1960s personal is political reproductive rights Third wave – from mid 1990s – challenging fixed gender categories reclaiming of negative language (e.g. Slut-walk).', 4.5);
INSERT INTO CorAnswers(Qid, userId, Description, Avgscore) VALUES(23,10,'Lucid dreaming being aware in the dream', 3.67);
INSERT INTO CorAnswers(Qid, userId, Description, Avgscore) VALUES(24,10,'6CO2 + 6H2O → C6H12O6 + 6O2.', 5.0);
INSERT INTO CorAnswers(Qid, userId, Description, Avgscore) VALUES(25,6,'The use of paper for hygiene has been recorded in China in the 6th century AD with specifically manufactured toilet paper being mass-produced in the 14th century.Modern commercial toilet paper originated in the 19th century with a patent for roll-based dispensers being made in 1883', 4.5);
INSERT INTO CorAnswers(Qid, userId, Description, Avgscore) VALUES(26,8,'Auxins are a powerful growth hormone produced naturally by plants. They are found in shoot and root tips and promote cell division stem and root growth. They can also drastically affect plant orientation by promoting cell division to one side of the plant in response to sunlight and gravity.', 4.5);

-- Trigger
-- Update average score of an Answer each time a new rating is added with a matching AnsId

   CREATE TRIGGER updateAvgScore ON Ratings
    AFTER INSERT
    AS
    BEGIN

     with feedback_grouped AS
        ( 
        SELECT f.AnsId, AVG(CAST(f.Score as decimal(3,2))) as avg_rating
        FROM Ratings f
        GROUP BY f.AnsId
        )
     UPDATE Answers
     SET AvgRating=avg_rating
     FROM Answers c
     INNER JOIN feedback_grouped 
     ON c.AnsId = feedback_grouped.AnsId

    END;


INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 1, 3, '2011-01-15 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (8, 1, 4, '2011-01-16 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 1, 4, '2011-01-17 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (4, 1, 2, '2011-01-17 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (2, 2, 2, '2011-01-21 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 2, 1, '2011-01-22 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 3, 0, '2011-01-22 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (8, 3, 2, '2011-01-23 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (7, 3, 1, '2011-01-23 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (3, 4, 4, '2012-04-13 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 4, 5, '2012-04-14 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (7, 4, 4, '2012-04-15 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (9, 4, 5, '2012-04-15 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 5, 3, '2012-04-15 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (7, 5, 4, '2012-04-16 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 5, 3, '2012-04-19 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 5, 2, '2012-04-22 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 6, 2, '2012-04-17 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (8, 6, 3, '2012-04-17 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (9, 6, 4, '2012-04-18 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 7, 4, '2012-04-18 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 7, 5, '2012-04-19 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (9, 7, 3, '2012-04-20 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 8, 4, '2012-04-20 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (9, 8, 4, '2012-04-21 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 8, 4, '2012-04-22 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 9, 2, '2012-04-20 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (2, 9, 3, '2012-04-30 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 9, 1, '2012-05-01 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 10, 1, '2012-04-28 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 10, 0, '2012-05-02 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (9, 10, 0, '2012-05-04 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (8, 10, 0, '2012-05-10 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 11, 5, '2015-07-18 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 11, 4, '2015-07-19 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (7, 11, 4, '2015-07-19 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 12, 3, '2015-07-20 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (3, 12, 4, '2015-07-21 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 12, 2, '2015-07-23 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 12, 1, '2015-07-26 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (4, 12, 1, '2015-07-28 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 13, 0, '2015-11-26 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 13, 1, '2015-11-27 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (4, 13, 2, '2015-11-28 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 14, 0, '2015-11-26 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 14, 0, '2015-11-30 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 14, 1, '2016-01-02 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 15, 4, '2016-01-12 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 15, 3, '2016-01-13 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 15, 5, '2016-01-14 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (7, 15, 4, '2016-01-15 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 16, 5, '2015-11-22 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (7, 16, 4, '2015-11-23 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 16, 5, '2015-11-28 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 17, 2, '2016-01-06 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 17, 3, '2016-01-09 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (8, 17, 4, '2016-01-10 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 17, 1, '2016-01-21 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (3, 18, 2, '2016-01-15 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 18, 1, '2016-01-16 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (7, 18, 3, '2016-01-16 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 19, 4, '2016-01-19 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 19, 5, '2016-01-20 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (3, 19, 1, '2016-01-20 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 19, 5, '2016-02-01 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (7, 19, 4, '2016-02-03 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (3, 20, 0, '2016-02-08 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 20, 1, '2016-02-08 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (7, 20, 2, '2016-02-09 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 20, 1, '2016-02-09 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 21, 3, '2016-01-16 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 21, 1, '2016-01-19 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 22, 5, '2016-01-25 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 22, 4, '2016-01-26 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (4, 22, 2, '2016-01-27 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 23, 2, '2016-01-24 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (4, 23, 1, '2016-01-28 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 23, 3, '2016-01-29 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (2, 23, 2, '2016-01-30 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 24, 3, '2016-02-01 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 24, 2, '2016-02-03 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 24, 3, '2016-02-05 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 24, 2, '2016-02-10 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (4, 24, 4, '2016-02-11 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 25, 5, '2016-02-07 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 25, 5, '2016-02-08 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 25, 4, '2016-02-08 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 25, 5, '2016-02-15 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (9, 25, 2, '2016-02-18 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 26, 4, '2016-02-24 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (4, 26, 4, '2016-02-25 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (3, 26, 3, '2016-02-28 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 27, 5, '2016-02-21 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (7, 27, 5, '2016-02-22 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 27, 3, '2016-02-23 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 28, 5, '2017-01-28 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 29, 2, '2017-02-11 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 29, 3, '2017-02-12 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (2, 29, 5, '2017-02-12 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 30, 4, '2017-02-13 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 30, 3, '2017-02-14 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 30, 4, '2017-02-15 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (8, 30, 4, '2017-02-16 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 31, 0, '2017-02-27 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (4, 31, 1, '2017-02-27 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 32, 3, '2017-02-27 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (9, 32, 3, '2017-02-28 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 32, 2, '2017-02-28 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 32, 3, '2017-03-01 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 33, 3, '2017-02-08 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (7, 33, 2, '2017-02-09 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 33, 3, '2017-02-10 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 34, 1, '2017-02-20 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 34, 1, '2017-02-20 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 35, 5, '2017-02-23 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 35, 4, '2017-02-24 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (8, 35, 3, '2017-02-28 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (9, 35, 4, '2017-02-28 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 37, 5, '2017-03-05 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 37, 5, '2017-03-15 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (8, 37, 5, '2017-03-16 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 38, 4, '2017-02-20 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 38, 4, '2017-02-21 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (9, 38,  4, '2017-02-21 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 38,  5, '2017-02-24 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (4, 39, 1, '2017-02-21 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (2, 39,  2, '2017-02-21 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 39, 0, '2017-02-25 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 40, 0, '2017-03-05 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 40, 1, '2017-03-06 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 40,  3, '2017-03-09 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (7, 41, 2, '2017-03-09 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 41, 2, '2017-03-10 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 42, 3, '2017-03-15 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 42,  5, '2017-03-19 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 42, 4, '2017-03-22 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (8, 43, 5, '2017-03-18 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 43,  5, '2017-03-22 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 44,  2, '2017-04-22 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (8, 44, 3, '2017-04-21 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 45,  5, '2017-04-22 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 45, 5, '2017-04-23 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 45, 4, '2017-04-23 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 47, 3, '2018-04-20 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (4, 47, 3, '2018-04-21 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 47, 2, '2018-04-22 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 48, 5, '2018-05-04 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 48, 1, '2018-05-10 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 49, 4, '2018-05-25 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 49, 4, '2018-05-29 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 50, 2, '2018-05-28 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 50, 1, '2018-05-29 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 51, 4, '2018-06-11 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (4, 51, 5, '2018-06-13 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (2, 51, 3, '2018-06-15 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 52, 0, '2018-06-12 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 52, 1, '2018-06-16 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 52, 1, '2018-06-22 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (8, 53, 3, '2019-06-15 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (7, 53, 1, '2019-06-16 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 54, 2, '2019-06-24 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (4, 55, 4, '2019-06-29 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 55, 5, '2019-07-04 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 56, 3, '2020-07-15 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 56, 4, '2020-07-16 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 56, 4, '2020-07-17 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 57, 2, '2020-07-11 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 58, 2, '2020-07-15 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (9, 58, 3, '2020-07-16 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (9, 59, 5, '2020-07-15 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 60, 5, '2020-07-22 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 60, 5, '2020-07-23 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 61, 4, '2020-08-10 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (2, 61, 5, '2020-08-11 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 62, 2, '2020-07-24 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 63, 5, '2020-07-25 12:12:12.123');
INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 63, 4, '2020-07-28 12:12:12.123');



-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 1, 1, 3, '2011-01-15 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (8, 1, 2, 4, '2011-01-16 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 1, 3, 4, '2011-01-17 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (4, 1, 4, 2, '2011-01-17 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (2, 2, 5, 2, '2011-01-21 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 2, 6, 1, '2011-01-22 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 3, 7, 0, '2011-01-22 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (8, 3, 8, 2, '2011-01-23 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (7, 3, 9, 1, '2011-01-23 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (3, 4, 10, 4, '2012-04-13 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 4, 11, 5, '2012-04-14 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (7, 4, 12, 4, '2012-04-15 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (9, 4, 13, 5, '2012-04-15 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 5, 14, 3, '2012-04-15 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (7, 5, 15, 4, '2012-04-16 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 5, 16, 3, '2012-04-19 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 5, 17, 2, '2012-04-22 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 6, 18, 2, '2012-04-17 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (8, 6, 19, 3, '2012-04-17 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (9, 6, 20, 4, '2012-04-18 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 7, 21, 4, '2012-04-18 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 7, 22, 5, '2012-04-19 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (9, 7, 23, 3, '2012-04-20 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 8, 24, 4, '2012-04-20 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (9, 8, 25, 4, '2012-04-21 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 8, 26, 4, '2012-04-22 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 9, 27, 2, '2012-04-20 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (2, 9, 28, 3, '2012-04-30 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 9, 29, 1, '2012-05-01 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 10, 30, 1, '2012-04-28 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 10, 31, 0, '2012-05-02 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (9, 10, 32, 0, '2012-05-04 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (8, 10, 33, 0, '2012-05-10 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 11, 34, 5, '2015-07-18 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 11, 35, 4, '2015-07-19 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (7, 11, 36, 4, '2015-07-19 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 12, 37, 3, '2015-07-20 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (3, 12, 38, 4, '2015-07-21 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 12, 39, 2, '2015-07-23 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 12, 40, 1, '2015-07-26 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (4, 12, 41, 1, '2015-07-28 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 13, 42, 0, '2015-11-26 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 13, 43, 1, '2015-11-27 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (4, 13, 44, 2, '2015-11-28 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 14, 45, 0, '2015-11-26 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 14, 46, 0, '2015-11-30 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 14, 47, 1, '2016-01-02 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 15, 48, 4, '2016-01-12 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 15, 49, 3, '2016-01-13 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 15, 50, 5, '2016-01-14 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (7, 15, 51, 4, '2016-01-15 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 16, 52, 5, '2015-11-22 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (7, 16, 53, 4, '2015-11-23 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 16, 54, 5, '2015-11-28 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 17, 55, 2, '2016-01-06 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 17, 56, 3, '2016-01-09 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (8, 17, 57, 4, '2016-01-10 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 17, 58, 1, '2016-01-21 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (3, 18, 59, 2, '2016-01-15 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 18, 60, 1, '2016-01-16 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (7, 18, 61, 3, '2016-01-16 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 19, 62, 4, '2016-01-19 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 19, 63, 5, '2016-01-20 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (3, 19, 64, 1, '2016-01-20 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 19, 65, 5, '2016-02-01 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (7, 19, 66, 4, '2016-02-03 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (3, 20, 67, 0, '2016-02-08 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 20, 68, 1, '2016-02-08 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (7, 20, 69, 2, '2016-02-09 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 20, 70, 1, '2016-02-09 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 21, 71, 3, '2016-01-16 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 21, 72, 1, '2016-01-19 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 22, 73, 5, '2016-01-25 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 22, 74, 4, '2016-01-26 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (4, 22, 75, 2, '2016-01-27 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 23, 76, 2, '2016-01-24 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (4, 23, 77, 1, '2016-01-28 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 23, 78, 3, '2016-01-29 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (2, 23, 79, 2, '2016-01-30 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 24, 80, 3, '2016-02-01 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 24, 81, 2, '2016-02-03 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 24, 82, 3, '2016-02-05 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 24, 83, 2, '2016-02-10 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (4, 24, 84, 4, '2016-02-11 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 25, 85, 5, '2016-02-07 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 25, 86, 5, '2016-02-08 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 25, 87, 4, '2016-02-08 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 25, 88, 5, '2016-02-15 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (9, 25, 89, 2, '2016-02-18 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 26, 90, 4, '2016-02-24 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (4, 26, 91, 4, '2016-02-25 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (3, 26, 92, 3, '2016-02-28 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 27, 93, 5, '2016-02-21 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (7, 27, 94, 5, '2016-02-22 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 27, 95, 3, '2016-02-23 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 28, 96, 5, '2017-01-28 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 29, 97, 2, '2017-02-11 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 29, 98, 3, '2017-02-12 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (2, 29, 99, 5, '2017-02-12 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 30, 100, 4, '2017-02-13 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 30, 101, 3, '2017-02-14 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 30, 102, 4, '2017-02-15 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (8, 30, 103, 4, '2017-02-16 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 31, 104, 0, '2017-02-27 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (4, 31, 105, 1, '2017-02-27 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 32, 106, 3, '2017-02-27 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (9, 32, 107, 3, '2017-02-28 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 32, 108, 2, '2017-02-28 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 32, 109, 3, '2017-03-01 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 33, 110, 3, '2017-02-08 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (7, 33, 111, 2, '2017-02-09 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 33, 112, 3, '2017-02-10 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 34, 113, 1, '2017-02-20 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 34, 114, 1, '2017-02-20 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 35, 115, 5, '2017-02-23 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 35, 116, 4, '2017-02-24 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (8, 35, 117, 3, '2017-02-28 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (9, 35, 118, 4, '2017-02-28 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 37, 119, 5, '2017-03-05 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 37, 120, 5, '2017-03-15 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (8, 37, 121, 5, '2017-03-16 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 38, 122, 4, '2017-02-20 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 38, 123, 4, '2017-02-21 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (9, 38, 124, 4, '2017-02-21 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 38, 125, 5, '2017-02-24 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (4, 39, 126, 1, '2017-02-21 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (2, 39, 127, 2, '2017-02-21 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 39, 128, 0, '2017-02-25 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 40, 129, 0, '2017-03-05 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 40, 130, 1, '2017-03-06 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 40, 131, 3, '2017-03-09 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (7, 41, 132, 2, '2017-03-09 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 41, 133, 2, '2017-03-10 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 42, 134, 3, '2017-03-15 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 42, 135, 5, '2017-03-19 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 42, 136, 4, '2017-03-22 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (8, 43, 137, 5, '2017-03-18 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 43, 138, 5, '2017-03-22 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 44, 139, 2, '2017-04-22 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (8, 44, 140, 3, '2017-04-21 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 45, 141, 5, '2017-04-22 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 45, 142, 5, '2017-04-23 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 45, 143, 4, '2017-04-23 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 47, 144, 3, '2018-04-20 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (4, 47, 145, 3, '2018-04-21 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 47, 146, 2, '2018-04-22 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 48, 147, 5, '2018-05-04 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 48, 148, 1, '2018-05-10 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 49, 149, 4, '2018-05-25 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 49, 150, 4, '2018-05-29 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 50, 151, 2, '2018-05-28 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 50, 152, 1, '2018-05-29 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 51, 153, 4, '2018-06-11 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (4, 51, 154, 5, '2018-06-13 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (2, 51, 155, 3, '2018-06-15 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 52, 156, 0, '2018-06-12 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 52, 157, 1, '2018-06-16 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 52, 158, 1, '2018-06-22 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (8, 53, 159, 3, '2019-06-15 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (7, 53, 160, 1, '2019-06-16 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 54, 161, 2, '2019-06-24 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (4, 55, 162, 4, '2019-06-29 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 55, 163, 5, '2019-07-04 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 56, 164, 3, '2020-07-15 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 56, 165, 4, '2020-07-16 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 56, 166, 4, '2020-07-17 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (6, 57, 167, 2, '2020-07-11 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 58, 168, 2, '2020-07-15 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (9, 58, 169, 3, '2020-07-16 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (9, 59, 170, 5, '2020-07-15 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (1, 60, 171, 5, '2020-07-22 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 60, 172, 5, '2020-07-23 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 61, 173, 4, '2020-08-10 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (2, 61, 174, 5, '2020-08-11 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 62, 175, 2, '2020-07-24 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (10, 63, 176, 5, '2020-07-25 12:12:12.123');
-- INSERT INTO Ratings(UserId, AnsId, Score, PTime) VALUES (5, 63, 177, 4, '2020-07-28 12:12:12.123');
