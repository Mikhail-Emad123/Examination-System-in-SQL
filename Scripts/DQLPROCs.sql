go
use [ExaminationSystem]
-------
go
CREATE SEQUENCE QuestNo_IN_Exam
  START WITH 1
  INCREMENT BY 1
  MAXVALUE 3
  ;
-------- check if instructor teach this course
go
Create function CheckInstWithCourse(@INSTSSN char(14),@CourseCode varchar(40),@ClassID int)
returns bit
begin
	declare @Res bit
	declare @SelectRes table([Instructor_SSN] char(14),CorseCode varchar(40),ClassID int);
	insert into @SelectRes Select * from [Manager].[CLS_CRS_INS] where [Instructor_SSN]=@INSTSSN and
	[Course_Code]=@CourseCode and [Class_ID]=@ClassID
	if @@ROWCOUNT>0
	set @res=1
	else
	set @Res=0
	return @Res
	
end
--------- return course max degree
go
Create function GetCourseDegree(@CourseCode varchar(40))
returns int
begin
declare @TotalDegree int
select  @TotalDegree =[Max_degree] from [Manager].[Course] where [Code]=@CourseCode
return @TotalDegree
end

go
------- check if total exams degree don't exceed course max degree
create function GetExamsTotalDegree(@CourseCode varchar(40))
returns int
begin
declare @TotalDegree int
select  @TotalDegree =sum([Total_degree]) from [Instructor].[Exame] where [CourseCode]=@CourseCode
if @TotalDegree is null
set @TotalDegree=0
return @TotalDegree
end

go
------------ 
create trigger TrigCheckForInstrWithCourse on [Instructor].[Exame]
	instead of insert
	as
	begin
	declare @FuncResult bit
	declare @InstructorSSN char(14)
	declare @ClassID int
	declare @CourseCode varchar(40)
	declare @ExamDegree int
	declare @TotalDegree int

	select @InstructorSSN = InstructorSSN from inserted
	select @CourseCode = CourseCode from inserted
	select @ClassID = ClassID from inserted
	select @ExamDegree = [Total_degree] from inserted

	set @TotalDegree=  dbo.GetExamsTotalDegree(@CourseCode)+@ExamDegree
	set @FuncResult=dbo.CheckInstWithCourse(@InstructorSSN,@CourseCode,@ClassID)
	--print @FuncResult
	if @FuncResult=1
	if @TotalDegree<=dbo.GetCourseDegree(@CourseCode)
	begin
	insert into Exame select [ID],[Type],[Total_degree],[Allowance_Option],
	 [Exame_date],[InstructorSSN],[ClassID],[CourseCode],[Start-time],[End-time] from inserted
	
	end
	else print 'Exame Degree Exceed Total Course Degree'
	else
	print 'Data Error Istructor or Course incorect'
	end

-----------------------------------------------------------------------------
--------------- Check if Student In aCourse -------
go
create function CheckStudentInCourse(@studentSSN char(14),@CourseCode varchar(40))
	returns bit
	as
	begin
	Declare @Res bit
	Declare @StdInCourse varchar(14)
	select @StdInCourse = [student_SSN] from [Manager].[Course_For_Student] where
	[Course_Code]=@CourseCode
	if @@ROWCOUNT>0
	 set @Res=1
	else 
	 set @Res=0
	return @Res
end

------------------- Add Exame to student in specific Course-------------
go
create proc Instructor.AddStudentToExam(@INSTSSN char(14),@CourseCode varchar(40),
@studentSSN char(14),@ClassID int,@ExamID varchar(20)) -- [Instructor].[Student_Exame_in_Course]
as
begin
	declare @IsINstrTeachCours bit
	  if dbo.CheckInstWithCourse(@INSTSSN,@CourseCode,@ClassID)=1
	    if dbo.CheckStudentInCourse(@studentSSN,@CourseCode)=1
	    begin
	    insert into [Instructor].[Student_Exame_in_Course] values(@CourseCode,@studentSSN,@ExamID,null)
	    print 'Data Inserted'
		end
		else
		print 'This student is not register to this course'
	 else
	 print 'You have not permission to add this exame to this student'
