USE [Pro_SSRS]
GO
/****** Object:  StoredProcedure [dbo].[PatRecertListing_SelectReport]    Script Date: 1/22/2012 3:55:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[PatRecertListing_SelectReport]
(
	@BranchID INT = NULL
	, @DateFrom DATETIME = NULL
	, @DateTo DATETIME = NULL
)
AS

SELECT        
	p.PatID
	, p.LastName
	, p.FirstName
	, pcd.CertStart
	, pcd.CertEnd
	, dt.Dscr as [Document Type]
	, p.MedicareNum
	, p.MedicaidNum
	, pcd.DatePrinted
	, b.BranchName
	, pcd.DateSentToPhysician
	, pcd.DateRcvdFromPhysician
	, pcd.DocumentTypeID  
FROM         
	PatCertDates pcd (NOLOCK)
	INNER JOIN Admissions a (NOLOCK) ON pcd.PatProgramID = a.PatProgramID 
	INNER JOIN DocumentType dt (NOLOCK) ON pcd.documenttypeid = dt.documenttypeid 
	INNER JOIN Patient p (NOLOCK) ON a.PatID = p.PatID 
	INNER JOIN Branch b (NOLOCK) ON p.OrigBranchID = b.BranchID        
	--inner Join
	--PatPhysician on patcertdates.patprogramid = patphysician.patprogramid inner  Join
	--Physician on patphysician.physicianid = physician.physicianid
WHERE     
	(isnull(b.BranchID,0) = isnull(@BranchID,isnull(b.BranchID,0)))
	AND
--PatCertDates.CertEnd between @DateFrom and @DateTo and 
--Admissions.DischargeDate IS NULL And
		1 = 
			CASE 
				WHEN ( @DateFrom is  NULL) THEN 1
				WHEN ( @DateFrom is  NOT NULL)  AND CertEnd > @DateFrom THEN 1
			ELSE 0
			END 
	AND
		1 = 
			CASE
				WHEN ( @DateTo is  NULL) THEN 1
				WHEN ( @DateTo is  NOT NULL)  AND CertEnd < @DateTo THEN 1
			ELSE 0
			END


