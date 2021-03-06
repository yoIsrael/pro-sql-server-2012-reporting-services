USE [Pro_SSRS]
GO
/****** Object:  StoredProcedure [dbo].[Emp_Svc_Cost_MVP]    Script Date: 11/26/2011 6:10:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[Emp_Svc_Cost_MVP] 
(
	@ServiceMonth  VARCHAR(20) 
	, @ServiceYear VARCHAR(20)
	, @BranchID INT = NULL
	, @EmployeeTblID INT = NULL
	, @ServicesLogCtgryID CHAR(5) = NULL
)
AS
SELECT 
	T.PatID
	, RTRIM(RTRIM(P.LastName) + ', ' + RTRIM(P.FirstName)) AS [Patient Name]
	, B.BranchName
	, E.EmployeeID
	, RTRIM(RTRIM(E.LastName) + ', ' + RTRIM(E.FirstName)) AS [Employee Name]
	, E.EmployeeClassID
	, SLC.Service AS [Service Type] 
	, SUM(CI.Cost) AS [Estimated Cost] 
	, COUNT(T.ServicesTblID) AS Visit_Count
	, D.Dscr AS Diagnosis, DATENAME(mm, T.ChargeServiceStartDate) AS [Month]
	, DATEPART(yy, T.ChargeServiceStartDate) AS [Year]
	, S.ServiceTypeID
	, T.ChargeServiceStartDate  
FROM
	Trx T 
	INNER JOIN Branch B ON T.Branchid = B.BranchID 
	INNER JOIN ChargeInfo CI ON T.ChargeInfoID = CI.ChargeInfoID 
	INNER JOIN Patient P ON T.PatID = P.PatID 
	INNER JOIN Services S ON T.ServicesTblID = S.ServicesTblID 	
	INNER JOIN ServicesLogCtgry SLC ON S.ServicesLogCtgryID = SLC.ServicesLogCtgryID 
	INNER JOIN Employee E ON CI.EmployeeTblID = E.EmployeeTblID 
	INNER JOIN Diag D ON CI.DiagTblID = D.DiagTblID  
WHERE
	(T.TrxTypeID = 1) 
	AND (ISNULL(B.BranchID,0) = ISNULL(@BranchID,ISNULL(B.BranchID,0))) 
	AND	(ISNULL(S.ServicesLogCtgryID,0) = ISNULL(@ServicesLogCtgryID, ISNULL(S.ServicesLogCtgryID,0)))  
	AND (ISNULL(E.EmployeeTblID,0) = ISNULL(@EmployeeTblID, ISNULL(E.EmployeeTblID,0))) 
	AND 
		1 = CASE WHEN CAST(DATEPART(YYYY,ChargeServiceStartDate) AS VARCHAR(20)) IN 
			(SELECT [PARAM] FROM fn_MVParam(@ServiceYear,',')) THEN 1
		ELSE 0
		END
	AND 
		1 = CASE WHEN CAST(DATEPART(MM,ChargeServiceStartDate) AS VARCHAR(20)) IN 
			(SELECT [PARAM] FROM fn_MVParam(@ServiceMonth,',' )) THEN 1
		ELSE 0
		END

GROUP BY
	SLC.Service 
	, D.Dscr
	, T.PatID
	, B.BranchName
	, RTRIM(RTRIM(P.LastName) + ', ' + RTRIM(P.FirstName))
	, RTRIM(RTRIM(E.LastName) + ', ' + RTRIM(E.FirstName))
	, E.EmployeeClassid
	, E.EmployeeID
	, DATENAME(mm, T.ChargeServiceStartDate)
	, DATEPART(yy, T.ChargeServiceStartDate)
	, S.ServiceTypeID
	, T.ChargeServiceStartDate 
ORDER BY 
	T.PatID