end


--Instructor.AddStudentToExam '1992','C#_CS_21','1999',1,'C#Exame1'
------------------
--go
--create proc AddExamQuestions(@SelectWay char(1),@ExamID varchar(20),
--@ExamDegree int,@QuestionNum int)
--as
--begin
--if @SelectWay='R'
--begin
--end
--end
-------------Get Student Exames-------------------------------------
go
create function GetStudentExams(@studentSSN char(14))
returns @AllExams table(CourseName varchar(100),ExameID varchar(20),ExamDat date)
as
begin
	insert into @AllExams select C.Name as 'Course Name', E.[ID] as ExamID,E.Exame_date
	from [Instructor].[Exame] as E
	join [Manager].[Course] as C on E.[CourseCode] =C.Code
	join [Instructor].[Student_Exame_in_Course] as SEC on C.Code=SEC.[Course_code]
	where SEC.[Student_SSN]=@studentSSN 
	--and E.Exame_date=CAST( GETDATE() as date);
	
return
end
--select * from dbo.GetStudentExams('1999')
---------------------------

  
  --------------- check if question belong to Course-----------
go
Create Function CheckQuestWithCourse(@QuestID varchar(20),@CourseCode varchar(40))
returns int
begin
	Declare @Result int
	--Declare @SelectResult table (Question_ID varchar(20),CourseCode varchar(40))
	SELECT @Result= [Degree]  from [Instructor].[Question]
	where [ID]=@QuestID and [Course_Code]=@CourseCode
	return @Result
end
--------------------------------check Exame with Course----------------------
go
Create Function checkExameWithCourse(@ExamID varchar(20),@CourseCode varchar(40),@InstrSSN char(14))
returns bit
begin
	Declare @Result bit
	Declare @SelectResult table (ExamID varchar(20),CourseCode varchar(40))
	insert into @SelectResult SELECT [ID],[CourseCode]  from [Instructor].[Exame]
	where [ID]=@ExamID and [CourseCode]=@CourseCode and [InstructorSSN]=@InstrSSN

	if @@ROWCOUNT>0
		set @Result=1
	else
		set @Result=0

	return @Result
end
--------------------------Set Max Value To Squence---------------

------- check if total exams degree don't exceed course max degree
create function GetQuestionsTotalDegreeInExam(@ExamID varchar(20))
returns int
begin
declare @TotalDegree int
--Declare @ExamDegree int
--select @ExamDegree = [Total_degree] from [Instructor].[Exame] where [ID]=@ExamID
select  @TotalDegree =sum([Quest_degree]) from [Instructor].[Question_Exam] where
[Exam_id]=@ExamID
if @TotalDegree is null
set @TotalDegree=0
return @TotalDegree
end
------------------------CheckQuestWithCourse-----------

go
create proc SetQuestionToExam(@InstrSSN char(14),@CourseCode varchar(40),
@ExamID varchar(20),@QuestID varchar(20),@ClassID int)
as
begin
 declare @Degree int;
 declare @QuestNUMInExam int;
   if dbo.checkExameWithCourse(@ExamID,@CourseCode,@InstrSSN)=1
   	 if dbo.CheckQuestWithCourse(@QuestID,@CourseCode) is not null
   	 begin
   	   set @Degree=dbo.CheckQuestWithCourse(@QuestID,@CourseCode)
	   set @QuestNUMInExam=NEXT VALUE FOR QuestNo_IN_Exam
   	   insert into [Instructor].[Question_Exam] values(@ExamID,@QuestID,@QuestNUMInExam,@Degree)
   	 end
   	 else print 'This Qestion is not allowed'
   else print 'Wrong Exame Or Course'
