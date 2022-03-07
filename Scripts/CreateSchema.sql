--go
--create schema student
--go
--create schema Instructor
--go
--create schema Manager

go
--alter schema Manager transfer [dbo].[Branch]
alter schema Manager transfer [dbo].[Account]
alter schema Manager transfer [dbo].[Class]
alter schema Manager transfer [dbo].[CLS_CRS_INS]
alter schema Manager transfer [dbo].[Course]
alter schema Manager transfer [dbo].[Course_For_Student]
alter schema Manager transfer [dbo].[Department]
alter schema Manager transfer [dbo].[Department_Branch]
alter schema Manager transfer [dbo].[Instructor]
alter schema Manager transfer [dbo].[Intake]
alter schema Manager transfer [dbo].[Student]
alter schema Manager transfer [dbo].[Track]
alter schema Manager transfer [dbo].[Track_Course]
alter schema Manager transfer [dbo].[Works_on]

----------- instructor----
alter schema instructor transfer [dbo].[Answer]
alter schema instructor transfer [dbo].[CLS_CRS_INS_EXM]
alter schema instructor transfer [dbo].[Exame]
alter schema instructor transfer [dbo].[Question]
alter schema instructor transfer [dbo].[Question_Exam]
alter schema instructor transfer [dbo].[Student_Exame_in_Course]
alter schema instructor transfer [dbo].[Student_Exame_Question]
