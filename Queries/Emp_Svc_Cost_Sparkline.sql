USE [Pro_SSRS]
GO
/****** Object:  StoredProcedure [dbo].[Emp_Svc_Cost_Sparkline]    Script Date: 8/15/2011 7:20:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Emp_Svc_Cost_Sparkline]   
(
	@ServiceYear INT = NULL
)
AS 

SELECT 
	T.ChargeServiceStartDate 
	, DATENAME(mm, T.ChargeServiceStartDate) AS [Month]
	, DATEPART(yy, T.ChargeServiceStartDate) AS [Year]   
	, SUM(CI.Cost) AS [Estimated Cost]
	, COUNT(T.ServicesTblID) AS Visit_Count
FROM
	(SELECT ChargeServiceStartDate, Branchid, PatID
	, ServicesTblID, ChargeInfoID  
	FROM Trx
	WHERE TrxTypeID = 1 
	AND ChargeServiceStartDate BETWEEN '9/1/2009' AND '12/31/2009') AS T
	INNER JOIN Branch AS B ON T.Branchid = B.BranchID 
	INNER JOIN ChargeInfo AS CI ON T.ChargeInfoID = CI.ChargeInfoID 
	INNER JOIN Patient AS P ON T.PatID = P.PatID 
	INNER JOIN Services AS S ON T.ServicesTblID = S.ServicesTblID 
	INNER JOIN ServicesLogCtgry AS SLC ON S.ServicesLogCtgryID = 
	SLC.ServicesLogCtgryID 
	INNER JOIN Employee AS E ON CI.EmployeeTblID = E.EmployeeTblID 
	INNER JOIN Diag AS D ON CI.DiagTblID = D.DiagTblID  
WHERE
	--Case to determine if Year and Month was passed in
	1 = CASE
		WHEN (@ServiceYear IS NULL) THEN 1
		WHEN (@ServiceYear IS NOT NULL)  
		AND @ServiceYear = CAST(DATEPART(yy, ChargeServiceStartDate) AS INT)
		THEN 1 ELSE 0 END
GROUP BY
	T.ChargeServiceStartDate 
	, DATENAME(mm, T.ChargeServiceStartDate)
	, DATEPART(yy, T.ChargeServiceStartDate)
ORDER BY 
     T.ChargeServiceStartDate
