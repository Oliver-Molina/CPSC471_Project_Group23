DROP DATABASE IF EXISTS `project_manager`;
CREATE DATABASE `project_manager`;
USE PROJECT_MANAGER;

CREATE TABLE BUILDING(
	ID		    CHAR(8)		    NOT NULL,
	BName	    VARCHAR(60),
	BNo		    VARCHAR(5),
	StName	    VARCHAR(100),
	City	    VARCHAR(30),
	ProvStTr	VARCHAR(30),
	Country	    VARCHAR(30),
    PRIMARY KEY(ID)
);

CREATE TABLE ROOM(
	RoomNo		VARCHAR(8) NOT NULL,
	Size		CHAR(1) NOT NULL,
	EstCapacity	INT NOT NULL,
    BuildingID	CHAR(8) NOT NULL,
	PRIMARY KEY(RoomNO, BuildingID),
    FOREIGN KEY(BuildingID) REFERENCES BUILDING(ID)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ORGANIZATION(
	ID			CHAR(10)		NOT NULL,
	OrgName		VARCHAR(30)		NOT NULL,
	Description	VARCHAR(500),
	HRM_No		VARCHAR(8),
	HRM_BID		CHAR(8),
    PRIMARY KEY(ID),
    FOREIGN KEY(HRM_No) REFERENCES ROOM(RoomNo)
    ON UPDATE CASCADE,
    FOREIGN KEY(HRM_BID) REFERENCES ROOM(BuildingID)
    ON UPDATE CASCADE
);

CREATE TABLE MEMBER(
    Fname		VARCHAR(15)		NOT NULL,
    Lname		VARCHAR(15)		NOT NULL,
	Gender		VARCHAR(10),
    Email		VARCHAR(320)	NOT NULL,
    OrgID		CHAR(10),
    Password	CHAR(127)		NOT NULL,
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
	ID		    CHAR(8)		    NOT NULL,
	PName		VARCHAR(30)		NOT NULL,
	StartDate	DATE,
	EndDate	    DATE,			
	OrgID		CHAR(10)		NOT NULL,
    PRIMARY KEY(ID),
    FOREIGN KEY(OrgID) REFERENCES ORGANIZATION(ID) 
    ON DELETE CASCADE ON UPDATE CASCADE
);
 
CREATE TABLE TEAM(
	ID		    CHAR(8)         NOT NULL,
	TName		VARCHAR(30)	    NOT NULL,
	Specialization	VARCHAR(30)	NOT NULL 	DEFAULT "None",
	LeadEmail		VARCHAR(320)        NOT NULL,
	OrgID		CHAR(10)	    NOT NULL,
	ProjectID	CHAR(8),	    
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
	Team_ID		CHAR(8)		NOT NULL,
	PRIMARY KEY(MEmail, Team_ID),
	FOREIGN KEY(MEmail) REFERENCES MEMBER(Email)
    ON DELETE 	CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(Team_ID) REFERENCES TEAM(ID)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE EVENT_(
	EventID		        CHAR(10)	NOT NULL,
	EventName			CHAR(30)    NOT NULL,
	No_Attendees		INTEGER		    NOT NULL DEFAULT 0,
	Description			TINYTEXT,
	StartDateTime		DATETIME	NOT NULL,
    EndDateTime 		DATETIME	NOT NULL,
	HostID			    CHAR(10)	NOT NULL,
	PlannerID		    CHAR(8)		NOT NULL,
	PRIMARY KEY(EventID),
	FOREIGN KEY(HostID) REFERENCES ORGANIZATION(ID)
	ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(PlannerID) REFERENCES TEAM(ID)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE EVENT_USES(
	RoomNo	    VARCHAR(8)	NOT NULL,
	BuildingID	CHAR(8)		NOT NULL,
	EventID 	CHAR(8)		NOT NULL,
    PRIMARY KEY(RoomNo, BuildingID, EventID),
    FOREIGN KEY(EventID) REFERENCES EVENT_(EventID) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(RoomNo, BuildingID) REFERENCES ROOM(RoomNo, BuildingID)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE INVITATION(
    MEmail       VARCHAR(320) NOT NULL,
    EventID         VARCHAR(8) NOT NULL,
    FOREIGN KEY(MEmail) REFERENCES MEMBER(Email)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(EventID) REFERENCES EVENT_(EventID)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE DELIVERABLE(
	DName		VARCHAR(30)	NOT NULL,
	ProjectID	CHAR(8)		NOT NULL,
	TeamID	    CHAR(8),
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
	DepDPID		CHAR(8) 		NOT NULL,
	SrcDname	VARCHAR(30) 	NOT NULL,
	SrcDPID		CHAR(8) 		NOT NULL,
	PRIMARY KEY(DepDname, DepDPID, SrcDname, SrcDPID),
	FOREIGN KEY(DepDname, DepDPID) REFERENCES DELIVERABLE(DName, ProjectID)	
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(SrcDname, SrcDPID) REFERENCES DELIVERABLE(DName, ProjectID)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE COMPONENT(
	PartID		CHAR(16)	NOT NULL,
	CName		VARCHAR(30) NOT NULL,		
	CType		VARCHAR(30),
	Qty			INTEGER			 NOT NULL DEFAULT 1,
	OrgID		CHAR(10)		NOT NULL,	
	PRIMARY KEY(PartID),
	FOREIGN KEY(OrgID) REFERENCES ORGANIZATION(ID)
	ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE REQUIRES (
    PartID CHAR(16) NOT NULL,
    Qty INTEGER NOT NULL,
    Dname VARCHAR(30) NOT NULL,
    DprojectID CHAR(8) NOT NULL,
    PRIMARY KEY (PartID , Dname , DprojectID),
    FOREIGN KEY (Dname , DprojectID) REFERENCES DELIVERABLE (Dname , projectID),
    FOREIGN KEY (PartID) REFERENCES COMPONENT(PartID)
    ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO BUILDING VALUES
("BUILD001","Building 1","1","10th Avenue","Calgary","Alberta","Canada"),
("BUILD002","Building 2","2","16 Street","Vancouver","British Columbia","Canada"),
("BUILD003","Building 3","3","Maple Street","Ottawa","Ontario","Canada"),
("BUILD004","Building 4","4","16th Avenue","Calgary","Alberta","Canada"),
("BUILD005","Building 5","5","Hadron Blvd","Edmonton","Alberta","Canada"),
("BUILD006","Building 6","6","Example St","Windsor","Ontario","Canada"),
("BUILD007","Building 7","7","Placeholder St","Toronto","Ontario","Canada"),
("BUILD008","Building 8","8","Generic Street","Generic City","Province","Country"),
("BUILD009","Building 9","9","Study Street","Generic City","Province","Country"),
("BUILD010","Building 10","10","Euneva Street","Generic City","Province","Country"),
("BUILD011","Building 11","90","Palm Parkway","Cupertino","California","USA"),
("BUILD012","Building 12","72","10th Avenue","Calgary","Alberta","Canada"),
("BUILD013","Building 13","43","Placeholder St","Generic City","Province","Country"),
("BUILD014","Building 14","56","Generic Street","Generic City","Province","Country"),
("BUILD015","Building 15","1","Infinite Loop","Cupertino","California","USA"),
("BUILD016","Building 16","51245","Main Street","Generic City","Province","Country"),
("BUILD017","Building 17","12341","Maple Street","Ottawa","Ontario","Canada"),
("BUILD018","Building 18","12031","Seasame Street","Generic City","Province","Country"),
("BUILD019","Building 19","8023","Hadron Blvd","Generic City","Province","Country"),
("BUILD020","Building 20","42069","Neat Street","Los Angeles","California","USA"),
("BUILD021","Building 21","42069","Neat Street","Los Angeles","California","USA");

INSERT INTO ROOM VALUES
("124","S",8,"BUILD021"),("121-A","M",15,"BUILD021"),("121-B","S",7,"BUILD021"),
("122","S",8,"BUILD021"),("ENE-201","L",50,"BUILD021"),("161-A","L",100,"BUILD002"),
("190-A","L",100,"BUILD003"),("545","M",15,"BUILD004"),("203","M",15,"BUILD005"),
("180","M",15,"BUILD006"),("090","M",15,"BUILD007"),("135","M",15,"BUILD008"),
("112","L",30,"BUILD009"),("323","S",10,"BUILD010"),("782","S",10,"BUILD011"),
("631","S",10,"BUILD012"),("ENE-201","S",10,"BUILD013"),("EB-03","S",10,"BUILD014"),
("HOM-405","S",10,"BUILD015"),("TI-099","S",10,"BUILD016"),("317","M",20,"BUILD017"),
("ABC-123","S",12,"BUILD018"),("090","L",60,"BUILD019"),("NEC-012","M",25,"BUILD020"),
("025","L",40,"BUILD009"),("MIT-333","M",25,"BUILD010"),("EAN-212","M",25,"BUILD011"),
("112","M",25,"BUILD012"),("112","L",75,"BUILD013"),("248","L",50,"BUILD014"),
("0197","M",20,"BUILD015"),("EEC-172","M",20,"BUILD021"),("EEA-297","S",5,"BUILD021"),
("EEB-212","M",25,"BUILD021"),("EED-123","M",25,"BUILD002"),("WOT-123","M",25,"BUILD003"),
("061","M",25,"BUILD004"),("020","M",25,"BUILD005"),("025","L",150,"BUILD005"),
("ENB-123","L",150,"BUILD005"),("162-B","S",12,"BUILD019"),("231","S",8,"BUILD020"),
("33-A","S",8,"BUILD009"),("109","S",8,"BUILD010"),("111-B","L",120,"BUILD011"),
("16","S",10,"BUILD012"),("020","S",10,"BUILD013"),("025","M",25,"BUILD014"),
("246","M",25,"BUILD015"),("AMD-167","M",25,"BUILD021"),("NOC-120","M",25,"BUILD002"),
("030-C","M",25,"BUILD003");

INSERT INTO `ORGANIZATION` VALUES
("ORG0000001","Organization1","Lorem ipsum dolor sit amet, consectetur adipiscing elit","090","BUILD019"),
("ORG0000002","Organization2","Tomato Sauce, Jar","112","BUILD013"),
("ORG0000003","Organization3","There are two kinds of people in the world: those who complete their sentences and-","248","BUILD014");

INSERT INTO `MEMBER` VALUES
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
("Evelyn","Prescott","Female","evelyn.prescott@gmai.com","ORG0000003","Password"),
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

INSERT INTO PROJECT VALUES
("PROJECT1","Project1","2022-08-15","2023-08-15","ORG0000001"),
("PROJECT2","Project2","2022-09-04","2023-09-04","ORG0000002"),
("PROJECT3","Project3","2022-07-01","2023-07-01","ORG0000003");

INSERT INTO TEAM VALUES
("ORG1TEA1","Team 1","Specialization1","samantha.hutchins@gmail.com","ORG0000001","PROJECT1"),
("ORG1TEA2","Team 2","Specialization2","rose.potter@gmail.com","ORG0000001","PROJECT1"),
("ORG1EVEN","Events","Events","glenn.brooks@gmail.com","ORG0000001",NULL),
("ORG2TEA1","Team 1","Specialization1","liliana.brown@gmail.com","ORG0000002","PROJECT2"),
("ORG2TEA2","Team 2","Specialization2","lee.padgett@gmail.com","ORG0000002","PROJECT2"),
("ORG2EVEN","Events","Events","dwight.medina@gmail.com","ORG0000002",NULL),
("ORG3TEA1","Team 1","Specialization1","catherine.myres@gmail.com","ORG0000003","PROJECT3"),
("ORG3TEA2","Team 2","Specialization2","tobias.eaton@gmail.com","ORG0000003","PROJECT3"),
("ORG3EVEN","Events","Events","danny.bianchi@gmail.com","ORG0000003",NULL);

insert into `EVENT_` values
("EVENT003","Event3",80,"Teams will showcase their projects that they have been working on to all attendees","2023-04-22  8:00:00","2023-09-22  22:00:00","ORG0000002","ORG2EVEN"),
("EVENT006","Event6",90,"Trivia Night: Attendees can choose to join a group or just be a part of the audience. There will be special prizes for the top 2 winners.","2022-12-04  11:45:00","2023-12-04  13:15:00","ORG0000002","ORG2EVEN"),
("EVENT009","Event9",500,"Networking experience with companies like Infosys, RBC Innovation Hub, Avidbots Corp., Amazon Web Services for students looking for internships for the year 2023-2024.","2023-02-02  16:15:00","2023-02-03  16:15:00","ORG0000002","ORG2EVEN"),
("EVENT001","Event1",450,"Networking experience with companies like Symend, Suncor, Mphasis, Clearpath Robotics for students looking for internships for the year 2023-2023.","2023-03-14  14:45:00","2023-03-15  14:45:00","ORG0000001","ORG1EVEN"),
("EVENT004","Event4",300,"Networking experience with companies like TC Energy, Attabotics, Microsoft, Google for students looking for internships for the year 2023-2024.","2023-04-23  17:30:00","2023-04-24  17:30:00","ORG0000001","ORG1EVEN"),
("EVENT007","Event7",70,"Teams will showcase their projects that they have been working on to all attendees","2023-04-19  15:30:00","2023-04-19  16:30:00","ORG0000001","ORG1EVEN"),
("EVENT010","Event10",45,"Trivia Night: Attendees can choose to join a group or just be a part of the audience. There will be special prizes for the top 2 winners.","2023-03-15  12:00:00","2023-03-15  13:00:00","ORG0000001","ORG1EVEN"),
("EVENT002","Event2",40,"Clubs Week: Interested applicants can come to this event to get to know about the club and what it has to offer.","2023-05-21  20:00:00","2023-07-21  21:00:00","ORG0000003","ORG3EVEN"),
("EVENT005","Event5",65,"Clubs Week: Interested applicants can come to this event to get to know about the club and what it has to offer.","2022-11-30  20:00:00","2022-11-30  22:00:00","ORG0000003","ORG3EVEN"),
("EVENT008","Event8",55,"Bake Sale: Members of the clubs will bring self-baked goods for this fundraiser event.","2023-01-11  12:30:00","2023-01-11  13:30:00","ORG0000003","ORG3EVEN");

insert into EVENT_USES values
("AMD-167","BUILD021", "EVENT003"),
("190-A","BUILD003", "EVENT006"),
("161-A","BUILD002", "EVENT009"),
("ENB-123","BUILD005", "EVENT001"),
("ENB-123","BUILD005", "EVENT004"),
("112","BUILD013", "EVENT007"),
("ENE-201","BUILD021", "EVENT010"),
("248","BUILD014", "EVENT002"),
("EED-123","BUILD002", "EVENT005"),
("025","BUILD009", "EVENT008");

INSERT INTO BELONGS VALUES
("samantha.hutchins@gmail.com","ORG1TEA1"),
("terry.crews@gmail.com","ORG1TEA1"),
("florence.nightingale@gmail.com","ORG1TEA1"),
("maria.sabella@gmail.com","ORG1TEA1"),
("samus.aran@gmail.com","ORG1TEA1"),
("lucy.jackson@gmail.com","ORG1TEA1"),

("rose.potter@gmail.com","ORG1TEA2"),
("roy.strickland@gmail.com","ORG1TEA2"),
("malachi.clay@gmail.com","ORG1TEA2"),
("nana.maxwell@gmail.com","ORG1TEA2"),
("laurence.banks@gmail.com","ORG1TEA2"),
("henry.jones@gmail.com","ORG1TEA2"),

("glenn.brooks@gmail.com","ORG1EVEN"),
("ivy.thomas@gmail.com","ORG1EVEN"),
("olivia.mathews@gmail.com","ORG1EVEN"),
("david.lambert@gmail.com","ORG1EVEN"),
("matteo.bianchi@gmail.com","ORG1EVEN"),
("jim.thompson@gmail.com","ORG1EVEN"),

("liliana.brown@gmail.com","ORG2TEA1"),
("kevin.leary@gmail.com","ORG2TEA1"),
("john.doe@gmail.com","ORG2TEA1"),
("megan.holmes@gmail.com","ORG2TEA1"),
("eleni.nikolaou@gmail.com","ORG2TEA1"),
("virginia.habig@gmail.com","ORG2TEA1"),

("lee.padgett@gmail.com","ORG2TEA2"),
("jpdesbois@gmail.com","ORG2TEA2"),
("eloise.english@gmail.com","ORG2TEA2"),
("rahul.vance@gmail.com","ORG2TEA2"),
("aisha.suarez@gmail.com","ORG2TEA2"),
("abdul.ali@gmail.com","ORG2TEA2"),

("dwight.medina@gmail.com","ORG2EVEN"),
("jo.mirae@gmail.com","ORG2EVEN"),
("japser.griffin@gmail.com","ORG2EVEN"),
("sapphire.walker@gmail.com","ORG2EVEN"),
("terry.hayes@gmail.com","ORG2EVEN"),
("constance.schultz@gmail.com","ORG2EVEN"),

("catherine.myres@gmail.com","ORG3TEA1"),
("brooke.shultz@gmail.com","ORG3TEA1"),
("sarah.jackson@gmail.com","ORG3TEA1"),
("evelyn.prescott@gmai.com","ORG3TEA1"),
("june.walker@gmail.com","ORG3TEA1"),
("samuel.jackson@gmail.com","ORG3TEA1"),

("tobias.eaton@gmail.com","ORG3TEA2"),
("beatrice.prior@gmail.com","ORG3TEA2"),
("damon.ayala@gmail.com","ORG3TEA2"),
("kieran.washington@gmail.com","ORG3TEA2"),
("jaya.joyce@gmail.com","ORG3TEA2"),
("nicole.robinson@gmail.com","ORG3TEA2"),

("danny.bianchi@gmail.com","ORG3EVEN"),
("yang.zhu@gmail.com","ORG3EVEN"),
("jose.leones@gmail.com","ORG3EVEN"),
("jules.vernne@gmail.com","ORG3EVEN"),
("pearson.reyes@gmail.com","ORG3EVEN"),
("robert.drysadle@gmail.com","ORG3EVEN");


insert into `COMPONENT` values
("COMPONENT0000002","Component02","Type2",3,"ORG0000002"),
("COMPONENT0000005","Component05","Type1",9,"ORG0000002"),
("COMPONENT0000008","Component08","Type2",5,"ORG0000002"),
("COMPONENT0000011","Component11","Type1",7,"ORG0000002"),
("COMPONENT0000014","Component14","Type2",18,"ORG0000002"),
("COMPONENT0000001","Component01","Type1",10,"ORG0000001"),
("COMPONENT0000004","Component04","Type2",8,"ORG0000001"),
("COMPONENT0000007","Component07","Type1",14,"ORG0000001"),
("COMPONENT0000010","Component10","Type2",6,"ORG0000001"),
("COMPONENT0000013","Component13","Type1",9,"ORG0000001"),
("COMPONENT0000003","Component03","Type1",1,"ORG0000003"),
("COMPONENT0000006","Component06","Type2",60,"ORG0000003"),
("COMPONENT0000009","Component09","Type1",3,"ORG0000003"),
("COMPONENT0000012","Component12","Type2",8,"ORG0000003"),
("COMPONENT0000015","Component15","Type1",21,"ORG0000003");

INSERT INTO DELIVERABLE VALUES
("Deliverable A-1","PROJECT3","ORG3TEA1","2022-07-01","2022-10-01"),("Deliverable A-2","PROJECT3","ORG3TEA1","2022-10-01","2023-01-01"),
("Deliverable A-3","PROJECT3","ORG3TEA1","2023-01-01","2023-04-01"),("Deliverable A-4","PROJECT3","ORG3TEA1","2023-04-01","2023-07-01"),
("Deliverable B-1","PROJECT3","ORG3TEA2","2022-07-01","2022-10-01"),("Deliverable B-2","PROJECT3","ORG3TEA2","2022-10-01","2023-01-01"),
("Deliverable B-3","PROJECT3","ORG3TEA2","2023-01-01","2023-04-01"),("Deliverable B-4","PROJECT3","ORG3TEA2","2023-04-01","2023-07-01"),
("Deliverable A-1","PROJECT1","ORG1TEA1","2022-08-15","2022-11-15"),("Deliverable A-2","PROJECT1","ORG1TEA1","2022-11-15","2023-02-15"),
("Deliverable A-3","PROJECT1","ORG1TEA1","2023-02-15","2023-05-15"),("Deliverable A-4","PROJECT1","ORG1TEA1","2023-05-15","2023-08-15"),
("Deliverable B-1","PROJECT1","ORG1TEA2","2022-08-15","2022-11-15"),("Deliverable B-2","PROJECT1","ORG1TEA2","2022-11-15","2023-02-15"),
("Deliverable B-3","PROJECT1","ORG1TEA2","2023-02-15","2023-05-15"),("Deliverable B-4","PROJECT1","ORG1TEA2","2023-05-15","2023-08-15"),
("Deliverable A-1","PROJECT2","ORG2TEA1","2022-09-04","2022-12-04"),("Deliverable A-2","PROJECT2","ORG2TEA1","2022-12-04","2023-03-04"),
("Deliverable A-3","PROJECT2","ORG2TEA1","2023-03-04","2023-06-04"),("Deliverable A-4","PROJECT2","ORG2TEA1","2023-06-04","2023-09-04"),
("Deliverable B-1","PROJECT2","ORG2TEA2","2022-09-04","2022-12-04"),("Deliverable B-2","PROJECT2","ORG2TEA2","2022-12-04","2023-03-04"),
("Deliverable B-3","PROJECT2","ORG2TEA2","2023-03-04","2023-06-04"),("Deliverable B-4","PROJECT2","ORG2TEA2","2023-06-04","2023-09-04");

INSERT INTO PREREQUISITE VALUES
("Deliverable A-2","PROJECT3","Deliverable A-1","PROJECT3"),
("Deliverable A-3","PROJECT3","Deliverable A-2","PROJECT3"),
("Deliverable A-4","PROJECT3","Deliverable A-3","PROJECT3"),
("Deliverable B-2","PROJECT3","Deliverable B-1","PROJECT3"),
("Deliverable B-3","PROJECT3","Deliverable B-2","PROJECT3"),
("Deliverable B-4","PROJECT3","Deliverable B-3","PROJECT3"),
("Deliverable A-2","PROJECT1","Deliverable A-1","PROJECT1"),
("Deliverable A-3","PROJECT1","Deliverable A-2","PROJECT1"),
("Deliverable A-4","PROJECT1","Deliverable A-3","PROJECT1"),
("Deliverable B-2","PROJECT1","Deliverable B-1","PROJECT1"),
("Deliverable B-3","PROJECT1","Deliverable B-2","PROJECT1"),
("Deliverable B-4","PROJECT1","Deliverable B-3","PROJECT1"),
("Deliverable A-2","PROJECT2","Deliverable A-1","PROJECT2"),
("Deliverable A-3","PROJECT2","Deliverable A-2","PROJECT2"),
("Deliverable A-4","PROJECT2","Deliverable A-3","PROJECT2"),
("Deliverable B-2","PROJECT2","Deliverable B-1","PROJECT2"),
("Deliverable B-3","PROJECT2","Deliverable B-2","PROJECT2"),
("Deliverable B-4","PROJECT2","Deliverable B-3","PROJECT2");

INSERT INTO REQUIRES VALUES
("COMPONENT0000006",20,"Deliverable A-1","PROJECT3"),
("COMPONENT0000012",3,"Deliverable A-3","PROJECT3"),
("COMPONENT0000015",5,"Deliverable B-2","PROJECT3"),
("COMPONENT0000015",7,"Deliverable B-4","PROJECT3"),
("COMPONENT0000013",5,"Deliverable A-2","PROJECT1"),
("COMPONENT0000007",4,"Deliverable A-4","PROJECT1"),
("COMPONENT0000001",3,"Deliverable B-3","PROJECT1"),
("COMPONENT0000011",6,"Deliverable A-2","PROJECT2"),
("COMPONENT0000005",4,"Deliverable A-3","PROJECT2"),
("COMPONENT0000014",8,"Deliverable B-2","PROJECT2"),
("COMPONENT0000002",1,"Deliverable B-3","PROJECT2");
