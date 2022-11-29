DROP DATABASE IF EXISTS PROJECT_MANAGER;
CREATE DATABASE PROJECT_MANAGER;
USE PROJECT_MANAGER;
CREATE TABLE BUILDING(
	ID		    CHAR(8)		    NOT NULL,
	BName	    VARCHAR(60)     NOT NULL,
	BNo		    VARCHAR(5)		NOT NULL,
	StName	    VARCHAR(100)    NOT NULL,
	City	    VARCHAR(30)	    NOT NULL,
	ProvStTr	VARCHAR(30)	    NOT NULL,
	Country	    VARCHAR(30)	    NOT NULL,
    PRIMARY KEY(ID)
);
INSERT INTO BUILDING VALUES
("X1G3NXY4","Building1","1","10th Avenue","Calgary","Alberta","Canada"),("N1XDYYPP","Building 2","2","16 Street","Vancouver","British Columbia","Canada"),
("B4LV9603","Building 3","3","Maple Street","Ottawa","Ontario","Canada"),("B8YNUYUD","Building 4","4","16th Avenue","Calgary","Alberta","Canada"),
("78RXZ4HC","Building 5","5","Hadron Blvd","Edmonton","Alberta","Canada"),("FUZSPR9Q","Building 6","6","Example St","Windsor","Ontario","Canada"),
("WP16CQ5D","Building 7","7","Placeholder St","Toronto","Ontario","Canada"),("K97OED44","Building 8","8","Generic Street","Generic City","Province","Country"),
("U8MMDHVV","Building 9","9","Study Street","Generic City","Province","Country"),("YU35YPZP","Building 10","10","Euneva Street","Generic City","Province","Country"),
("AKQ17BG8","Building1","90","Palm Parkway","Cupertino","California","USA"),("4MC5BQGD","Building 2","72","10th Avenue","Calgary","Alberta","Canada"),
("748JHSTL","Building 3","43","Placeholder St","Generic City","Province","Country"),("OJ972RU7","Building 4","56","Generic Street","Generic City","Province","Country"),
("WDDOXHOM","Building 5","1","Infinite Loop","Cupertino","California","USA"),("KFVTPL1F","Building 6","51245","Main Street","Generic City","Province","Country"),
("1KXXBAW8","Building 7","12341","Maple Street","Ottawa","Ontario","Canada"),("F6HTJ9Q2","Building 8","12031","Seasame Street","Generic City","Province","Country"),
("9WRYZ797","Building 9","8023","Hadron Blvd","Generic City","Province","Country"),("XKXDLD51","Building 10","42069","Neat Street","Los Angeles","California","USA"),
("1G3YNXY4","Building 11","42069","Neat Street","Los Angeles","California","USA");
CREATE TABLE ROOM(
	RoomNo		VARCHAR(8) NOT NULL,
	Size		CHAR(1) NOT NULL,
	EstCapacity	INT NOT NULL,
    BuildingID	CHAR(8) NOT NULL,
	PRIMARY KEY(RoomNO, BuildingID),
    CONSTRAINT SIZECHK CHECK(
    (Size = "L" AND EstCapacity > 25)OR 
    (Size = "M" AND 25>= EstCapacity AND 15<=EstCapacity)OR 
    (Size = "S" AND EstCapacity < 15)
    )
);
INSERT INTO ROOM VALUES
("124","S",8,"1G3YNXY4"),("121-A","M",15,"1G3YNXY4"),("121-B","S",7,"1G3YNXY4"),
("122","S",8,"1G3YNXY4"),("ENE-201","L",50,"1G3YNXY4"),("161-A","L",100,"N1XDYYPP"),
("190-A","L",100,"B4LV9603"),("545","M",15,"B8YNUYUD"),("203","M",15,"78RXZ4HC"),
("180","M",15,"FUZSPR9Q"),("090","M",15,"WP16CQ5D"),("135","M",15,"K97OED44"),
("112","L",30,"U8MMDHVV"),("323","S",10,"YU35YPZP"),("782","S",10,"AKQ17BG8"),
("631","S",10,"4MC5BQGD"),("ENE-201","S",10,"748JHSTL"),("EB-03","S",10,"OJ972RU7"),
("HOM-405","S",10,"WDDOXHOM"),("TI-099","S",10,"KFVTPL1F"),("317","M",20,"1KXXBAW8"),
("ABC-123","S",12,"F6HTJ9Q2"),("090","L",60,"9WRYZ797"),("NEC-012","M",25,"XKXDLD51"),
("025","L",40,"U8MMDHVV"),("MIT-333","M",25,"YU35YPZP"),("EAN-212","M",25,"AKQ17BG8"),
("112","M",25,"4MC5BQGD"),("112","L",75,"748JHSTL"),("248","L",50,"OJ972RU7"),
("0197","M",20,"WDDOXHOM"),("EEC-172","M",20,"1G3YNXY4"),("EEA-297","S",5,"1G3YNXY4"),
("EEB-212","M",25,"1G3YNXY4"),("EED-123","M",25,"N1XDYYPP"),("WOT-123","M",25,"B4LV9603"),
("061","M",25,"B8YNUYUD"),("020","M",25,"78RXZ4HC"),("025","L",150,"78RXZ4HC"),
("ENB-123","L",150,"78RXZ4HC"),("162-B","S",12,"9WRYZ797"),("231","S",8,"XKXDLD51"),
("33-A","S",8,"U8MMDHVV"),("109","S",8,"YU35YPZP"),("111-B","L",120,"AKQ17BG8"),
("16","S",10,"4MC5BQGD"),("020","S",10,"748JHSTL"),("025","M",25,"OJ972RU7"),
("246","M",25,"WDDOXHOM"),("AMD-167","M",25,"1G3YNXY4"),("NOC-120","M",25,"N1XDYYPP"),
("030-C","M",25,"B4LV9603");
ALTER TABLE ROOM
ADD CONSTRAINT BUILDINGFK FOREIGN KEY(BuildingID) REFERENCES BUILDING(ID)
ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TABLE MEMBER(
	ID			CHAR(8)			NOT NULL,
    Fname		VARCHAR(15)		NOT NULL,
    Lname		VARCHAR(15)		NOT NULL,
    Gender	    VARCHAR(10),
	Email		VARCHAR(320)	NOT NULL,
    StartDate	DATE			NOT NULL,
    OrgID		CHAR(10),
    PRIMARY KEY(ID)
);
INSERT INTO MEMBER VALUES
("42145777","John","Doe","Male","john.doe102@gmail.com","2020-09-22","EFT3IW4NWF"),
("28687180","Megan","Holmes","Female","megan.holmes@gmail.com","2021-04-15","EFT3IW4NWF"),
("43414582","Eleni","Nikolaou","Female","eleni.niko@gmail.com","2022-10-11","EFT3IW4NWF"),
("66357212","Virginia","Habig","Female","virginia.habig@hotmail.com","2021-03-18","EFT3IW4NWF"),
("44937185","Lee","Padgett","Male","lpadgett@hotmail.com","2021-04-21","EFT3IW4NWF"),
("66839421","Jean-Pierre","Desbois","Male","jpdesbois@gmail.com","2022-10-13","EFT3IW4NWF"),
("79751347","Eloise","English","Female","eloise.english@gmail.com","2020-09-29","EFT3IW4NWF"),
("78177734","Rahul","Vance","Male","rahul.vance@gmail.com","2021-04-07","EFT3IW4NWF"),
("21734521","Aisha","Suarez","Female","aisha.suarez@gmail.com","2021-04-29","EFT3IW4NWF"),
("90250420","Abdul","Ali","Male","abdul.ali@gmail.com","2021-04-28","EFT3IW4NWF"),
("71610654","Dwight","Medina","Male","dwight.medina@gmail.com","2021-04-21","EFT3IW4NWF"),
("12427540","Jo","Mirae","Female","jo.mirae@gmail.com","2021-03-22","EFT3IW4NWF"),
("30779845","Japser","Griffin","Female","japser.griffin@gmail.com","2021-04-28","EFT3IW4NWF"),
("96152855","Sapphire","Walker","Female","sapphire.walker@gmail.com","2021-04-21","EFT3IW4NWF"),
("32114292","Terrence","Hayes","Male","terry.hayes@gmail.com","2021-04-27","EFT3IW4NWF"),
("94558524","Liliana","Brown","Female","liliana.brown@gmail.com","2020-09-25","EFT3IW4NWF"),
("96406803","Constance","Schultz","Male","constance.schultz@gmail.com","2021-03-15","EFT3IW4NWF"),
("73997687","Samantha","Hutchins","Female","samhutch391@gmail.com","2020-09-29","RXKLOS1SA6"),
("47902909","Terry","Crews","Male","tcrew101@gmail.com","2021-04-07","RXKLOS1SA6"),
("76679032","Florence","Nightingale","Female","fnightingale@gmail.com","2021-04-29","RXKLOS1SA6"),
("91451497","Maria","Sabella","Female","msabella@gmail.com","2021-04-28","RXKLOS1SA6"),
("50210024","Samus","Aran","Female","samus.aran@gmail.com","2020-09-22","RXKLOS1SA6"),
("49123455","Lucy","Jackson","Female","lucy.jackson@gmail.com","2021-04-15","RXKLOS1SA6"),
("92028456","Rose","Potter","Female","rose.potter@hotmail.com","2022-10-11","RXKLOS1SA6"),
("14296409","Roy","Strickland","Male","roy.strickland@gmail.com","2021-03-18","RXKLOS1SA6"),
("37771952","Malachi","Clay","Male","malachi.clay@gmail.com","2021-04-21","RXKLOS1SA6"),
("12784897","Nana","Maxwell","Female","nana.maxwell@gmail.com","2022-10-13","RXKLOS1SA6"),
("89405093","Laurence","Banks","Male","laurence.banks@gmail.com","2020-09-29","RXKLOS1SA6"),
("51146876","Henry","Jones","Male","henry.jones@gmail.com","2021-03-31","RXKLOS1SA6"),
("28526851","Glenn","Brooks","Male","glenn.brooks@gmail.com","2021-03-31","RXKLOS1SA6"),
("73164769","Ivy","Thomas","Female","ivy.thomas@gmail.com","2020-09-29","RXKLOS1SA6"),
("69118391","Olivia","Matthews","Female","olivia.mathews@gmail.com","2021-09-21","RXKLOS1SA6"),
("91815665","David","Lambert","Male","lambda1040@gmail.com","2021-09-30","RXKLOS1SA6"),
("98509061","Matteo","Bianchi","Male","mattbianchi@gmail.com","2021-03-30","RXKLOS1SA6"),
("84415100","Catherine","Myres","Female","catherine.myres@gmail.com","2021-03-18","U4Z467MB6A"),
("58147624","Sarah","Jackson","Female","sarah.jackson@gmail.com","2021-04-21","U4Z467MB6A"),
("96718013","Evelyn","Prescott","Female","evelyn.prescott@gmai.com","2021-04-29","U4Z467MB6A"),
("36313608","June","Walker","Female","junewalker2029@gmail.com","2020-09-29","U4Z467MB6A"),
("14144507","Samuel","Jackson","Male","sjackson1948@gmail.com","2021-04-07","U4Z467MB6A"),
("89212423","Tobias","Eaton","Male","tobias.eaton@gmail.com","2021-04-29","U4Z467MB6A"),
("95112480","Maia","Rhodes","Female","maia.rhodes@gmail.com","2021-04-28","U4Z467MB6A"),
("21174274","Damon","Ayala","Male","damon.ayala@gmail.com","2020-09-22","U4Z467MB6A"),
("45182042","Kieran","Washington","Male","kieran.washington@gmail.com","2021-04-15","U4Z467MB6A"),
("54137946","Jaya","Joyce","Female","jaya.joyce@gmail.com","2022-10-11","U4Z467MB6A"),
("62359123","Nicole","Robinson","Female","nicole.robinson@gmail.com","2021-03-18","U4Z467MB6A"),
("71917500","Yang","Zhu","Male","yang.zhu@gmail.com","2021-03-30","U4Z467MB6A"),
("72065666","Jose","Leones","Male","jose.leones@gmail.com","2021-03-30","U4Z467MB6A"),
("72794580","Jules","Vernne","Male","jules.vernne@gmail.com","2021-03-18","U4Z467MB6A"),
("42826789","Pearson","Reyes","Male","pearson.reyes@gmail.com","2021-10-03","U4Z467MB6A"),
("52676143","Danielle","Bianchi","Female","danibianchi2001@gmail.com","2021-04-13","U4Z467MB6A"),
("58606756","Robert","Drysdale","Male","robert.drysadle@gmail.com","2022-10-06","U4Z467MB6A");