end
go
--SetQuestionToExam '1992','C#_CS_21','C#Exame1',1,1
go
create trigger BeforInsertIntoQuestion_Exam on [Instructor].[Question_Exam]
instead of insert
as
begin
Declare @ExamID varchar(20)
Declare @QuestID varchar(20)
Declare @QuestNO int
Declare @Degree int
Declare @ExameDegree int
select @Degree=[Quest_degree] from inserted
select @ExamID=[Exam_id] from inserted
select @ExameDegree=[Total_degree] from [Instructor].[Exame] where Id=@ExamID

 if @ExamID in (select [Exam_id] from [Instructor].[Question_Exam])
 	 if dbo.GetQuestionsTotalDegreeInExam(@ExamID)+@Degree<@ExameDegree
 		insert into [Instructor].[Question_Exam] select * from inserted
 	 Else print 'Degree Exame Exceeded'
 else
 begin
	alter SEQUENCE QuestNo_IN_Exam
	restart
	select @ExamID= [Exam_id] from inserted
	select @QuestID=[Question_id]  from inserted
	select @Degree=[Quest_degree] from inserted
	SELECT @QuestNO=NEXT VALUE FOR QuestNo_IN_Exam
	insert into [Instructor].[Question_Exam] values(@ExamID,@QuestID,@Degree,@QuestNO)
 end
end
------------- end of trigger

-------------- Show all Student Courses-------------
go
CREATE proc ShowStudentCourse(@StudentID char(14))
as
begin
	
	Select std.[Name] as StudentName,[Description] as CourseName,[Total_degree] as StudentDegree 
	FROM [Manager].[Student] as std 
	join [Manager].[Course_For_Student] as C_Std
	ON std.SSN=C_Std.student_SSN
	join [Manager].[Course] as Course
	ON Course.Code=C_Std.Course_Code
	Where std.SSN=@StudentID;
end
-------------------------
go
create function selectQuestAnswers(@ExamID varchar(20))
returns @SelectedExame table(Question_no_IN_Exame int,
QuestText varchar(300),AnswerText varchar(300))
as
begin
insert into @SelectedExame select QS.[Question_no_IN_Exame],Q.text[Text],Ans.[Text] from 
   [Instructor].[Question_Exam] as QS join [Instructor].[Question] as Q
   on QS.[Question_id]=Q.ID join
  [Instructor].[Answer] as Ans on Q.ID=Ans.[Qestion_id]
  where QS.[Exam_id]=@ExamID
return
end
go
create function GetCourseCode(@courseName varchar(100))
returns varchar(40)
as
begin
	Declare @Course_code varchar(40)
    select @Course_code=[Code] from [Manager].[Course] where [Name]=@courseName
	return @Course_code
end
go
create function GetExameID(@studentSSN varchar(14),@Course_code varchar(40))
returns varchar(20)
as
begin
declare @Exam_id varchar(20)
	Select  @Exam_id= [Exam_id] from [Instructor].[Student_Exame_in_Course] where
   [Student_SSN]=@studentSSN and [Course_code]=@Course_code and [Std_degree] is null
   return @Exam_id
end
-----------------Student Start specific exame in specific course--------
go
GRANT SELECT ON [Instructor].[Answer] ([Text],[Qestion_id]) TO student;
GRANT SELECT ON [Instructor].[Question_Exam] ([Question_no_IN_Exame],[Question_id],Exam_id) TO student;

--GRANT SELECT ON dbo.GetExameID TO student;

go
Create proc Student.startExam(@studentSSN char(14),@courseName varchar(100))
as
begin
   Declare @Course_code varchar(40)
   declare @Exam_id varchar(20)
   set @Course_code=dbo.GetCourseCode(@courseName)
   set @Exam_id=dbo.GetExameID(@studentSSN,@Course_code)
   --select * from dbo.selectQuestAnswers(@Exam_id)
  select QS.[Question_no_IN_Exame],Q.text[Text],Ans.[Text] from 
   [Instructor].[Question_Exam] as QS join [Instructor].[Question] as Q
   on QS.[Question_id]=Q.ID join
  [Instructor].[Answer] as Ans on Q.ID=Ans.[Qestion_id]
  where QS.[Exam_id]=@Exam_id
 end
-------------
