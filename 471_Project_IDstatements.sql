-- Insertion Queries
-- New Member 
INSERT INTO MEMBER
VALUES (ID, FName, LName, Gender, Email, Phone, StartDate, OrgID) 

--New Admin 
INSERT INTO ADMIN 
VALUES (AID, Title)

--New Team 
INSERT INTO TEAM 
VALUES (ID, Name, Size, Specialization, LeadID, OrgID)

--New Organization 
INSERT INTO ORGANIZATION
VALUES (ID, Name, Desc, hrmNo, hrm_BID)

--New Component 
INSERT INTO COMPONENT
VALUES (PartID, Name, Qty, OrgID)

-- New Project 
INSERT INTO PROJECT 
VALUES (ProjectID, Name, StartDate, EndDate, Budget, OrgID)

--New Component to Deliverable 
INSERT INTO REQUIRES
VALUES (PartID, Qty, DName, DProjectID)

--New Deliverable 
INSERT INTO DELIVERABLE
VALUES (Name, ProjectID, StartDate, EndDate)

--New Requirement Deliverable 
INSERT INTO PREREQUESITE
VALUES (DependentDname, DepententProjectID, SourceDname, SourceProjectID) -- fix this shit

--New Event 
INSERT INTO EVENT
VALUES (EventID, Name, No_Attendees, Desc, StartDateTime, EndDateTime, HostID, PlannerID) 

--New instance of “USES” 
INSERT INTO USES
VALUES (BuildingID, RoomNo, StartTime, EndTime, EventID)

--New instance of “Belongs” 
INSERT INTO BELONGS
VALUES (MemberID, TeamID)

--New Building for Event 
INSERT INTO BUILDING
VALUES (ID, Name, BuildingNo, St_Name, City, Prov_State, country, Pcode) 

--New Room inside Building
INSERT INTO ROOM 
VALUES (BuildingID, RoomNo, Size, Capacity)

--New Invitation for Event 
INSERT INTO INVITATION
VALUES (MemberID, EventID) 


-- Update Queries

-- Remove Organization
DELETE FROM ORGANIZATION 
WHERE ID = orgID 

-- Remove Member
DELETE FROM MEMBER 
WHERE ID = memberID 

-- Remove Team
DELETE FROM TEAM 
WHERE ID = TeamID 

-- Remove Project
DELETE  FROM PROJECT 
WHERE ProjectID = projectID 

-- Remove Deliverable
DELETE FROM PROJECT
WHERE(
    Name = deliverableName 
    AND ProjectID = projectID
    AND TeamID = TeamID
)

-- Remove Event 
DELETE FROM EVENT 
WHERE EventID = EventID 

-- Remove Component
DELETE FROM COMPONENT 
WHERE PartID = partID 

-- Remove Room
DELETE FROM ROOM
WHERE(BuildingID = buildingID 
    AND RoomNo = roomNo
)

-- Remove Building
DELETE FROM BUILDING 
WHERE ID = buildingID

-- Remove Member from Team
DELETE FROM BELONGS 
WHERE (MemberID = memberID 
    AND TeamID = TeamID 
)

-- Revoke Invite to Event
DELETE FROM INVITATION 
WHERE(MemberID = memberID
    AND EventID = EventID 
)
-- Remove Component Requirment from Deliverable
DELETE FROM REQUIRES 
WHERE(PartID = partID
    AND Dname = Dname
    AND DProjectID = projectID)

-- Update Queries

-- Edit Event 
UPDATE EVENT 
SET Name = eventName, 
    Desc = eventDesc, 
    StartDateTime = eventDate,
    StartTime = eventStartTime
    EndTime = eventEndTime
WHERE EventID = EventID

-- Edit Project
UPDATE PROJECT 
SET Name = proejctName, 
    EndDate = projectEndDate, 
    Budget = projectBudget,
WHERE ProjectID = projectID

-- Manage Team Activities
UPDATE TEAM 
SET ProjectID = projectID 
WHERE Name = teamName