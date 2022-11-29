--Retrieval Queries
--Login: 
--Find the member whose id is a specific id
SELECT * 
FROM  MEMBER AS M 
WHERE M.id = Email;
--Home Page: using Email
--Find all organizations a member belongs to
SELECT * 
FROM ORGANIZATION AS O 
WHERE EXISTS(
    SELECT * 
    FROM MEMBERSHIP AS M
    WHERE(M.MemberID = Email
        AND M.orgID = O.orgID)
);
--Organization View: using Email and orgID
--Find organization info 
SELECT O.Name, O.Desc 
FROM ORGANIZATION AS O 
WHERE O.ID = orgID;
--Find a list of every member within the organization 
SELECT M.Fname, M.Lname, M.Gender, M.Email, M.Phone, M.StartDate 
FROM MEMBER AS M INNER JOIN ORGANIZATION AS O 
ON O.ID = M.OrgID 
WHERE EXISTS( 
SELECT M.OrgID 
FROM MEMBER AS M 
WHERE M.ID = Email AND OrgID = O.ID);
--Events View: 
--Find all events ran by this organization 
SELECT E.Title 
FROM EVENTS AS E 
WHERE E.host = OrgID
ORDER BY E.Start_Time DESC;
--Find all events ran by this organization that a specific member is registered for 
SELECT E.Title
FROM EVENT as E 
WHERE EXISTS(
    SELECT*
    FROM INVITED as I 
    WHERE(E.Title = I.Title
        AND Email = I.MemberID
        AND E.host = OrgID)
)
ORDER BY E.Start_Time DESC;
--Find all events ran by this org that are planned by a specific member
SELECT E.Title
FROM EVENT AS E 
WHERE EXISTS(
    SELECT * 
    FROM BELONGS AS B 
    WHERE(E.host = OrgID
        AND B.M_ID = Email
        AND B.TName = E.planner
    )
)
ORDER BY E.Start_Time DESC;
--Event View: eventTitle
--Find event info
SELECT E.Title,E.StartTime, E.endTime, E.Desc. E.Location,E. planner
FROM EVENT AS E 
WHERE E.Title = eventTitle

--Find event attendees 
SELECT Fname, Lname, Email. Phone#
FROM MEMBER AS M 
WHERE EXISTS(
    SELECT *
    FROM INVITED AS I 
    WHERE(I.Etitle = eventTitle
        AND I.Mname = Email
    )
);
--Projects View
--Find all projects that this member works on
SELECT P.Project_ID
FROM PROJECT AS P 
WHERE EXISTS(
    SELECT*
    FROM TEAM AS T
    JOIN BELONGS AS B ON(T.TName == B.Tname)
    WHERE(B.MemberID == Email
        AND B.ProjectID = P.ProjectID
        AND T.OrgName = OrgName)
);
--Find all projects created by this organization 
SELECT P.Proejct_ID 
FROM PROJECT AS P 
WHERE P.orgID = orgID ;
--Project View: using projectID
--Find project info 
SELECT P.Name,P.Desc
FROM PROJECT AS P 
WHERE(P.Project_ID = projectID);
--Find project teams
SELECT T.Name
FROM TEAM AS T 
WHERE(T.ProjectID = projectID);
--Find project deliverables 
SELECT D.Name 
FROM DELIVERABLE AS D 
WHERE(D.ProjectID = projectID);
--Deliverable View: deliverableName
--Find deliverable info 
SELECT D.Name, D.TName, D.StartDate, D.DueDate
FROM DELIVERABLE AS D 
WHERE(D.Name = deliverableName);
--Find deliverable dependancies
SELECT D.Name 
FROM DELIVERABLE AS D 
WHERE EXISTS(
    SELECT*
    FROM REQUIRES AS R 
    WHERE( R.DName = deliverableName
        AND R.ReqName = D.Name)
);
--Find deliverable components
SELECT U.Name, U.Desc, U.cost, U.qty 
FROM COMPONENT AS Co
NATURAL JOIN USES AS U 
WHERE U.Dname = deliverableName;
--Teams View: 
--Find all teams within this organization 
SELECT* 
FROM TEAM AS T 
WHERE T.Org_ID = orgID;
--Find all teams a specific member belongs to within this organization “My teams”
SELECT T.TName
FROM TEAM AS T 
WHERE EXISTS(
    SELECT*
    FROM BELONGS AS B 
    WHERE(
        B.MemberID = Email
        AND B.TeamID = T.TeamID
    )
);
--Find all teams this member manages within this organization 
SELECT T.TName
FROM TEAMS AS T 
WHERE T.Lead_ID = Email;
--Team View: using TeamName
--Find team info 
SELECT T.Name, T.Specialty
FROM TEAM AS T 
WHERE T.Name = TeamName
--Find all members of this team 
SELECT M.FName, M.LName, M.email, M.phone 
FROM MEMBER AS M 
WHERE EXISTS(
    SELECT * 
    FROM BELONGS AS B 
    WHERE(B.M_ID = M.M_ID
        AND B.TName = TeamName)
);
--Find all deliverables that this team works on
SELECT D.Name, D.TName, D.ProjectID
FROM DELIVERABLE AS D 
WHERE D.TName = TeamName;
--Inventory View: 
--Find a list of items within this organizations inventory
SELECT Co.Name, Co.Purchaseable, Co.Type, Co.Desc, Co.Price, Co.Location
FROM COMPONENT NATURAL JOIN INVENTORY AS Co 
WHERE Co.Org_ID = orgID;