use [ExaminationSystem]
go
create table Intake
(
	[Number] int not null,
	[Start_date] date not null,
	[End_date] date not null,
	[Duration]  as DATEDIFF(month, [Start_date],[End_date]),
	constraint IntakePK primary key (Number)
)
--go
--alter table Manager.Intake add  [Duration] as (DATEDIFF(month, [Start_date],[End_date]))
-----
go
create table Instructor
(
	[SSN] char (14) not null,
	[Name] varchar (100) not null,
	[Age] int not null,
	[Gender] char (1) not null,
	[Address] varchar (200) not null,
	[email] varchar(50) not null,
	constraint Instructor_PK primary key (SSN),
	constraint genderCheck check ([Gender] in ('M','F'))
)


go
create table Branch
(
	ID varchar(20) not null,
	[Name] varchar (200) not null,
	[Location] varchar (200) not null,
	[Phone] char (11) not null,
	[Manager_SSN] char(14) ,
	constraint BranchPK primary key (ID),
	constraint Branch_Manager_FK foreign key ([Manager_SSN]) references Instructor([SSN]),
	constraint PhoneCheck check (len(Phone)=11)
)

go
create table Track(
ID varchar(20) not null,
[Name] varchar(200) not null,
Description varchar(200) not null,
Constraint Track_PK primary key (ID)
)

go
create table Class(
 ID int not null,
 [Name] varchar(100) not null,
 IntakeNumber int not null ,
 Branch_ID varchar(20) not null ,
 Track_ID varchar(20) not null ,
 Constraint Class_PK primary key (ID),
 Constraint Class_IntakeNumber_FK foreign key (IntakeNumber) references Intake([Number])
 on delete no action on update cascade,
 Constraint Class_Branch_ID_FK foreign key (Branch_ID) references Branch(ID)
 on delete no action on update cascade,
 Constraint Class_Track_ID_FK foreign key (Track_ID) references Track(ID)
 on delete no action on update cascade,
)
go
alter table Class add constraint Class_unique unique(IntakeNumber,Branch_ID,Track_ID);

go
create table Course(
Code varchar(40) not null,
[Description] varchar(200) not null,
Max_degree int not null,
Min_degree int not null,
Name varchar(100) not null,
Constraint Course_PK primary key (Code),
constraint Unique_Course_Name unique(Name)
)
--alter table [Manager].[Course]  add constraint Unique_Course_Name unique(Name)
go
create table Track_Course(
Track_ID varchar(20) not null ,
Course_Code varchar(40) not null ,
Constraint Track_Course_PK primary key (Track_ID,Course_Code),

Constraint Track_Course_Track_ID_FK foreign key (Track_ID) references Track(ID)
on delete no action on update cascade,
Constraint Track_Course_Course_Code_FK foreign key (Course_Code) references Course(Code)
on delete no action on update cascade
)
go
create table  Exame (
ID varchar(20) not null,
[Type] varchar(10) not null,
Total_degree int not null,
Allowance_Option varchar(20),
Exame_date date not null,
InstructorSSN char(14) not null,
ClassID int not null,
CourseCode varchar(40) not null,
[Start-time] time(0) not null,
[End-time] time(0) not null,
[year] as year(Exame_date) ,
Deuration as datediff(minute,[Start-time],[End-time]) persisted,
Number_of_Question int not null,
Constraint Exam_PK primary key (ID),
Constraint Exame_Type_Check check([Type] in( 'exame' , 'corrective')),
constraint Exame_INSTR_SSN_FK foreign key
(InstructorSSN) references [Instructor](SSN) on delete no action on update no action,
constraint Exame_CourseCode_FK foreign key
(CourseCode) references [Course](Code) on delete no action on update no action
,constraint Exame_ClassID_FK foreign key
(ClassID) references [Class](ID) on delete no action on update no action

)
go 

go
create table CLS_CRS_INS(
Class_ID int not null,
Course_Code varchar(40) not null,
Instructor_SSN char(14) not null,
Constraint CLS_CRS_INS_PK primary key (Class_ID,Course_Code,Instructor_SSN),
Constraint CLS_CRS_INS_Class_ID_FK foreign key (Class_ID) references Class(ID)
on delete no action on update cascade,
Constraint CLS_CRS_INS_Course_Code_FK foreign key (Course_Code) references Course(Code)
on delete no action on update cascade,
Constraint CLS_CRS_INS_Instructor_SSN_FK foreign key(Instructor_SSN) references Instructor([SSN])
on delete no action on update cascade
)
go
 ----pk
