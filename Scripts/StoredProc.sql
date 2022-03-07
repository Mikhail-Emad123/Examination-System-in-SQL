use [ExaminationSystem]
----------- intake--------------
go
create proc Manager.ADDIntake(@Number int,@Duration int,@startDate date,@EndDate date)
as 
begin

begin try
insert into [Manager].[Intake] values (@Number,@Duration,@startDate,@EndDate)
print 'Done Successfuly'
end try
begin catch
print 'Error'
end catch
end

---------------
go
create proc [Manager].UpdateIntake(@IntkNO int ,@Number int=null,
@startDate date=null,@EndDate date=null)
as 
begin
begin try
if @Number is null
select @Number= Number from [Manager].[Intake] where Number= @IntkNO;

if @startDate is null
select @startDate=[Start_date] from [Manager].[Intake] where Number= @IntkNO;

if @EndDate is null
select @EndDate=[End_date] from [Manager].[Intake] where Number =@IntkNO;

update [Manager].[Intake] set [Number]=@Number,[Start_date]=@startDate,
[End_date]=@EndDate where [Number]=@IntkNO;
print 'Done Successfuly'
end try
begin catch
print 'Error'
end catch
end
 ---------------
 
-- [Manager].UpdateIntake 7,@startDate='1-1-2021'

go
create proc [Manager].DeleteIntake(@IntkNO int)
as 
begin
begin try
delete from [Manager].[Intake]  where [Number]=@IntkNO;
print 'Done Successfuly'
end try
begin catch
print 'Error'
end catch
end
---------------
----------- Branch--------------
go
create proc Manager.ADDBranch(@ID varchar(20),@name varchar(200),@phone char(14),
@location varchar(200),@mangerSSN varchar(14))
as 
begin

begin try
insert into [Manager].[Branch] values (@ID,@name,@location,@phone,@mangerSSN);
print 'Done Successfuly'
end try
begin catch
print 'Error'
end catch
end

---------------
go
create proc [Manager].UpdateBranch(@BranchID varchar(20),@ID varchar(20)=null,
@name varchar(200)=null,@location varchar(200)=null,@phone char(14)=null,
@mangerSSN varchar(14)=null)
as 
begin
begin try
if @ID is null
select @ID= ID from [Manager].[Branch] where ID= @BranchID;

if @name is null
select @name= Name from [Manager].[Branch] where ID= @BranchID;

if @location is null
select @location= Location from [Manager].[Branch] where ID= @BranchID;

if @phone is null
select @phone= Phone from [Manager].[Branch] where ID= @BranchID;

if @mangerSSN is null
select @mangerSSN= [Manager_SSN] from [Manager].[Branch] where ID= @BranchID;

update [Manager].[Branch] set ID=@ID,[Name]=@name,[Location]=@location,
[Phone]=@phone,[Manager_SSN]=@mangerSSN where ID=@BranchID;
print 'Done Successfuly'
end try
begin catch
print 'Error'
end catch
end
 
------------------
go
create proc [Manager].DeleteBranch(@ID varchar(20))
as 
begin
begin try
delete from [Manager].[Branch]  where ID=@ID;
print 'Done Successfuly'
end try
begin catch
print 'Error'
end catch
end
--
  
  ----------- Track--------------
go
create proc Manager.ADDTrack(@ID varchar(20),@name varchar(200),@description char(200))
as 
begin

begin try
insert into [Manager].[Track] values (@ID,@name,@description);
print 'Done Successfuly'
end try
begin catch
print 'Error'
end catch
end

---------------
go
create proc [Manager].UpdateTrack(@TrackID varchar(20),@ID varchar(20)=null,
@name varchar(200)=null,@description char(200)=null)
as 
begin
begin try
if @ID is null
set @ID= @TrackID;

if @name is null
select @name= Name from [Manager].[Track] where ID= @TrackID;

if @description is null
select @description=[Description]  from [Manager].[Track] where ID= @TrackID;


update [Manager].[Track] set ID=@ID,[Name]=@name,[Description]=@description
 where ID=@TrackID;
print 'Done Successfuly'
end try
begin catch
print 'Error'
end catch
end
 
------------------
go
create proc [Manager].DeleteTrack(@ID varchar(20))
as 
begin
begin try
delete from [Manager].[Track] where ID=@ID;
print 'Done Successfuly'
end try
begin catch
print 'Error'
end catch
end

----------- Class--------------
go
create proc Manager.ADDClass(@ID int,@name varchar(100),@intakeNum int,
@branchID varchar(20),@trackID varchar(20))
as 
begin

