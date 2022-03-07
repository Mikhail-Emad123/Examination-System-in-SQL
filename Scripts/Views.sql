use [ExaminationSystem]
go
create view StudentGenralInfo
as
(
	select 
		  std.SSN as ID,std.[Name] 'StudentName',[Description] as CourseName ,Inst.[Name] as IstructorName
		  from [Manager].[Course] as course
		  join [Manager].[Course_For_Student]
		  on [Code]=[Course_Code] 
		  join [Manager].[Student] as std
		  on [student_SSN]= [SSN]
		  join [Manager].[CLS_CRS_INS] as CCI
		  on CCI.[Course_Code]=course.[Code]
		  join [Manager].[Instructor] as Inst
		  on CCI.Instructor_SSN= Inst.SSN			
)
------------


dbo.ShowStudentCourse '1999'
select * from StudentGenralInfo