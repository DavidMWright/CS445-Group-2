CREATE TABLE Users
(
    UserID INT NOT NULL AUTO_INCREMENT,
    
    FName VARCHAR(50),
    LNAME VARCHAR(50),
    
    Username VARBINARY(50) NOT NULL,
    Passwd VARBINARY(50) NOT NULL,
    Salt VARBINARY(50) NOT NULL,


    CONSTRAINT User_UserID_PK PRIMARY KEY (UserID),
    CONSTRAINT Users_Username_U UNIQUE (Username)
) Engine=InnoDB CHARACTER SET=utf8 COLLATE=utf8_bin;


CREATE TABLE Bettors
(
    BettorID INT NOT NULL AUTO_INCREMENT,
    
    Balance INT DEFAULT 0,

    CONSTRAINT Bettors_BettorID_PK PRIMARY KEY (BettorID)
) Engine=InnoDB;


CREATE TABLE Admins
(
    AdminID INT NOT NULL AUTO_INCREMENT,

    CONSTRAINT Admins_AdminID_PK PRIMARY KEY (AdminID)
) Engine=InnoDB;


CREATE TABLE Bet
(
    BetID INT NOT NULL,

    CurrentOdds INT,

    CONSTRAINT Bet_BetID_PK PRIMARY KEY (BetID)
) Engine=InnoDB;


CREATE TABLE MadeBet
(
    BetID INT NOT NULL,
    BettorID INT NOT NULL,
    HomeID INT NOT NULL,
    AwayID INT NOT NULL,

    Outcome BOOL,
    Odds INT,
    Amount INT,

    CONSTRAINT MadeBet_PK PRIMARY KEY (BetID, BettorID, HomeID, AwayID),
    CONSTRAINT MadeBet_BetID_FK FOREIGN KEY (BetID) REFERENCES Bet(BetID),
    CONSTRAINT MadeBet_BettorID_FK FOREIGN KEY (BettorID) REFERENCES Bettor(BettorID),   
    CONSTRAINT MadeBet_HomeID_FK FOREIGN KEY (HomeID) REFERENCES SportsTeams(SportsTeamID),
    CONSTRAINT MadeBet_AwayID_FK FOREIGN KEY (AwayID) REFERENCES SportsTeams(SportsTeamID)
) Engine=InnoDB;


CREATE TABLE Win
(
    BetID INT NOT NULL,
    TeamID INT NOT NULL,

    CONSTRAINT Win_PK PRIMARY KEY (BetID),

    CONSTRAINT Win_BetID_FK FOREIGN KEY (BetID) REFERENCES Bet(BetID),
    CONSTRAINT Win_TeamID_FK FOREIGN Key (TeamID) REFERENCES SportsTeams(SportsTeamID)
) Engine=InnoDB;


CREATE TABLE Goals
(
    BetID INT NOT NULL,
    PlayerID INT NOT NULL,

    CONSTRAINT Goals_PK PRIMARY KEY (BetID),

    CONSTRAINT Goals_BetID_FK FOREIGN KEY (BetID) REFERENCES Bet(BetID),
    CONSTRAINT Goals_PlayerID_FK FOREIGN Key (PlayerID) REFERENCES Players(PlayerID)
) Engine=InnoDB;


CREATE TABLE Assists
(
    BetID INT NOT NULL,
    PlayerID INT NOT NULL,

    CONSTRAINT Assists_PK PRIMARY KEY (BetID),

    CONSTRAINT Assists_BetID_FK FOREIGN KEY (BetID) REFERENCES Bet(BetID),
    CONSTRAINT Assists_PlayerID_FK FOREIGN Key (PlayerID) REFERENCES Players(PlayerID)
) Engine=InnoDB;


CREATE TABLE Shots
(
    BetID INT NOT NULL,
    PlayerID INT NOT NULL,

    CONSTRAINT Shots_PK PRIMARY KEY (BetID),

    CONSTRAINT Shots_BetID_FK FOREIGN KEY (BetID) REFERENCES Bet(BetID),
    CONSTRAINT Shots_PlayerID_FK FOREIGN Key (PlayerID) REFERENCES Players(PlayerID)
) Engine=InnoDB;


CREATE TABLE Cards
(
    BetID INT NOT NULL,
    Num INT NOT NULL,

    CONSTRAINT Cards_PK PRIMARY KEY (BetID),

    CONSTRAINT Cards_BetID_FK FOREIGN KEY (BetID) REFERENCES Bet(BetID),
) Engine=InnoDB;


CREATE TABLE Starting
(
    BetID INT NOT NULL,
    TeamID INT NOT NULL,
    P1ID INT NOT NULL,
    P2ID INT NOT NULL,
    P3ID INT NOT NULL,
    P4ID INT NOT NULL,
    P5ID INT NOT NULL,
    P6ID INT NOT NULL,
    P7ID INT NOT NULL,
    P8ID INT NOT NULL,
    P9ID INT NOT NULL,
    P10ID INT NOT NULL,
    P11ID INT NOT NULL,
    
    CONSTRAINT Starting_PK PRIMARY KEY (BetID),

    CONSTRAINT Starting_BetID_FK FOREIGN KEY (BetID) REFERENCES Bet(BetID),
    CONSTRAINT Starting_TeamID_FK FOREIGN Key (TeamID) REFERENCES SportsTeams(SportsTeamID),
    CONSTRAINT Starting_P1ID_FK FOREIGN Key (PlayerID) REFERENCES Players(PlayerID),
    CONSTRAINT Starting_P2ID_FK FOREIGN Key (PlayerID) REFERENCES Players(PlayerID),
    CONSTRAINT Starting_P3ID_FK FOREIGN Key (PlayerID) REFERENCES Players(PlayerID),
    CONSTRAINT Starting_P4ID_FK FOREIGN Key (PlayerID) REFERENCES Players(PlayerID),
    CONSTRAINT Starting_P5ID_FK FOREIGN Key (PlayerID) REFERENCES Players(PlayerID),
    CONSTRAINT Starting_P6ID_FK FOREIGN Key (PlayerID) REFERENCES Players(PlayerID),
    CONSTRAINT Starting_P7ID_FK FOREIGN Key (PlayerID) REFERENCES Players(PlayerID),
    CONSTRAINT Starting_P8ID_FK FOREIGN Key (PlayerID) REFERENCES Players(PlayerID),
    CONSTRAINT Starting_P9ID_FK FOREIGN Key (PlayerID) REFERENCES Players(PlayerID),
    CONSTRAINT Starting_P10ID_FK FOREIGN Key (PlayerID) REFERENCES Players(PlayerID),
    CONSTRAINT Starting_P1I1D_FK FOREIGN Key (PlayerID) REFERENCES Players(PlayerID)
) Engine=InnoDB;