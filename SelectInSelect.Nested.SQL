SELECT     
dbo.IssueTracker_Projects.ProjectName, 
ISNULL(AssignedUsers.DisplayName, 'none') AS AssignedDisplayName, 
ISNULL(OwnerUsers.DisplayName, 'none') AS OwnerDisplayName, 
ISNULL(Users.DisplayName, 'none') AS CreatorDisplayName, 
ISNULL(dbo.IssueTracker_ProjectCategories.CategoryName, 'none') AS CategoryName, 
dbo.IssueTracker_Issues.IssueId, 
dbo.IssueTracker_Issues.IssueTitle, 
YEAR(dbo.IssueTracker_Issues.DateCreated) AS Year, 
MONTH(dbo.IssueTracker_Issues.DateCreated) AS Month, 
ISNULL(dbo.IssueTracker_ProjectStatus.StatusName, 'none') AS StatusName,
C.Comment AS Comment, C.DateCreated, C.UserId, 

-- HERE !!!!!
(SELECT U.DisplayName FROM dbo.IssueTracker_Users AS U  WHERE U.UserId=C.UserID)
-- HERE !!!

FROM dbo.IssueTracker_Issues 

INNER JOIN      dbo.IssueTracker_Projects ON dbo.IssueTracker_Issues.ProjectId = dbo.IssueTracker_Projects.ProjectId 
LEFT OUTER JOIN dbo.IssueTracker_ProjectCategories ON dbo.IssueTracker_Projects.ProjectId = dbo.IssueTracker_ProjectCategories.ProjectId AND 
                dbo.IssueTracker_ProjectCategories.CategoryId = dbo.IssueTracker_Issues.IssueCategoryId 
LEFT OUTER JOIN dbo.IssueTracker_ProjectStatus ON dbo.IssueTracker_Projects.ProjectId = dbo.IssueTracker_ProjectStatus.ProjectId AND 
                dbo.IssueTracker_Issues.IssueStatusId = dbo.IssueTracker_ProjectStatus.StatusId 
LEFT OUTER JOIN
                dbo.IssueTracker_Users AS AssignedUsers ON AssignedUsers.UserId = dbo.IssueTracker_Issues.IssueAssignedId 
LEFT OUTER JOIN
                dbo.IssueTracker_Users AS OwnerUsers ON OwnerUsers.UserId = dbo.IssueTracker_Issues.IssueOwnerId 
LEFT OUTER JOIN
                dbo.IssueTracker_Users AS Users ON Users.UserId = dbo.IssueTracker_Issues.IssueCreatorId
LEFT OUTER JOIN
				dbo.IssueTracker_IssueComments AS C ON C.IssueId = dbo.IssueTracker_Issues.IssueId

WHERE          (dbo.IssueTracker_Projects.ProjectName  =  'Capital One (Production consultations)' AND  (YEAR(dbo.IssueTracker_Issues.DateCreated) = 2010 ) AND  (MONTH(dbo.IssueTracker_Issues.DateCreated) = 5 )
                 AND ((AssignedUsers.UserId IN (62, 68, 60, 13, 34, 10, 56, 70, 8, 4, 24, 1, 95)) OR
                (OwnerUsers.UserId IN (62, 68, 60, 13, 34, 10, 56, 70, 8, 4, 24, 1, 95)) OR
                (Users.UserId IN (62, 68, 60, 13, 34, 10, 56, 70, 8, 4, 24, 1, 95))) AND dbo.IssueTracker_Projects.ProjectId <> 64 AND dbo.IssueTracker_Projects.ProjectId <> 65 )
ORDER BY dbo.IssueTracker_Projects.ProjectName, ISNULL(AssignedUsers.DisplayName, 'none'), ISNULL(OwnerUsers.DisplayName, 'none'), 
                 ISNULL(Users.DisplayName, 'none'), ISNULL(dbo.IssueTracker_ProjectCategories.CategoryName, 'none')