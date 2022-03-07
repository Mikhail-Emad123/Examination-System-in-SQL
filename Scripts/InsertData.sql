-- -- Intake
--go
--insert into Intake values(1,3,'1-01-2021','4-01-2021'),(2,9,'1-01-2021','10-01-2021'),
--(3,3,'12-04-2021','3-04-2022'),(4,3,'9-04-2021','12-04-2021'),(5,9,'10-04-2020','7-04-2021')

-- --Instructor
--go
--insert into Instructor values('1991','Ahmed Ali',30,'M','Cairo','Ahmed@ali'),
--('1992','Mohamed Salah',29,'M','Alex','Mohamed@Salah'),('1994','Nada Ali',27,'F','Cairo','Nada@ali'),
--('1993','Ahmed Ibrahim',28,'M','Sohag','Ahmed@Ibrahim'),('1995','Rasha Hossam',27,'F','Minia','Rasha@Hossam');

-- --Branch
--go
--insert into Branch values('Smart_ITI','ITI Smart Village','Smart Village','01101101100','1991'),
--('Alex_ITI','ITI Alex','Alex','01001001200','1992'),
--('Assiut_ITI','ITI Assiut','Assiut','01201201200','1993'),
--('Minia_ITI','ITI Minia','Minia','01501501500','1995'),
--('Sohag_ITI','ITI Sohag','Sohag','01501201100','1994')

-- --Track
--go
--insert into Track values('.NET_CS_22','.NET Track','Full Stack Web development using .net'),
--('Mearn Stack','Mearn Stack','Full Stack Web development using Mearn Stack'),
--('3D Modeling_MM_22','3D Modeling','3D Modeling and Graphics'),
--('BI_IS_20','Business Intellegence','Business Intellegence'),
--('PHP_CS_30','PHP','Backend development using PHP');

-- --Class
--go
--insert into Class values(1,'Class1',1,'Smart_ITI','.NET_CS_22'),(2,'Class2',2,'Alex_ITI','.NET_CS_22'),
--(3,'Class3',1,'Smart_ITI','PHP_CS_30'),(4,'Class4',2,'Minia_ITI','Mearn Stack'),
--(5,'Class5',3,'Sohag_ITI','PHP_CS_30');

-- --Course
--go
--insert into Course values('HTML_IS_20','HTML',100,40),('CSS_IS_20','CSS',100,40),
--('JS_IS_10','Java Script',100,40),('C#_CS_21','C# Programming',100,50),
--('FreeLancing_20','FreeLancing',100,40),('Communication_HR_2','Communication Skills',100,40)

-- --Track_Course
--go
--insert into Track_Course values('.NET_CS_22','HTML_IS_20'),('.NET_CS_22','CSS_IS_20'),
--('.NET_CS_22','C#_CS_21'),('.NET_CS_22','FreeLancing_20'),('PHP_CS_30','HTML_IS_20'),
--('PHP_CS_30','JS_IS_10'),('Mearn Stack','HTML_IS_20'),('Mearn Stack','JS_IS_10');

-- --Exame
--go
--insert into [Instructor].[Exame] values
--('C#Exame1','Exame',100,null,'2022-01-01','1992',1,'C#_CS_21','10:00:00','11:00:00')
---------- Student
go
insert into [Student] values ('2001','Ali','23','M','minia','ali@gmail.com',1),
('1997','soha','25','F','minia','soha@gmail.com',1),('1998','mohamed','24','M','minia','mohamed@gmail.com',1),
('1999','rana','23','F','minia','rana@gmail.com',2),('2000','hussen','26','M','BNS','hussen@gmail.com',2)
--------------------[Course_For_Student]
go
insert into  [Course_For_Student]values('C#_CS_21',1999,null),('C#_CS_21',1998,null)
,('FreeLancing_20',1997,null),('HTML_IS_20',1997,null),('JS_IS_10',1998,null)