create table Student(
SSN char(14) not null,
[Name] varchar(140) not null,
Age int not null,
Gender char(1) not null,
Address varchar(200) not null,
Email varchar(200) not null,
Class_ID int not null,
Constraint Student_PK primary key (SSN),
Constraint Student_Class_ID_FK foreign key (Class_ID) references Class(ID),
constraint Student_gender_Check check ([Gender] in ('M','F'))
)

go
 
create table Course_For_Student(
Course_Code varchar(40) not null, 
student_SSN char(14) not null,
Total_degree int ,
Constraint Course_For_Student_PK primary key (Course_Code,student_SSN),
Constraint Course_For_Student_Course_Code_FK foreign key (Course_Code) references Course(Code),
Constraint Course_For_Student_student_SSN_FK foreign key (student_SSN) references Student(SSN)
)


go
create table Student_Exame_in_Course(
Course_code varchar(40) not null,
Student_SSN char(14) not null,
Exam_id varchar(20) not null,
Std_degree int ,

Constraint Student_Exames_in_Course_PK primary key (Course_Code,student_SSN,Exam_id),

Constraint Student_Exame_in_Course_student_SSN_FK foreign key (student_SSN) references Student(SSN) 
on delete cascade on update cascade,
Constraint Student_Exame_in_Course_Course_Code_FK foreign key (Course_Code) references Course(Code)
on delete cascade on update cascade,
Constraint Student_Exame_in_Course_Exam_id_FK foreign key (Exam_id) references Exame(ID)
on delete cascade on update cascade
)

------------------------////////////////////-----------
go
create table Account(
UserName varchar(100) not null,
Password varchar(20) not null,
User_SSN char(14) not null,
constraint Account_PK primary key (UserName)
)

go
create table Department
(
	ID varchar(50) not null,
	[Name] varchar (200) not null,
	constraint DepartmentPK primary key (ID)
)
go
create table Department_Branch
(
	[Branch_id] varchar(20) not null,
	[Dept_id] varchar(50) not null,
	constraint  Department_BranchPK primary key (Branch_id,Dept_id),
	constraint  Department_Branch_Branch_id_FK foreign key (Branch_id) references Branch(ID),
	constraint  Department_Branch_Dept_id_FK foreign key (Dept_id) references Department(ID)
)
go
create table Works_on
(
	[Branch_id] varchar(20) not null,
	[Dept_id] varchar(50) not null,
	[Inst_SSN] char (14) not null,
	constraint Works_onPK primary key (Branch_id,Dept_id,Inst_SSN),
	constraint Works_on_Branch_id_FK foreign key (Branch_id) references Branch(ID),
	constraint Works_on_Dept_id_FK foreign key (Dept_id) references Department(ID),
	constraint Works_on_Inst_SSN_FK foreign key (Inst_SSN) references Instructor(SSN)

)


go
create table Question
(
	[ID] varchar(20) not null,
	[Text] varchar (300) not null,
	[Type] varchar (300) not null,
	[Degree] int ,
	Course_Code varchar(40) not null,
	constraint QuestionPK primary key (ID)
)

go
alter table Question add constraint Question_Course_Code_FK foreign key (Course_Code)
references Course(Code);
go
create table Answer 
(
	[ID] varchar(50) not null,
	[Text] varchar(300) not null,
	[Qestion_id] varchar (20),
	Correct bit ,
	constraint AnswerPK primary key (ID),
	constraint Answer_Qestion_id_FK foreign key (Qestion_id) references Question(ID)
)
 
go
create table Question_Exam
(
	Exam_id varchar(20) not null,
    Question_id varchar(20) not null,
	Question_no_IN_Exame int not null,
	Quest_degree int not null,
	
	constraint Question_ExamPK primary key (Exam_id,Question_id),
	constraint Question_Exam_Question_id_FK foreign key (Question_id) references Question(ID),
	constraint Question_Exam_Exam_id_FK foreign key (Exam_id) references Exame(ID),
	constraint Question_Exam_Unique unique(Exam_id,Question_id,Question_no_IN_Exame)
)

go

create table Student_Exame_Question(
Exam_id varchar(20) not null,
Student_SSN char(14) not null,
Quest_id varchar(20) not null,
Std_Answer char(1),
Result int ,
constraint Student_Exame_Question_PK primary key (Exam_id,Student_SSN,Quest_id),
Constraint Student_Exame_Question_student_SSN_FK foreign key (student_SSN) references Student(SSN) 
on delete cascade on update cascade,
Constraint Student_Exame_Question_Exam_id_FK foreign key (Exam_id) references Exame(ID)
on delete cascade on update cascade,
Constraint Student_Exame_Question_Quest_id_FK foreign key (Quest_id) references Question(ID)
on delete cascade on update cascade
)