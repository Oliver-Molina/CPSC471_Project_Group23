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
("X1G3YNXY","Building1","1","10th Avenue","Calgary","Alberta","Canada"),
("N1XDYYPP","Building 2","2","16 Street","Vancouver","British Columbia","Canada"),
("B4LV9603","Building 3","3","Maple Street","Ottawa","Ontario","Canada"),
("B8YNUYUD","Building 4","4","16th Avenue","Calgary","Alberta","Canada"),
("78RXZ4HC","Building 5","5","Hadron Blvd","Edmonton","Alberta","Canada"),
("FUZSPR9Q","Building 6","6","Example St","Windsor","Ontario","Canada"),
("WP16CQ5D","Building 7","7","Placeholder St","Toronto","Ontario","Canada"),
("K97OED44","Building 8","8","Generic Street","Generic City","Province","Country"),
("U8MMDHVV","Building 9","9","Study Street","Generic City","Province","Country"),
("YU35YPZP","Building 10","10","Euneva Street","Generic City","Province","Country"),
("AKQ17BG8","Building1","90","Palm Parkway","Cupertino","California","USA"),
("4MC5BQGD","Building 2","72","10th Avenue","Calgary","Alberta","Canada"),
("748JHSTL","Building 3","43","Placeholder St","Generic City","Province","Country"),
("OJ972RU7","Building 4","56","Generic Street","Generic City","Province","Country"),
("WDDOXHOM","Building 5","1","Infinite Loop","Cupertino","California","USA"),
("KFVTPL1F","Building 6","51245","Main Street","Generic City","Province","Country"),
("1KXXBAW8","Building 7","12341","Maple Street","Ottawa","Ontario","Canada"),
("F6HTJ9Q2","Building 8","12031","Seasame Street","Generic City","Province","Country"),
("9WRYZ797","Building 9","8023","Hadron Blvd","Generic City","Province","Country"),
("XKXDLD51","Building 10","42069","Neat Street","Los Angeles","California","USA");
CREATE TABLE ROOM(
	RoomNo		VARCHAR(8) NOT NULL,
	Size		CHAR(1) NOT NULL,
	EstCapacity	INT NOT NULL,
    BuildingID	CHAR(8) NOT NULL,
	PRIMARY KEY(RoomNO, BuildingID),
    CONSTRAINT SIZECHK CHECK(
    (Size = "L" AND EstCapacity > 25)OR 
    (SIZE = "M" AND 25>=EstCapacity>=15)OR 
    (SIZE = "S" AND EstCapacity < 15)
    )
);
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
CREATE TABLE ADMIN(
	Position   VARCHAR(15)	NOT NULL,
	ID		   CHAR(8)		NOT NULL,
	PRIMARY KEY(ID),
	CONSTRAINT ID_FK FOREIGN KEY(ID) REFERENCES MEMBER(ID)
	ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE ORGANIZATION(
	ID			CHAR(10)		NOT NULL,
	OrgName		VARCHAR(30)		NOT NULL,
	HeadID		CHAR(8)			NOT NULL,
	Description	VARCHAR(500),
	HRM_No		VARCHAR(8),
	HRM_BID		CHAR(8),
PRIMARY KEY(ID)
);
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

CREATE TABLE TEAM(
	ID		    CHAR(8)         NOT NULL,
	TName		VARCHAR(30)	    NOT NULL,
	Size 		INT		        NOT NULL	DEFAULT 1,
	Specialization	VARCHAR(30)	NOT NULL 	DEFAULT "None",
	LeadID		CHAR(8),    
	OrgID		CHAR(10)	    NOT NULL,
	ProjectID	CHAR(8),	    
	PRIMARY KEY(ID),
	CONSTRAINT NAME_CHK CHECK (TName != " "),
	CONSTRAINT SIZE_CHK CHECK (Size > 0)
    );
ALTER TABLE TEAM
Add CONSTRAINT LEAD_FK FOREIGN KEY(LeadID) REFERENCES ADMIN(ID)
ON DELETE SET NULL 	ON UPDATE CASCADE,
ADD CONSTRAINT ORG_FK FOREIGN KEY(OrgID) REFERENCES ORGANIZATION(ID)
ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TABLE EVENT(
	EventID		        CHAR(10)	NOT NULL,
	EventName			CHAR(30)    NOT NULL,
	No_Attendees		INT		    NOT NULL DEFAULT 1,
	Description			CHAR(150),
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
CREATE TABLE USES(
	RoomNo	    CHAR(8)		NOT NULL,
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
CREATE TABLE BELONGS(
	Member_ID	CHAR(8) 	NOT NULL,
	Team_ID		CHAR(8)		NOT NULL,
	CONSTRAINT TEAM_MEMBER_PK
	PRIMARY KEY(Member_ID, Team_ID),
	CONSTRAINT MEMBER_FK
	FOREIGN KEY(Member_ID) REFERENCES MEMBER(ID) ON DELETE 	CASCADE ON UPDATE CASCADE,
	CONSTRAINT TEAM_ID_FK FOREIGN KEY(Team_ID) REFERENCES TEAM(ID) ON DELETE
	NO ACTION ON UPDATE CASCADE
);
CREATE TABLE COMPONENT(
	PartID		CHAR(16)	NOT NULL,
	CName		VARCHAR(30),		
	CType		VARCHAR(30),	
	Qty			INT		NOT NULL DEFAULT 1,
	OrgID		CHAR(10)		NOT NULL,	
	PRIMARY KEY(PartID),
	CONSTRAINT QTY_CHK CHECK(Qty > 0),
	CONSTRAINT ORG_FK3 FOREIGN KEY(OrgID) REFERENCES ORGANIZATION(ID)
	ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE INVITED(
	MemberID	CHAR(8)	    NOT NULL,
    InviteDate  TIMESTAMP   NOT NULL,
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
ALTER TABLE TEAM
ADD CONSTRAINT PROJECT_FK2 
FOREIGN KEY (ProjectID) References PROJECT(ID)
ON DELETE SET NULL ON UPDATE CASCADE;

INSERT INTO MEMBER
VALUES
("73997687","Samantha","Hutchins","Female","samhutch391@gmail.com",'2020-09-29',"RXKLOS1SA6"),
("91815665","Nick","Fury","Male","nick.fury7450@shield.org",'2022-09-30',"RXKLOS1SA6"),
("84415100","Catherine","Myres","Female","catherine.myres@gmail.com",'2021-03-18',"U4Z467MB6A"),
("42145777", "John", "Doe","Male","john.doe102@gmail.com",'2020-09-22',"EFT3IW4NWF"),
("47902909","Terry","Crews","Male","tcrew101@gmail.com",'2021-04-07',"U4Z467MB6A"),
("58147624","Sarah","Anderson","Female","sarah.jackson@gmail.com",'2021-04-21',"EFT3IW4NWF"),
("2868180","Megan","Holmes","Female","megan.holmes@gmail.com",'2021-04-15',"EFT3IW4NWF"),
("52676143","Danielle","Bianchi","Female","danibianchi2001@gmail.com",'2021-04-13',"U4Z467MB6A"),
("67912100","Steve","Rogers","Male","steve.rogers@avengers.net",'2021-03-17',"U4Z467MB6A"),
("69118391","Olivia","Matthews","Female","olivia.mathews@gmail.com",'2022-09-21',"RXKLOS1SA6"),
("76679032","Florence","Nightingale","Female","fnightingale@gmail.com",'2021-04-29',"RXKLOS1SA6"),
("96406803","Constance","Schultz","Male","constance.schultz@gmail.com",'2021-03-15',"EFT3IW4NWF"),
("32114292","Terrence","Hayes","Male","terry.hayes@gmail.com",'2021-04-27',"EFT3IW4NWF"),
("42826789","Pearson","Reyes","Male","pearson.reyes@gmail.com",'2022-10-03',"U4Z467MB6A"),
("96718013","Evelyn","Prescott","Female","evelyn.prescott@gmai.com",'2022-10-13',"U4Z467MB6A"),
("58606756","Robert","Drysdale","Male","robert.drysadle@gmail.com",'2022-10-06',"U4Z467MB6A"),
("94558524","Liliana","Brown","Female","liliana.brown@gmail.com",'2020-09-25',"EFT3IW4NWF"),
("43414582","Eleni","Nikolaou","Female","eleni.niko@gmail.com",'2022-10-11',"EFT3IW4NWF"),
("91451497","Maria","Sabella","Female","msabella@gmail.com",'2021-04-28',"EFT3IW4NWF"),
("36313608","June","Walker","Female","junewalker2029@gmail.com",'2022-10-10',"RXKLOS1SA6"),
("66357212","Virginia","Habig","Female","virginia.habig@hotmail.com",'2020-09-28',"RXKLOS1SA6"),
("98509061","Matteo","Bianchi","Male","mattbianchi@gmail.com",'2021-03-30',"RXKLOS1SA6"),
("50210024","Samus","Aran","Female","samus.aran@gmail.com",'2022-10-04',"RXKLOS1SA6"),
("14144507","Samuel","Jackson","Male","sjackson1948@gmail.com",'2021-04-21',"U4Z467MB6A"),
("44937185","Lee","Padgett","Male","lpadgett@hotmail.com",'2021-03-31',"EFT3IW4NWF"),
("49123455","Lucy","Jackson","Female","lucy.jackson@gmail.com",'2021-03-30',"U4Z467MB6A"),
("89212423","Tobias","Eaton","Male","tobias.eaton@gmail.com",'2021-03-22',"U4Z467MB6A"),
("66839421","Jean-Pierre","Desbois","Male","jpdesbois@gmail.com",'2021-03-31',"RXKLOS1SA6"),
("92028456","Rose","Potter","Female","rose.potter@hotmail.com",'2021-03-30',"EFT3IW4NWF"),
("92027156","Brianna","Jansen","Female","briejansen@gmail.com",'2021-04-02',"EFT3IW4NWF"),
("38234182","Heinz","Doofinschmirtz","Male","henizd@gmail.com",'2021-04-18',"RXKLOS1SA6");