CREATE TABLE ADMIN(
	Position   VARCHAR(30)	NOT NULL,
	ID		   CHAR(8)		NOT NULL,
	CONSTRAINT ADMIN_PK PRIMARY KEY(ID, Position),
	CONSTRAINT ID_FK FOREIGN KEY(ID) REFERENCES MEMBER(ID)
	ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO ADMIN VALUES
("Head","91815665"),
("Head","94558524"),
("Head","58606756"),
("Team 1 Lead","69118391"),
("Team 1 Lead","32114292"),
("Team 1 Lead","42826789"),
("Team 2 Lead","94558524"),
("Team 2 Lead","91815665"),
("Team 2 Lead","52676143"),
("Events Team Lead","96406803"),
("Events Team Lead","98509061"),
("Events Team Lead","58606756");

CREATE TABLE ORGANIZATION(
	ID			CHAR(10)		NOT NULL,
	OrgName		VARCHAR(30)		NOT NULL,
	HeadID		CHAR(8),
	Description	VARCHAR(500),
	HRM_No		VARCHAR(8),
	HRM_BID		CHAR(8),
PRIMARY KEY(ID)
);
INSERT INTO ORGANIZATION VALUES
("RXKLOS1SA6","Organization1","91815665","Lorem ipsum dolor sit amet, consectetur adipiscing elit","090","9WRYZ797"),
("EFT3IW4NWF","Organization2","94558524","Tomato Sauce, Jar","112","748JHSTL"),
("U4Z467MB6A","Organization3","58606756","There are two kinds of people in the world: those who complete their sentences and-","248","OJ972RU7");

ALTER TABLE ORGANIZATION
ADD CONSTRAINT HEADFK
FOREIGN KEY(HeadID) REFERENCES ADMIN(ID)
ON DELETE SET NULL ON UPDATE CASCADE,

ADD CONSTRAINT HMRM_FK
FOREIGN KEY(HRM_NO, HRM_BID) REFERENCES ROOM(RoomNo, BuildingID)
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE MEMBER
ADD CONSTRAINT ORG_ID_FK FOREIGN KEY(OrgID) REFERENCES ORGANIZATION(ID)
ON DELETE SET NULL ON UPDATE CASCADE;
CREATE TABLE PROJECT(
	ID		    CHAR(8)		    NOT NULL,
	Name		VARCHAR(30)		NOT NULL,
	StartDate	DATE,
	EndDate	    DATE,			
	OrgID		CHAR(10)		NOT NULL,
    CONSTRAINT PROJECT_PK PRIMARY KEY(ID),
    CONSTRAINT ORG_FK2 FOREIGN KEY(OrgID) REFERENCES ORGANIZATION(ID) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
INSERT INTO PROJECT VALUES
("0KSVC1Y7","Project1","2022-08-15","2023-08-15","RXKLOS1SA6"),
("P5COFVGB","Project2","2022-09-04","2023-09-04","EFT3IW4NWF"),
("0CG9KJ16","Project3","2022-07-01","2023-07-01","U4Z467MB6A");

CREATE TABLE TEAM(
	ID		    CHAR(8)         NOT NULL,
	TName		VARCHAR(30)	    NOT NULL,
    Size		Int,
	Specialization	VARCHAR(30)	NOT NULL 	DEFAULT "None",
	LeadID		CHAR(8),    
	OrgID		CHAR(10)	    NOT NULL,
	ProjectID	CHAR(8),	    
	PRIMARY KEY(ID),
	CONSTRAINT NAME_CHK CHECK (TName != " ")
    );
INSERT INTO TEAM VALUES
("92132080","Team 1",NULL,"Specialization1","69118391","RXKLOS1SA6","0KSVC1Y7"),
("34365667","Team 1",NULL,"Specialization1","32114292","EFT3IW4NWF","P5COFVGB"),
("81252958","Team 1",NULL,"Specialization1","42826789","U4Z467MB6A","0CG9KJ16"),
("90903641","Team 2",NULL,"Specialization2","91815665","RXKLOS1SA6","0KSVC1Y7"),
("87381192","Team 2",NULL,"Specialization2","94558524","EFT3IW4NWF","P5COFVGB"),
("89438180","Team 2",NULL,"Specialization2","52676143","U4Z467MB6A","0CG9KJ16"),
("45398685","Events",NULL,"Specialization3","98509061","RXKLOS1SA6",NULL),
("52158927","Events",NULL,"Specialization3","58606756","U4Z467MB6A",NULL),
("81239446","Events",NULL,"Specialization3","96406803","EFT3IW4NWF",NULL);

ALTER TABLE TEAM
Add CONSTRAINT LEAD_FK FOREIGN KEY(LeadID) REFERENCES ADMIN(ID)
ON DELETE SET NULL 	ON UPDATE CASCADE,
ADD CONSTRAINT ORG_FK FOREIGN KEY(OrgID) REFERENCES ORGANIZATION(ID)
ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TABLE EVENT(
	EventID		        CHAR(10)	NOT NULL,
	EventName			CHAR(30)    NOT NULL,
	No_Attendees		INT		    NOT NULL DEFAULT 1,
	Description			TEXT,
	StartDateTime		TIMESTAMP	NOT NULL,
	EndDateTime		    TIMESTAMP	NOT NULL,
	HostID			    CHAR(10)	NOT NULL,
	PlannerID		    CHAR(8)		NOT NULL,
	PRIMARY KEY(EventID),
	CONSTRAINT No_Attendees_CHK CHECK(No_Attendees > 0),
	CONSTRAINT DATEENDCHK CHECK(EndDateTime > StartDateTime),
	CONSTRAINT HOST_FK FOREIGN KEY(HostID) REFERENCES ORGANIZATION(ID)
	ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT PLANNER_FK FOREIGN KEY(PlannerID) REFERENCES TEAM(ID)
    ON DELETE CASCADE ON UPDATE CASCADE
);
insert into EVENT values
("VG5V8A04","Event3",80,"Teams will showcase their projects that they have been working on to all attendees","2023-04-22  8:00:00","2023-09-22  22:00:00","EFT3IW4NWF","81239446"),
("78QCIB4Q","Event6",90,"Trivia Night: Attendees can choose to join a group or just be a part of the audience. There will be special prizes for the top 2 winners.","2022-12-04  11:45:00","2023-12-04  13:15:00","EFT3IW4NWF","81239446"),
("AEMO76KO","Event9",500,"Networking experience with companies like Infosys, RBC Innovation Hub, Avidbots Corp., Amazon Web Services for students looking for internships for the year 2023-2024.","2023-02-02  16:15:00","2023-02-03  16:15:00","EFT3IW4NWF","81239446"),
("9JRXG4N9","Event1",450,"Networking experience with companies like Symend, Suncor, Mphasis, Clearpath Robotics for students looking for internships for the year 2023-2023.","2023-03-14  14:45:00","2023-03-15  14:45:00","RXKLOS1SA6","45398685"),
("L96XMAEM","Event4",300,"Networking experience with companies like TC Energy, Attabotics, Microsoft, Google for students looking for internships for the year 2023-2024.","2023-04-23  17:30:00","2023-04-24  17:30:00","RXKLOS1SA6","45398685"),
("9X1ANSOD","Event7",70,"Teams will showcase their projects that they have been working on to all attendees","2023-04-19  15:30:00","2023-04-19  16:30:00","RXKLOS1SA6","45398685"),
("IU9Q918J","Event10",45,"Trivia Night: Attendees can choose to join a group or just be a part of the audience. There will be special prizes for the top 2 winners.","2023-03-15  12:00:00","2023-03-15  13:00:00","RXKLOS1SA6","45398685"),
("M9770BFJ","Event2",40,"Clubs Week: Interested applicants can come to this event to get to know about the club and what it has to offer.","2023-05-21  20:00:00","2023-07-21  21:00:00","U4Z467MB6A","52158927"),
("82T2HN5K","Event5",65,"Clubs Week: Interested applicants can come to this event to get to know about the club and what it has to offer.","2022-11-30  20:00:00","2022-11-30  22:00:00","U4Z467MB6A","52158927"),
("5Z2QD8GX","Event8",55,"Bake Sale: Members of the clubs will bring self-baked goods for this fundraiser event.","2023-01-11  12:30:00","2023-01-11  13:30:00","U4Z467MB6A","52158927");
CREATE TABLE USES(
	RoomNo	    VARCHAR(8)	NOT NULL,
	BuildingID	CHAR(8)		NOT NULL,
	StartTime	TIMESTAMP	NOT NULL,
	EndTime	    TIMESTAMP	NOT NULL,
	EventID 	CHAR(8)		NOT NULL,
    CONSTRAINT USES PRIMARY KEY(RoomNo, BuildingID, EventID),
    CONSTRAINT CHECK_DATE CHECK(EndTime > StartTime),
    CONSTRAINT EVENT_FK FOREIGN KEY(EventID) REFERENCES EVENT(EventID) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT ROOM_FK FOREIGN KEY(RoomNo, BuildingID) 
    REFERENCES ROOM(RoomNo, BuildingID)
    ON DELETE CASCADE ON UPDATE CASCADE
);
insert into USES values
("AMD-167","1G3YNXY4","2023-04-22  8:00:00","2023-09-22  22:00:00","VG5V8A04"),
("190-A","B4LV9603","2022-12-04  11:45:00","2023-12-04  13:15:00","78QCIB4Q"),
("161-A","N1XDYYPP","2023-02-02  16:15:00","2023-02-03  16:15:00","AEMO76KO"),
("ENB-123","78RXZ4HC","2023-03-14  14:45:00","2023-03-15  14:45:00","9JRXG4N9"),
("ENB-123","78RXZ4HC","2023-04-23  17:30:00","2023-04-24  17:30:00","L96XMAEM"),
("112","748JHSTL","2023-04-19  15:30:00","2023-04-19  16:30:00","9X1ANSOD"),
("ENE-201","1G3YNXY4","2023-03-15  12:00:00","2023-03-15  13:00:00","IU9Q918J"),
("248","OJ972RU7","2023-05-21  20:00:00","2023-07-21  21:00:00","M9770BFJ"),
("EED-123","N1XDYYPP","2022-11-30  20:00:00","2022-11-30  22:00:00","82T2HN5K"),
("025","U8MMDHVV","2023-01-11  12:30:00","2023-01-11  13:30:00","5Z2QD8GX");
CREATE TABLE BELONGS(
	Member_ID	CHAR(8) 	NOT NULL,
	Team_ID		CHAR(8)		NOT NULL,
	CONSTRAINT TEAM_MEMBER_PK
	PRIMARY KEY(Member_ID, Team_ID),
	CONSTRAINT MEMBER_FK
	FOREIGN KEY(Member_ID) REFERENCES MEMBER(ID) ON DELETE 	CASCADE ON UPDATE CASCADE,
	CONSTRAINT TEAM_ID_FK FOREIGN KEY(Team_ID) REFERENCES TEAM(ID) ON DELETE
	CASCADE ON UPDATE CASCADE
);
insert into BELONGS values
("42145777","34365667"),("28687180","34365667"),("43414582","34365667"),("32114292","34365667"),
("90250420","34365667"),("71610654","34365667"),("12427540","34365667"),("30779845","34365667"),
("66357212","87381192"),("44937185","87381192"),("66839421","87381192"),("94558524","87381192"),
("90250420","87381192"),("71610654","87381192"),("30779845","87381192"),("96152855","87381192"),
("79751347","81239446"),("78177734","81239446"),("21734521","81239446"),("96406803","81239446"),
("90250420","81239446"),("71610654","81239446"),("12427540","81239446"),("96152855","81239446"),
("73997687","92132080"),("47902909","92132080"),("76679032","92132080"),("69118391","92132080"),
("12784897","92132080"),("89405093","92132080"),("51146876","92132080"),("28526851","92132080"),
("91451497","90903641"),("50210024","90903641"),("49123455","90903641"),("91815665","90903641"),
("12784897","90903641"),("89405093","90903641"),("28526851","90903641"),("73164769","90903641"),
("92028456","45398685"),("14296409","45398685"),("37771952","45398685"),("98509061","45398685"),
("12784897","45398685"),("89405093","45398685"),("51146876","45398685"),("73164769","45398685"),
("84415100","81252958"),("58147624","81252958"),("96718013","81252958"),("42826789","81252958"),
("54137946","81252958"),("62359123","81252958"),("71917500","81252958"),("72065666","81252958"),
("36313608","89438180"),("14144507","89438180"),("89212423","89438180"),("52676143","89438180"),
("54137946","89438180"),("62359123","89438180"),("72065666","89438180"),("72794580","89438180"),
("95112480","52158927"),("21174274","52158927"),("45182042","52158927"),("58606756","52158927"),
("54137946","52158927"),("62359123","52158927"),("71917500","52158927"),("72794580","52158927");
CREATE TABLE COMPONENT(
	PartID		CHAR(16)	NOT NULL,
	CName		VARCHAR(30),		
	CType		VARCHAR(30),
	Qty			INT			 NOT NULL DEFAULT 1,
	OrgID		CHAR(10)		NOT NULL,	
	PRIMARY KEY(PartID),
	CONSTRAINT QTY_CHK CHECK(Qty > 0),
	CONSTRAINT ORG_FK3 FOREIGN KEY(OrgID) REFERENCES ORGANIZATION(ID)
	ON DELETE CASCADE ON UPDATE CASCADE
);
insert into COMPONENT values
("C2E6FLKTIICE5BXF","Component2","Type2",3,"EFT3IW4NWF"),
("8W9PZMTR1YUP0WSY","Component5","Type1",9,"EFT3IW4NWF"),
("W3T9OSKNY8KRI6UX","Component8","Type2",5,"EFT3IW4NWF"),
("B1OHI9GOC9WA7H7Y","Component11","Type1",7,"EFT3IW4NWF"),
("IPHH9GPJDZY3URGR","Component14","Type2",18,"EFT3IW4NWF"),
("61I6YHRYDOSLZMWI","Component1","Type1",10,"RXKLOS1SA6"),
("BJFDVIHPT6DLOCSW","Component4","Type2",8,"RXKLOS1SA6"),
("9S81CNJ0IZQFDED4","Component7","Type1",14,"RXKLOS1SA6"),
("KLJTKV7L055DQWRJ","Component10","Type2",6,"RXKLOS1SA6"),
("3OA3D32VISQZU8OD","Component13","Type1",9,"RXKLOS1SA6"),
("ZG65A1Z4O9HDLLV2","Component3","Type1",1,"U4Z467MB6A"),
("G2YN925SAF3K792K","Component6","Type2",60,"U4Z467MB6A"),
("EYZI0REC0EE4DHJR","Component9","Type1",3,"U4Z467MB6A"),
("CUV26P4VBPUBMSSY","Component12","Type2",8,"U4Z467MB6A"),
("HNGY3ZZESKPXMLRB","Component15","Type1",21,"U4Z467MB6A");

CREATE TABLE INVITED(
	MemberID	CHAR(8)	    NOT NULL,
	EventID	    CHAR(10)	NOT NULL,
    CONSTRAINT INVITEDPK    PRIMARY KEY(MemberID, EventID),
    CONSTRAINT MEMBERFK2    FOREIGN KEY(MemberID) REFERENCES MEMBER(ID) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT EVENTFK FOREIGN KEY(EventID) REFERENCES EVENT(EventID) 
    ON DELETE CASCADE ON UPDATE CASCADE 
);
CREATE TABLE DELIVERABLE(
	DName		VARCHAR(30)	NOT NULL,
	ProjectID	CHAR(8)		NOT NULL,
	TeamID	    CHAR(8)		NOT NULL,
	StartDate	TIMESTAMP   NOT NULL,
	EndDate	    TIMESTAMP   NOT NULL,
	CONSTRAINT DELIV_PK PRIMARY KEY(DName, ProjectID),
	CONSTRAINT ED_CHK CHECK (EndDate > StartDate),
	CONSTRAINT PROJECT_FK FOREIGN KEY(ProjectID) REFERENCES PROJECT(ID) 
	ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO DELIVERABLE VALUES
("Deliverable A-1","0CG9KJ16","81252958","2022-07-01","2022-10-01"),("Deliverable A-2","0CG9KJ16","81252958","2022-10-01","2023-01-01"),
("Deliverable A-3","0CG9KJ16","81252958","2023-01-01","2023-04-01"),("Deliverable A-4","0CG9KJ16","81252958","2023-04-01","2023-07-01"),
("Deliverable B-1","0CG9KJ16","89438180","2022-07-01","2022-10-01"),("Deliverable B-2","0CG9KJ16","89438180","2022-10-01","2023-01-01"),
("Deliverable B-3","0CG9KJ16","89438180","2023-01-01","2023-04-01"),("Deliverable B-4","0CG9KJ16","89438180","2023-04-01","2023-07-01"),
("Deliverable A-1","0KSVC1Y7","92132080","2022-08-15","2022-11-15"),("Deliverable A-2","0KSVC1Y7","92132080","2022-11-15","2023-02-15"),
("Deliverable A-3","0KSVC1Y7","92132080","2023-02-15","2023-05-15"),("Deliverable A-4","0KSVC1Y7","92132080","2023-05-15","2023-08-15"),
("Deliverable B-1","0KSVC1Y7","90903641","2022-08-15","2022-11-15"),("Deliverable B-2","0KSVC1Y7","90903641","2022-11-15","2023-02-15"),
("Deliverable B-3","0KSVC1Y7","90903641","2023-02-15","2023-05-15"),("Deliverable B-4","0KSVC1Y7","90903641","2023-05-15","2023-08-15"),
("Deliverable A-1","P5COFVGB","34365667","2022-09-04","2022-12-04"),("Deliverable A-2","P5COFVGB","34365667","2022-12-04","2023-03-04"),
("Deliverable A-3","P5COFVGB","34365667","2023-03-04","2023-06-04"),("Deliverable A-4","P5COFVGB","34365667","2023-06-04","2023-09-04"),
("Deliverable B-1","P5COFVGB","87381192","2022-09-04","2022-12-04"),("Deliverable B-2","P5COFVGB","87381192","2022-12-04","2023-03-04"),
("Deliverable B-3","P5COFVGB","87381192","2023-03-04","2023-06-04"),("Deliverable B-4","P5COFVGB","87381192","2023-06-04","2023-09-04");

CREATE TABLE PREREQUISITE(
	DepDname 	VARCHAR(30) 	NOT NULL,
	DepDPID		CHAR(8) 		NOT NULL,
	SrcDname	VARCHAR(30) 	NOT NULL,
	SrcDPID		CHAR(8) 		NOT NULL,
	CONSTRAINT PREREQ_PK PRIMARY KEY(DepDname, DepDPID, SrcDname, SrcDPID),
	CONSTRAINT DEPENDENT_FK FOREIGN KEY(DepDname, DepDPID) REFERENCES DELIVERABLE(DName, ProjectID)	
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT SOURCE_FK FOREIGN KEY(SrcDname, SrcDPID)
    REFERENCES DELIVERABLE(DName, ProjectID) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO PREREQUISITE VALUES
("Deliverable A-2","0CG9KJ16","Deliverable A-1","0CG9KJ16"),
("Deliverable A-3","0CG9KJ16","Deliverable A-2","0CG9KJ16"),
("Deliverable A-4","0CG9KJ16","Deliverable A-3","0CG9KJ16"),
("Deliverable B-2","0CG9KJ16","Deliverable B-1","0CG9KJ16"),
("Deliverable B-3","0CG9KJ16","Deliverable B-2","0CG9KJ16"),
("Deliverable B-4","0CG9KJ16","Deliverable B-3","0CG9KJ16"),
("Deliverable A-2","0KSVC1Y7","Deliverable A-1","0KSVC1Y7"),
("Deliverable A-3","0KSVC1Y7","Deliverable A-2","0KSVC1Y7"),
("Deliverable A-4","0KSVC1Y7","Deliverable A-3","0KSVC1Y7"),
("Deliverable B-2","0KSVC1Y7","Deliverable B-1","0KSVC1Y7"),
("Deliverable B-3","0KSVC1Y7","Deliverable B-2","0KSVC1Y7"),
("Deliverable B-4","0KSVC1Y7","Deliverable B-3","0KSVC1Y7"),
("Deliverable A-2","P5COFVGB","Deliverable A-1","P5COFVGB"),
("Deliverable A-3","P5COFVGB","Deliverable A-2","P5COFVGB"),
("Deliverable A-4","P5COFVGB","Deliverable A-3","P5COFVGB"),
("Deliverable B-2","P5COFVGB","Deliverable B-1","P5COFVGB"),
("Deliverable B-3","P5COFVGB","Deliverable B-2","P5COFVGB"),
("Deliverable B-4","P5COFVGB","Deliverable B-3","P5COFVGB");

CREATE TABLE REQUIRES (
    PartID CHAR(16) NOT NULL,
    Qty INT NOT NULL,
    Dname VARCHAR(30) NOT NULL,
    DprojectID CHAR(8) NOT NULL,
    CONSTRAINT REQUIRESPK PRIMARY KEY (PartID , Dname , DprojectID),
    CONSTRAINT COMP_FK FOREIGN KEY (Dname , DprojectID)
        REFERENCES DELIVERABLE (Dname , projectID),
    CONSTRAINT DELIVERABLEFK FOREIGN KEY (Dname , DprojectID)
        REFERENCES DELIVERABLE (Dname , projectID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT QTYCHK CHECK (Qty > 0)
);
INSERT INTO REQUIRES VALUES
("G2YN925SAF3K792K",20,"Deliverable A-1","0CG9KJ16"),
("CUV26P4VBPUBMSSY",3,"Deliverable A-3","0CG9KJ16"),
("HNGY3ZZESKPXMLRB",5,"Deliverable B-2","0CG9KJ16"),
("HNGY3ZZESKPXMLRB",7,"Deliverable B-4","0CG9KJ16"),
("3OA3D32VISQZU8OD",5,"Deliverable A-2","0KSVC1Y7"),
("9S81CNJ0IZQFDED4",4,"Deliverable A-4","0KSVC1Y7"),
("61I6YHRYDOSLZMWI",3,"Deliverable B-3","0KSVC1Y7"),
("B1OHI9GOC9WA7H7Y",6,"Deliverable A-2","P5COFVGB"),
("8W9PZMTR1YUP0WSY",4,"Deliverable A-3","P5COFVGB"),
("IPHH9GPJDZY3URGR",8,"Deliverable B-2","P5COFVGB"),
("C2E6FLKTIICE5BXF",1,"Deliverable B-3","P5COFVGB");

ALTER TABLE TEAM
ADD CONSTRAINT PROJECT_FK2 
FOREIGN KEY (ProjectID) References PROJECT(ID)
ON DELETE SET NULL ON UPDATE CASCADE;

INSERT INTO INVITED
SELECT M.ID, E.EventID
FROM MEMBER M, EVENT E
WHERE E.HostID = M.OrgID AND 
(M.Fname = "Liliana" AND M.Lname = "Brown");

SELECT M.Fname, M.Lname, E.EventName
FROM MEMBER AS M 
INNER JOIN INVITED AS I ON M.ID = I.MemberID
INNER JOIN EVENT AS E ON I.EventID = E.EventID
INNER JOIN ORGANIZATION AS O ON E.HostID = O.ID
WHERE O.ID = M.OrgID

