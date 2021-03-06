USE [Pro_SSRS]
GO
/****** Object:  StoredProcedure [dbo].[Get_Visit_Data_GeoSpatial]    Script Date: 4/29/2012 6:03:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[Get_Visit_Data_GeoSpatial]   
/*===================================================================
Author:	Brian K. McDonald, MCDBA, MCSD
Date:	4/29/2012

	This stored procedure just generates sample data to be used to 
	display year over year or month over month data as well as
	geospatial details.
===================================================================*/
AS
SET NOCOUNT ON

DECLARE @Indicator TABLE 
(
	ID TINYINT IDENTITY(1,1)
	, [BranchID] TINYINT
	, [BranchName] VARCHAR(100) NULL
	, [BranchLocation] GEOGRAPHY NULL
	, [Month_Number] TINYINT
	, [Month_Name]	VARCHAR(15)
	, [Year] CHAR(4)
	, [Visit_Count] INT
)

--branchID 1
INSERT INTO @Indicator ([BranchID], [Month_Number], [Month_Name], [Year], [Visit_Count])
VALUES 
	(1, 1, 'January', '2007', 1534)
	, (1, 2, 'February', '2007', 574)
	, (1, 3, 'March', '2007', 3480)
	, (1, 4, 'April', '2007', 3480)
	, (1, 5, 'May', '2007', 3145)
	, (1, 6, 'June', '2007', 3677)
	, (1, 7, 'July', '2007', 136)
	, (1, 8, 'August', '2007', 2346)
	, (1, 9, 'September', '2007', 6321)
	, (1, 10, 'October', '2007', 5354)
	, (1, 11, 'November', '2007', 5354)
	, (1, 12, 'December', '2007', 343)
	, (1, 1, 'January', '2008', 3984)
	, (1, 2, 'February', '2008', 4633)
	, (1, 3, 'March', '2008', 2724)
	, (1, 4, 'April', '2008', 4522)
	, (1, 5, 'May', '2008', 7284)
	, (1, 6, 'June', '2008', 5654)
	, (1, 7, 'July', '2008', 1521)
	, (1, 8, 'August', '2008', 9865)
	, (1, 9, 'September', '2008',4835)
	, (1, 10, 'October', '2008', 4744)
	, (1, 11, 'November', '2008', 4594)
	, (1, 12, 'December', '2008', 2351)
	, (1, 1, 'January', '2009', 1234)
	, (1, 2, 'February', '2009', 534)
	, (1, 3, 'March', '2009', 2500)
	, (1, 4, 'April', '2009', 3002)
	, (1, 5, 'May', '2009', 3103)
	, (1, 6, 'June', '2009', 3307)
	, (1, 7, 'July', '2009', 2806)
	, (1, 8, 'August', '2009', 2456)
	, (1, 9, 'September', '2009', 4321)
	, (1, 10, 'October', '2009', 6354)
	, (1, 11, 'November', '2009', 6542)
	, (1, 12, 'December', '2009', 1343)
	, (1, 1, 'January', '2010', 4984)
	, (1, 2, 'February', '2010', 3633)
	, (1, 3, 'March', '2010', 2724)
	, (1, 4, 'April', '2010', 6522)
	, (1, 5, 'May', '2010', 1284)
	, (1, 6, 'June', '2010', 1654)
	, (1, 7, 'July', '2010', 4521)
	, (1, 8, 'August', '2010', 4865)
	, (1, 9, 'September', '2010',1835)
	, (1, 10, 'October', '2010', 4877)
	, (1, 11, 'November', '2010', 8794)
	, (1, 12, 'December', '2010', 7451)

