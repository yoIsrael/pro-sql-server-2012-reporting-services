USE [Pro_SSRS]
GO
/****** Object:  StoredProcedure [dbo].[Emp_Svc_Cost]    Script Date: 8/9/2011 9:50:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sys.sysobjects WHERE name = 'Emp_Svc_Cost_Data_Bar')
	DROP PROCEDURE Emp_Svc_Cost_Data_Bar
GO

CREATE PROCEDURE [dbo].[Emp_Svc_Cost_Data_Bar]
(
	@ServiceMonth INT = NULL
)
AS 
SELECT TOP 10     
	P.State
	, ST.StateName
	, COUNT(T.ServicesTblID) AS Visit_Count_By_State
FROM
	Trx AS T
	INNER JOIN Branch AS B ON T.Branchid = B.BranchID 
	INNER JOIN ChargeInfo AS CI ON T.ChargeInfoID = CI.ChargeInfoID 
	INNER JOIN Patient AS P ON T.PatID = P.PatID 
	INNER JOIN Services AS S ON T.ServicesTblID = S.ServicesTblID 
	INNER JOIN ServicesLogCtgry AS SLC ON S.ServicesLogCtgryID = 
	SLC.ServicesLogCtgryID 
	INNER JOIN Employee AS E ON CI.EmployeeTblID = E.EmployeeTblID 
	INNER JOIN Diag AS D ON CI.DiagTblID = D.DiagTblID  
	INNER JOIN States AS ST ON P.State = ST.StateAbbr
WHERE
    1 = CASE
        WHEN (@ServiceMonth IS NULL)  THEN 1     
        WHEN (@ServiceMonth IS NOT NULL)  
        AND @ServiceMonth = CAST(DATEPART(mm, ChargeServiceStartDate) AS INT)
		THEN 1 ELSE 0 END
GROUP BY
	P.State
	, ST.StateName
ORDER BY 
	COUNT(T.ServicesTblID) DESC
GO

EXEC [Emp_Svc_Cost_Data_Bar] @ServiceMonth = 10