begin try
insert into [Manager].[Class] values (@ID,@name,@intakeNum,@branchID,@trackID);
print 'Done Successfuly'
end try
begin catch
print 'Error'
end catch
end

---------------
go
create proc [Manager].UpdateClass(@ClassID int,@ID int=null,@name varchar(100)=null,
@intakeNum int=null,@branchID varchar(20)=null,@trackID varchar(20)=null)
as 
begin
begin try
if @ID is null
set @ID= @ClassID;

if @name is null
select @name= Name from [Manager].[Class] where ID= @ClassID;

if @intakeNum is null
select @intakeNum=[IntakeNumber]  from [Manager].[Class] where ID= @ClassID;

if @branchID is null
select @branchID=[Branch_ID]  from [Manager].[Class] where ID= @ClassID;

if @trackID is null
select @trackID= [Track_ID] from [Manager].[Class] where ID= @ClassID;

update [Manager].[Class] set ID=@ID,[Name]=@name,[IntakeNumber]=@intakeNum,
[Branch_ID]=@branchID,[Track_ID]=@trackID where ID=@ClassID;
print 'Done Successfuly'
end try
begin catch
print 'Error'
end catch
end
 
------------------

go
create proc [Manager].DeleteClass(@ID int)
as 
begin
begin try
delete from [Manager].[Class] where ID=@ID;
print 'Done Successfuly'
end try
begin catch
print 'Error'
end catch
end

-----------CLasS_CouRSe_INStructor--------------
go
create proc Manager.ADD_Class_Course_Instructor(@ID int,@classID int,
@courseCode varchar(40),@instructorSSN varchar(14))
as 
begin

begin try
insert into [Manager].[CLS_CRS_INS] values (@ID,@classID,@courseCode,@instructorSSN);
print 'Done Successfuly'
end try
begin catch
print 'Error'
end catch
end
---------------
go
create proc Manager.Update_Class_Course_Instructor(@CLS_CRS_INS_ID int,@ID int=null,
@classID int=null,@courseCode varchar(40)=null,@instructorSSN varchar(14)=null)
as 
begin
begin try
if @ID is null
set @ID= @CLS_CRS_INS_ID;

if @classID is null
select @classID= [Class_ID] from [Manager].[CLS_CRS_INS] where ID=@CLS_CRS_INS_ID ;

if @courseCode is null
select @courseCode=[Course_Code]  from [Manager].[CLS_CRS_INS] where ID=@CLS_CRS_INS_ID ;

if @instructorSSN is null
select @instructorSSN= [Instructor_SSN] from [Manager].[CLS_CRS_INS] where ID=@CLS_CRS_INS_ID ;


update [Manager].[CLS_CRS_INS] set ID=@ID,[Class_ID]=@classID,[Course_Code]=@courseCode,
[Instructor_SSN]=@instructorSSN where ID=@CLS_CRS_INS_ID;
print 'Done Successfuly'
end try
begin catch
print 'Error'
end catch
end
 
------------------
go
create proc [Manager].Delete_Class_Course_Instructor(@ID int)
as 
begin
begin try
delete from [Manager].[CLS_CRS_INS] where ID=@ID;
print 'Done Successfuly'
end try
begin catch
print 'Error'
end catch
end
-----------Course--------------
go
create proc Manager.ADDCourse(@Code varchar(40),@description char(200),@max int,@min int)
as 
begin

begin try
insert into [Manager].[Course] values (@Code,@description,@max,@min);
print 'Done Successfuly'
end try
begin catch
print 'Error'
end catch
end

---------------
go
create proc [Manager].UpdateCourse(@CourseCode varchar(40),@Code varchar(40)=null,
@description char(200)=null,@max int=null,@min int=null)
as 
begin
begin try
if @Code is null
set @Code= @CourseCode;

if @description is null
select @description=[Description]  from [Manager].[Track] where @Code= @CourseCode;

if @max is null
select @max= [Max_degree] from [Manager].[Course] where @Code= @CourseCode;

if @min is null
select @min= [Min_degree] from [Manager].[Course] where @Code= @CourseCode;

update [Manager].[Course] set [Code]=@Code,[Description]=@description,
[Max_degree]=@max,[Min_degree]=@min where Code=@CourseCode;
print 'Done Successfuly'
end try
begin catch
print 'Error'
end catch
end
 
------------------
go
create proc [Manager].DeleteCourse(@Code varchar(40))
as 
begin
begin try
delete from  [Manager].[Course] where Code=@Code;
print 'Done Successfuly'
end try
begin catch
print 'Error'
end catch
end
-----------Course for student--------------