--branchID 2
INSERT INTO @Indicator ([BranchID], [Month_Number], [Month_Name], [Year], [Visit_Count])
VALUES 
	(2, 1, 'January', '2007', 123)
	, (2, 2, 'February', '2007', 333)
	, (2, 3, 'March', '2007', 343)
	, (2, 4, 'April', '2007', 543)
	, (2, 5, 'May', '2007', 321)
	, (2, 6, 'June', '2007', 654)
	, (2, 7, 'July', '2007', 612)
	, (2, 8, 'August', '2007', 864)
	, (2, 9, 'September', '2007', 121)
	, (2, 10, 'October', '2007', 543)
	, (2, 11, 'November', '2007', 989)
	, (2, 12, 'December', '2007', 342)
	, (2, 1, 'January', '2008', 333)
	, (2, 2, 'February', '2008', 444)
	, (2, 3, 'March', '2008', 555)
	, (2, 4, 'April', '2008', 333)
	, (2, 5, 'May', '2008', 654)
	, (2, 6, 'June', '2008', 777)
	, (2, 7, 'July', '2008', 888)
	, (2, 8, 'August', '2008', 433)
	, (2, 9, 'September', '2008', 233)
	, (2, 10, 'October', '2008', 444)
	, (2, 11, 'November', '2008', 594)
	, (2, 12, 'December', '2008', 351)
	, (2, 1, 'January', '2009', 234)
	, (2, 2, 'February', '2009', 534)
	, (2, 3, 'March', '2009', 500)
	, (2, 4, 'April', '2009', 302)
	, (2, 5, 'May', '2009', 103)
	, (2, 6, 'June', '2009', 307)
	, (2, 7, 'July', '2009', 206)
	, (2, 8, 'August', '2009', 456)
	, (2, 9, 'September', '2009', 421)
	, (2, 10, 'October', '2009', 654)
	, (2, 11, 'November', '2009', 542)
	, (2, 12, 'December', '2009', 343)
	, (2, 1, 'January', '2010', 984)
	, (2, 2, 'February', '2010', 633)
	, (2, 3, 'March', '2010', 224)
	, (2, 4, 'April', '2010', 622)
	, (2, 5, 'May', '2010', 184)
	, (2, 6, 'June', '2010', 164)
	, (2, 7, 'July', '2010', 421)
	, (2, 8, 'August', '2010', 465)
	, (2, 9, 'September', '2010', 135)
	, (2, 10, 'October', '2010', 477)
	, (2, 11, 'November', '2010', 794)
	, (2, 12, 'December', '2010', 451)

--branchID 3
INSERT INTO @Indicator ([BranchID], [Month_Number], [Month_Name], [Year], [Visit_Count])
VALUES 
	(3, 1, 'January', '2007', 154)
	, (3, 2, 'February', '2007', 174)
	, (3, 3, 'March', '2007', 480)
	, (3, 4, 'April', '2007', 480)
	, (3, 5, 'May', '2007', 345)
	, (3, 6, 'June', '2007', 377)
	, (3, 7, 'July', '2007', 186)
	, (3, 8, 'August', '2007', 246)
	, (3, 9, 'September', '2007', 631)
	, (3, 10, 'October', '2007', 535)
	, (3, 11, 'November', '2007', 134)
	, (3, 12, 'December', '2007', 383)
	, (3, 1, 'January', '2008', 3984)
	, (3, 2, 'February', '2008', 4633)
	, (3, 3, 'March', '2008', 284)
	, (3, 4, 'April', '2008', 422)
	, (3, 5, 'May', '2008', 724)
	, (3, 6, 'June', '2008', 554)
	, (3, 7, 'July', '2008', 121)
	, (3, 8, 'August', '2008', 985)
	, (3, 9, 'September', '2008',485)
	, (3, 10, 'October', '2008', 474)
	, (3, 11, 'November', '2008', 454)
	, (3, 12, 'December', '2008', 231)
	, (3, 1, 'January', '2009', 124)
	, (3, 2, 'February', '2009', 534)
	, (3, 3, 'March', '2009', 200)
	, (3, 4, 'April', '2009', 302)
	, (3, 5, 'May', '2009', 310)
	, (3, 6, 'June', '2009', 337)
	, (3, 7, 'July', '2009', 280)
	, (3, 8, 'August', '2009', 245)
	, (3, 9, 'September', '2009', 432)
	, (3, 10, 'October', '2009', 634)
	, (3, 11, 'November', '2009', 652)
	, (3, 12, 'December', '2009', 134)
	, (3, 1, 'January', '2010', 494)
	, (3, 2, 'February', '2010', 363)
	, (3, 3, 'March', '2010', 274)
	, (3, 4, 'April', '2010', 622)
	, (3, 5, 'May', '2010', 128)
	, (3, 6, 'June', '2010', 164)
	, (3, 7, 'July', '2010', 451)
	, (3, 8, 'August', '2010', 486)
	, (3, 9, 'September', '2010', 135)
	, (3, 10, 'October', '2010', 477)
	, (3, 11, 'November', '2010', 874)
	, (3, 12, 'December', '2010', 741)

SELECT 
	b.[BranchName]
	, b.[BranchLocation]
	, i1.[Month_Number]
	, i1.[Month_Name]
	, i1.[Year]
	, i1.[Visit_Count]
	, ISNULL(i2.[Visit_Count], 0) AS Prior_Month_Visit_Count 
	, ISNULL(i1.[Visit_Count] - i2.[Visit_Count], 0) AS Diff
FROM 
	@Indicator i1
	LEFT JOIN @Indicator i2 ON i2.ID = i1.ID - 1 AND i1.BranchID = i2.BranchID
	INNER JOIN Branch b (NOLOCK) ON b.BranchID = i1.BranchID
ORDER BY
	i1.[Year]
	, i1.[Month_Number]
	, b.[BranchID]

