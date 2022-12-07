DROP DATABASE IF EXISTS `project_manager`;
CREATE DATABASE `project_manager`;
USE project_manager;
CREATE TABLE BUILDING(
	ID		    INT AUTO_INCREMENT NOT NULL,
	BName	    VARCHAR(60),
	BNo		    VARCHAR(5),
	StName	    VARCHAR(100),
	City	    VARCHAR(30),
	ProvStTr	VARCHAR(30),
	Country	    VARCHAR(30),
    PRIMARY KEY(ID)
);
CREATE TABLE ORGANIZATION(
	ID			CHAR(10)		NOT NULL,
	OrgName		VARCHAR(30)		NOT NULL,
	`Description`	VARCHAR(500),
	HRM_BID		INT,
    PRIMARY KEY(ID),
    FOREIGN KEY(HRM_BID) REFERENCES BUILDING(ID) ON DELETE SET NULL
    ON UPDATE CASCADE
);
CREATE TABLE MEMBER(
    Fname		VARCHAR(15)		NOT NULL,
    Lname		VARCHAR(15)		NOT NULL,
	Gender		VARCHAR(10),
    Email		VARCHAR(320)	NOT NULL,
    OrgID		CHAR(10),
    `Password`	CHAR(127)		NOT NULL,
    PRIMARY KEY(Email),
    FOREIGN KEY(OrgID) REFERENCES ORGANIZATION(ID)
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE ADMIN(
	Email		   VARCHAR(320)		NOT NULL,
	PRIMARY KEY(Email),
	FOREIGN KEY(Email) REFERENCES MEMBER(Email)
	ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE PROJECT(
	ID		    INT AUTO_INCREMENT NOT NULL,
	PName		VARCHAR(30)		NOT NULL,
	StartDate	DATE,
	EndDate	    DATE,			
	OrgID		CHAR(10)		NOT NULL,
    PRIMARY KEY(ID),
    FOREIGN KEY(OrgID) REFERENCES ORGANIZATION(ID) 
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE TEAM(
	ID		    INT AUTO_INCREMENT    NOT NULL,
	TName		VARCHAR(30)	    NOT NULL,
	Specialization	VARCHAR(30)	NOT NULL 	DEFAULT "None",
	LeadEmail		VARCHAR(320)        NOT NULL,
	OrgID		CHAR(10)	    NOT NULL,
	ProjectID	INT,	    
	PRIMARY KEY(ID),
    FOREIGN KEY(LeadEmail) REFERENCES ADMIN(Email)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(OrgID) REFERENCES ORGANIZATION(ID)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(ProjectID) REFERENCES PROJECT(ID)
    ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE TABLE BELONGS(
	MEmail	VARCHAR(320) 	NOT NULL,
	Team_ID		INT	NOT NULL,
	PRIMARY KEY(MEmail, Team_ID),
	FOREIGN KEY(MEmail) REFERENCES MEMBER(Email)
    ON DELETE 	CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(Team_ID) REFERENCES TEAM(ID)
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE EVENT_(
	EventID		        INT AUTO_INCREMENT	NOT NULL,
	EventName			CHAR(30)    NOT NULL,
	No_Attendees		INTEGER		    NOT NULL DEFAULT 0,
	Description			TINYTEXT,
	StartDateTime		DATETIME	NOT NULL,
    EndDateTime 		DATETIME	NOT NULL,
	HostID			    CHAR(10) NOT NULL,
	PlannerID		    INT	NOT NULL,
	PRIMARY KEY(EventID),
	FOREIGN KEY(HostID) REFERENCES ORGANIZATION(ID)
	ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(PlannerID) REFERENCES TEAM(ID)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE EVENT_USES(
	BuildingID	INT	NOT NULL,
	EventID 	INT	NOT NULL,
    PRIMARY KEY(BuildingID, EventID),
    FOREIGN KEY(EventID) REFERENCES EVENT_(EventID) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(BuildingID) REFERENCES BUILDING(ID)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE INVITATION(
    MEmail       VARCHAR(320) NOT NULL,
    EventID         INT NOT NULL,
    FOREIGN KEY(MEmail) REFERENCES MEMBER(Email)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(EventID) REFERENCES EVENT_(EventID)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE DELIVERABLE(
	DName		VARCHAR(30)	NOT NULL,
	ProjectID	INT	NOT NULL,
	TeamID	   	INT,	
	StartDate	DATE   NOT NULL,
	EndDate	    DATE   NOT NULL,
	PRIMARY KEY(DName, ProjectID),
	FOREIGN KEY(ProjectID) REFERENCES PROJECT(ID) 
	ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(TeamID) REFERENCES TEAM(ID)
    ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE PREREQUISITE(
	DepDname 	VARCHAR(30) 	NOT NULL,
	DepDPID		INT		NOT NULL,
	SrcDname	VARCHAR(30) 	NOT NULL,
	SrcDPID		INT		NOT NULL,
	PRIMARY KEY(DepDname, DepDPID, SrcDname, SrcDPID),
	FOREIGN KEY(DepDname, DepDPID) REFERENCES DELIVERABLE(DName, ProjectID)	
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(SrcDname, SrcDPID) REFERENCES DELIVERABLE(DName, ProjectID)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE COMPONENT(
	PartID		INT AUTO_INCREMENT	NOT NULL,
	CName		VARCHAR(30) NOT NULL,		
	CType		VARCHAR(30),
	Qty			INTEGER			NOT NULL DEFAULT 1,
	OrgID		CHAR(10)		NOT NULL,	
	PRIMARY KEY(PartID),
	FOREIGN KEY(OrgID) REFERENCES ORGANIZATION(ID)
	ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE REQUIRES (
    PartID INT NOT NULL,
    Qty INT NOT NULL,
    Dname VARCHAR(30) NOT NULL,
    DprojectID INT NOT NULL,
    PRIMARY KEY (PartID , Dname , DprojectID),
    FOREIGN KEY (Dname , DprojectID) REFERENCES DELIVERABLE (Dname , projectID),
    FOREIGN KEY (PartID) REFERENCES COMPONENT(PartID)
    ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO BUILDING (BName, BNo, StName, City, ProvStTr, Country) VALUES
("Building 1","1","10th Avenue","Calgary","Alberta","Canada"),
("Building 2","2","16 Street","Vancouver","British Columbia","Canada"),
("Building 3","3","Maple Street","Ottawa","Ontario","Canada"),
("Building 4","4","16th Avenue","Calgary","Alberta","Canada"),
("Building 5","5","Hadron Blvd","Edmonton","Alberta","Canada"),
("Building 6","6","Example St","Windsor","Ontario","Canada"),
("Building 7","7","Placeholder St","Toronto","Ontario","Canada"),
("Building 8","8","Generic Street","Generic City","Province","Country"),
("Building 9","9","Study Street","Generic City","Province","Country");

INSERT INTO ORGANIZATION VALUES
("ORG0000001","Organization1","Lorem ipsum dolor sit amet, consectetur adipiscing elit",6),
("ORG0000002","Organization2","Tomato Sauce, Jar",3),
("ORG0000003","Organization3","There are two kinds of people in the world: those who complete their sentences and-",9);

INSERT INTO MEMBER VALUES
("Samantha","Hutchins","Female","samantha.hutchins@gmail.com","ORG0000001","Password"),
("Terry","Crews","Male","terry.crews@gmail.com","ORG0000001","Password"),
("Florence","Nightingale","Female","florence.nightingale@gmail.com","ORG0000001","Password"),
("Maria","Sabella","Female","maria.sabella@gmail.com","ORG0000001","Password"),
("Samus","Aran","Female","samus.aran@gmail.com","ORG0000001","Password"),
("Lucy","Jackson","Female","lucy.jackson@gmail.com","ORG0000001","Password"),

("Rose","Potter","Female","rose.potter@gmail.com","ORG0000001","Password"),
("Roy","Strickland","Male","roy.strickland@gmail.com","ORG0000001","Password"),
("Malachi","Clay","Male","malachi.clay@gmail.com","ORG0000001","Password"),
("Nana","Maxwell","Female","nana.maxwell@gmail.com","ORG0000001","Password"),
("Laurence","Banks","Male","laurence.banks@gmail.com","ORG0000001","Password"),
("Henry","Jones","Male","henry.jones@gmail.com","ORG0000001","Password"),

("Glenn","Brooks","Male","glenn.brooks@gmail.com","ORG0000001","Password"),
("Ivy","Thomas","Female","ivy.thomas@gmail.com","ORG0000001","Password"),
("Olivia","Matthews","Female","olivia.mathews@gmail.com","ORG0000001","Password"),
("David","Lambert","Male","david.lambert@gmail.com","ORG0000001","Password"),
("Matteo","Bianchi","Male","matteo.bianchi@gmail.com","ORG0000001","Password"),
("Jim", "Thompson", "Male", "jim.thompson@gmail.com","ORG0000001","Password"),

("Liliana","Brown","Female","liliana.brown@gmail.com","ORG0000002","Password"),
("Kevin", "leary", "Male", "kevin.leary@gmail.com", "ORG0000002","Password"),
("John","Doe","Male","john.doe@gmail.com","ORG0000002","Password"),
("Megan","Holmes","Female","megan.holmes@gmail.com","ORG0000002","Password"),
("Eleni","Nikolaou","Female","eleni.nikolaou@gmail.com","ORG0000002","Password"),
("Virginia","Habig","Female","virginia.habig@gmail.com","ORG0000002","Password"),

("Lee","Padgett","Male","lee.padgett@gmail.com","ORG0000002","Password"),
("Jean-Pierre","Desbois","Male","jpdesbois@gmail.com","ORG0000002","Password"),
("Eloise","English","Female","eloise.english@gmail.com","ORG0000002","Password"),
("Rahul","Vance","Male","rahul.vance@gmail.com","ORG0000002","Password"),
("Aisha","Suarez","Female","aisha.suarez@gmail.com","ORG0000002","Password"),
("Abdul","Ali","Male","abdul.ali@gmail.com","ORG0000002","Password"),

("Dwight","Medina","Male","dwight.medina@gmail.com","ORG0000002","Password"),
("Jo","Mirae","Female","jo.mirae@gmail.com","ORG0000002","Password"),
("Japser","Griffin","Female","japser.griffin@gmail.com","ORG0000002","Password"),
("Sapphire","Walker","Female","sapphire.walker@gmail.com","ORG0000002","Password"),
("Terrence","Hayes","Male","terry.hayes@gmail.com","ORG0000002","Password"),
("Constance","Schultz","Male","constance.schultz@gmail.com","ORG0000002","Password"),

("Catherine","Myres","Female","catherine.myres@gmail.com","ORG0000003","Password"),
("Brooke", "Shultz","Female", "brooke.shultz@gmail.com","ORG0000003","Password"),
("Sarah","Jackson","Female","sarah.jackson@gmail.com","ORG0000003","Password"),
("Evelyn","Prescott","Female","evelyn.prescott@gmail.com","ORG0000003","Password"),
("June","Walker","Female","june.walker@gmail.com","ORG0000003","Password"),
("Samuel","Jackson","Male","samuel.jackson@gmail.com","ORG0000003","Password"),

("Tobias","Eaton","Male","tobias.eaton@gmail.com","ORG0000003","Password"),
("Beatrice","Prior","Female","beatrice.prior@gmail.com","ORG0000003","Password"),
("Damon","Ayala","Male","damon.ayala@gmail.com","ORG0000003","Password"),
("Kieran","Washington","Male","kieran.washington@gmail.com","ORG0000003","Password"),
("Jaya","Joyce","Female","jaya.joyce@gmail.com","ORG0000003","Password"),
("Nicole","Robinson","Female","nicole.robinson@gmail.com","ORG0000003","Password"),

("Daniel","Bianchi","Male","danny.bianchi@gmail.com","ORG0000003","Password"),
("Yang","Zhu","Male","yang.zhu@gmail.com","ORG0000003","Password"),
("Jose","Leones","Male","jose.leones@gmail.com","ORG0000003","Password"),
("Jules","Vernne","Male","jules.vernne@gmail.com","ORG0000003","Password"),
("Pearson","Reyes","Male","pearson.reyes@gmail.com","ORG0000003","Password"),
("Robert","Drysdale","Male","robert.drysadle@gmail.com","ORG0000003","Password");

INSERT INTO `ADMIN` VALUES
("samantha.hutchins@gmail.com"),
("rose.potter@gmail.com"),
("glenn.brooks@gmail.com"),
("liliana.brown@gmail.com"),
("lee.padgett@gmail.com"),
("dwight.medina@gmail.com"),
("catherine.myres@gmail.com"),
("tobias.eaton@gmail.com"),
("danny.bianchi@gmail.com");

INSERT INTO PROJECT(PName, StartDate, EndDate, OrgID) VALUES
("PROJECT 1","2022-08-15","2023-08-15","ORG0000001"),
("PROJECT 2","2022-09-04","2023-09-04","ORG0000002"),
("PROJECT 3","2022-07-01","2023-07-01","ORG0000003");
	    
INSERT INTO TEAM(TName, Specialization, LeadEmail, OrgID, ProjectID) VALUES
("Team 1","Specialization1","samantha.hutchins@gmail.com","ORG0000001","1"),
("Team 2","Specialization2","rose.potter@gmail.com","ORG0000001","1"),
("Events","Events","glenn.brooks@gmail.com","ORG0000001",NULL),
("Team 1","Specialization1","liliana.brown@gmail.com","ORG0000002","2"),
("Team 2","Specialization2","lee.padgett@gmail.com","ORG0000002","2"),
("Events","Events","dwight.medina@gmail.com","ORG0000002",NULL),
("Team 1","Specialization1","catherine.myres@gmail.com","ORG0000003","3"),
("Team 2","Specialization2","tobias.eaton@gmail.com","ORG0000003","3"),
("Events","Events","danny.bianchi@gmail.com","ORG0000003",NULL);

insert into `EVENT_`(EventName, No_Attendees, `Description`, StartDateTime, EndDateTime, HostID, PlannerID) values
("Event3",80,"Teams will showcase their projects that they have been working on to all attendees","2023-04-22  8:00:00","2023-04-22  22:00:00","ORG0000002","6"),
("Event6",90,"Trivia Night: Attendees can choose to join a group or just be a part of the audience. There will be special prizes for the top 2 winners.","2022-12-04  11:45:00","2023-12-04  13:15:00","ORG0000002","6"),
("Event9",500,"Networking experience with companies like Infosys, RBC Innovation Hub, Avidbots Corp., Amazon Web Services for students looking for internships for the year 2023-2024.","2023-02-02  16:15:00","2023-02-03  16:15:00","ORG0000002","6"),
("Event1",450,"Networking experience with companies like Symend, Suncor, Mphasis, Clearpath Robotics for students looking for internships for the year 2023-2023.","2023-03-14  14:45:00","2023-03-15  14:45:00","ORG0000001","3"),
("Event4",300,"Networking experience with companies like TC Energy, Attabotics, Microsoft, Google for students looking for internships for the year 2023-2024.","2023-04-23  17:30:00","2023-04-24  17:30:00","ORG0000001","3"),
("Event7",70,"Teams will showcase their projects that they have been working on to all attendees","2023-04-19  15:30:00","2023-04-19  16:30:00","ORG0000001","3"),
("Event10",45,"Trivia Night: Attendees can choose to join a group or just be a part of the audience. There will be special prizes for the top 2 winners.","2023-03-15  12:00:00","2023-03-15  13:00:00","ORG0000001","3"),
("Event2",40,"Clubs Week: Interested applicants can come to this event to get to know about the club and what it has to offer.","2023-05-21  20:00:00","2023-07-21  21:00:00","ORG0000003","9"),
("Event5",65,"Clubs Week: Interested applicants can come to this event to get to know about the club and what it has to offer.","2022-11-30  20:00:00","2022-11-30  22:00:00","ORG0000003","9"),
("Event8",55,"Bake Sale: Members of the clubs will bring self-baked goods for this fundraiser event.","2023-01-11  12:30:00","2023-01-11  13:30:00","ORG0000003","9");
insert into EVENT_USES values
("21", "3"),
("3", "6"),
("2", "9"),
("5", "1"),
("5", "4"),
("13", "7"),
("21", "10"),
("14", "2"),
("2", "5"),
("9", "8");
INSERT INTO BELONGS VALUES
("samantha.hutchins@gmail.com","1"),
("terry.crews@gmail.com","1"),
("florence.nightingale@gmail.com","1"),
("maria.sabella@gmail.com","1"),
("samus.aran@gmail.com","1"),
("lucy.jackson@gmail.com","1"),

("rose.potter@gmail.com","2"),
("roy.strickland@gmail.com","2"),
("malachi.clay@gmail.com","2"),
("nana.maxwell@gmail.com","2"),
("laurence.banks@gmail.com","2"),
("henry.jones@gmail.com","2"),

("glenn.brooks@gmail.com","3"),
("ivy.thomas@gmail.com","3"),
("olivia.mathews@gmail.com","3"),
("david.lambert@gmail.com","3"),
("matteo.bianchi@gmail.com","3"),
("jim.thompson@gmail.com","3"),

("liliana.brown@gmail.com","4"),
("kevin.leary@gmail.com","4"),
("john.doe@gmail.com","4"),
("megan.holmes@gmail.com","4"),
("eleni.nikolaou@gmail.com","4"),
("virginia.habig@gmail.com","4"),

("lee.padgett@gmail.com","5"),
("jpdesbois@gmail.com","5"),
("eloise.english@gmail.com","5"),
("rahul.vance@gmail.com","5"),
("aisha.suarez@gmail.com","5"),
("abdul.ali@gmail.com","5"),

("dwight.medina@gmail.com","6"),
("jo.mirae@gmail.com","6"),
("japser.griffin@gmail.com","6"),
("sapphire.walker@gmail.com","6"),
("terry.hayes@gmail.com","6"),
("constance.schultz@gmail.com","6"),

("catherine.myres@gmail.com","7"),
("brooke.shultz@gmail.com","7"),
("sarah.jackson@gmail.com","7"),
("evelyn.prescott@gmail.com","7"),
("june.walker@gmail.com","7"),
("samuel.jackson@gmail.com","7"),

("tobias.eaton@gmail.com","8"),
("beatrice.prior@gmail.com","8"),
("damon.ayala@gmail.com","8"),
("kieran.washington@gmail.com","8"),
("jaya.joyce@gmail.com","8"),
("nicole.robinson@gmail.com","8"),

("danny.bianchi@gmail.com","9"),
("yang.zhu@gmail.com","9"),
("jose.leones@gmail.com","9"),
("jules.vernne@gmail.com","9"),
("pearson.reyes@gmail.com","9"),
("robert.drysadle@gmail.com","9");

insert into `COMPONENT` values
("1","Component01","Type1",10,"ORG0000001"),
("2","Component02","Type2",3,"ORG0000002"),
("3","Component03","Type1",1,"ORG0000003"),
("4","Component04","Type2",8,"ORG0000001"),
("5","Component05","Type1",9,"ORG0000002"),
("6","Component06","Type2",60,"ORG0000003"),
("7","Component07","Type1",14,"ORG0000001"),
("8","Component08","Type2",5,"ORG0000002"),
("9","Component09","Type1",3,"ORG0000003"),
("10","Component10","Type2",6,"ORG0000001"), 
("11","Component11","Type1",7,"ORG0000002"),
("12","Component12","Type2",8,"ORG0000003"),    
("13","Component13","Type1",9,"ORG0000001"),
("14","Component14","Type2",18,"ORG0000002"),
("15","Component15","Type1",21,"ORG0000003");

INSERT INTO DELIVERABLE VALUES
("Deliverable A-1","3","7","2022-07-01","2022-10-01"),("Deliverable A-2","3","7","2022-10-01","2023-01-01"),
("Deliverable A-3","3","7","2023-01-01","2023-04-01"),("Deliverable A-4","3","7","2023-04-01","2023-07-01"),
("Deliverable B-1","3","8","2022-07-01","2022-10-01"),("Deliverable B-2","3","8","2022-10-01","2023-01-01"),
("Deliverable B-3","3","8","2023-01-01","2023-04-01"),("Deliverable B-4","3","8","2023-04-01","2023-07-01"),
("Deliverable A-1","1","1","2022-08-15","2022-11-15"),("Deliverable A-2","1","1","2022-11-15","2023-02-15"),
("Deliverable A-3","1","1","2023-02-15","2023-05-15"),("Deliverable A-4","1","1","2023-05-15","2023-08-15"),
("Deliverable B-1","1","2","2022-08-15","2022-11-15"),("Deliverable B-2","1","2","2022-11-15","2023-02-15"),
("Deliverable B-3","1","2","2023-02-15","2023-05-15"),("Deliverable B-4","1","2","2023-05-15","2023-08-15"),
("Deliverable A-1","2","4","2022-09-04","2022-12-04"),("Deliverable A-2","2","4","2022-12-04","2023-03-04"),
("Deliverable A-3","2","4","2023-03-04","2023-06-04"),("Deliverable A-4","2","4","2023-06-04","2023-09-04"),
("Deliverable B-1","2","5","2022-09-04","2022-12-04"),("Deliverable B-2","2","5","2022-12-04","2023-03-04"),
("Deliverable B-3","2","5","2023-03-04","2023-06-04"),("Deliverable B-4","2","5","2023-06-04","2023-09-04");

INSERT INTO PREREQUISITE VALUES
("Deliverable A-2","3","Deliverable A-1","3"),
("Deliverable A-3","3","Deliverable A-2","3"),
("Deliverable A-4","3","Deliverable A-3","3"),
("Deliverable B-2","3","Deliverable B-1","3"),
("Deliverable B-3","3","Deliverable B-2","3"),
("Deliverable B-4","3","Deliverable B-3","3"),
("Deliverable A-2","1","Deliverable A-1","1"),
("Deliverable A-3","1","Deliverable A-2","1"),
("Deliverable A-4","1","Deliverable A-3","1"),
("Deliverable B-2","1","Deliverable B-1","1"),
("Deliverable B-3","1","Deliverable B-2","1"),
("Deliverable B-4","1","Deliverable B-3","1"),
("Deliverable A-2","2","Deliverable A-1","2"),
("Deliverable A-3","2","Deliverable A-2","2"),
("Deliverable A-4","2","Deliverable A-3","2"),
("Deliverable B-2","2","Deliverable B-1","2"),
("Deliverable B-3","2","Deliverable B-2","2"),
("Deliverable B-4","2","Deliverable B-3","2");

INSERT INTO REQUIRES VALUES
("6",20,"Deliverable A-1","3"),
("12",3,"Deliverable A-3","3"),
("15",5,"Deliverable B-2","3"),
("15",7,"Deliverable B-4","3"),
("13",5,"Deliverable A-2","1"),
("7",4,"Deliverable A-4","1"),
("1",3,"Deliverable B-3","1"),
("11",6,"Deliverable A-2","2"),
("5",4,"Deliverable A-3","2"),
("14",8,"Deliverable B-2","2"),
("2",1,"Deliverable B-3","2");

