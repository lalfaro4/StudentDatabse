-- Script name: inserts.sql
-- Author:      Luis Alfaro
-- Purpose:     insert sample data to test the integrity of the database system for a univeristy's student record keeping.

-- the database used to insert the data into.
USE universityDB;

 -- Room table inserts
 INSERT INTO Room (room_id, beds) VALUES (1, 2), (2, 4), (3, 1);
 
 -- Building table inserts
 INSERT INTO Building (building_id, address, capacity) VALUES (1, '2 Varela Ave San Francisco, CA 94132', 300), (2, '796 Font Boulevard San Francisco, CA 94132', 250), (3, '235 Buckingham Way San Francisco, CA 94132', 200);
 
 -- Dorm table inserts
 INSERT INTO Dorm (dorm_id, building) VALUES (1, 1), (2, 2), (3, 3);
 
 -- Contain table inserts
 INSERT INTO Contain (contain_id, dorm, room) VALUES (1, 1, 1),  (2, 1, 2),  (3, 2, 1);  
 
 -- Department table inserts
INSERT INTO Department	(department_id, name, email) VALUES (1, 'Math', 'Math@university.edu.mail.com'), (2, 'Computer Science', 'CS@university.edu.mail.com'), (3, 'Physics', 'Physics@university.edu.mail.com');

-- Faculty_Member table inserts
	-- For Advisor
INSERT INTO Faculty_Member	(faculty_id, first_name, last_name, email, first_joined) VALUES (1, 'James', 'Silver', 'Silver@university.edu.mail.com', CURRENT_TIMESTAMP), (2, 'Sue', 'Sam', 'Silver@university.edu.mail.com', CURRENT_TIMESTAMP), (3, 'John', 'Bond', 'Silver@university.edu.mail.com', CURRENT_TIMESTAMP);
	-- For Professor
INSERT INTO Faculty_Member	(faculty_id, first_name, last_name, email, first_joined) VALUES (4, 'Kame', 'Pop', 'Kame@university.edu.mail.com', CURRENT_TIMESTAMP), (5, 'Dan', 'Fritz', 'Dan@university.edu.mail.com', CURRENT_TIMESTAMP), (6, 'Ridley', 'Scott', 'Ridley@university.edu.mail.com', CURRENT_TIMESTAMP);
	-- For Lecturer
INSERT INTO Faculty_Member	(faculty_id, first_name, last_name, email, first_joined) VALUES (7, 'Jean', 'Paul', 'Jean@university.edu.mail.com', CURRENT_TIMESTAMP), (8, 'Sean', 'Fast', 'Sean@university.edu.mail.com', CURRENT_TIMESTAMP), (9, 'Slick', 'Falt', 'Slick@university.edu.mail.com', CURRENT_TIMESTAMP);

-- Appoint table inserts
INSERT INTO Appoint (appoint_id, faculty, department) VALUES (1, 4, 2), (2, 5, 2), (3, 6, 2), (4, 5, 1);

-- Advisor table inserts
INSERT INTO Advisor (advisor_id, faculty) VALUES (1, 1), (2, 2), (3, 3);
 
-- Professor table inserts
INSERT INTO Professor (professor_id, faculty, years_taught) VALUES (1, 4, 5), (2, 5, 3), (3, 6, 1);
  
-- Lecturer table inserts
INSERT INTO Lecturer (lecturer_id, faculty, years_taught) VALUES (1, 7, 5), (2, 8, 21), (3, 9, 0);
  
-- Student table inserts
INSERT INTO Student (student_id, first_name, last_name, email, assigned_animal, room, advisor) VALUES (1, 'Jake', 'Pan', 'aa@mail.com', 1, 1, 1), (2, 'Lisa', 'Who', 'lisa123@university.edu.mail.com', 1, 2, null), (3, 'Alice', 'Moon', 'Alice@university.edu.mail.com', 1, 2, null);

-- City table inserts
INSERT INTO City (city_id, name, is_there_courses) VALUES (1, 'San Fransico', 1), (2, 'San Jose', 1), (3, 'Sacramento', 1);
  
-- Section table inserts
INSERT INTO Section (section_id, total_sections, next_available_section) VALUES (1, 3, 4), (2, 3, 4), (3, 3, 4);
  
-- Time_Slot table inserts
INSERT INTO Time_Slot (time_slot_id, start_time, end_time) VALUES (1, '2021-07-02 06:14:00.742000000','2021-07-02 08:14:00.742000000'), (2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP), (3, '2021-07-02 08:14:00.742000000', '2021-07-02 10:14:00.742000000');
  
-- Classroom table inserts
INSERT INTO Classroom (classroom_id, max_occupancy, is_lab) VALUES (1, 40, 0), (2, 25, 1), (3, 45, 0);
  
-- Course table inserts
	-- For Professor_Course
INSERT INTO Course (course_id, title, section, time_slot, classroom, city) VALUES (1, 'CSC648', 1, 1, 1, 1),  (2, 'CSC675', 2, 2, 2, 2),  (3, 'Math200', 3, 3, 3, 3); 
	-- For Lecturer_Course
INSERT INTO Course (course_id, title, section, time_slot, classroom, city) VALUES (4, 'CSC510', 1, 2, 1, 1),  (5, 'CSC415', 2, 1, 2, 2),  (6, 'Math300', 3, 3, 1, 3); 

-- ENROLLMENT table inserts
INSERT INTO Enrollment (enrollment_id, student, course) VALUES (1, 1, 1), (2, 1, 2), (3, 2, 1), (4, 2, 2), (5, 3, 2), (6, 3, 3), (7, 1, 6), (8, 2, 5); 

-- Waitlist table inserts
INSERT INTO Waitlist (waitlist_id, student, course) VALUES (1, 1, 3), (2, 2, 3), (3, 3, 1);

-- Minor table inserts
INSERT INTO Minor (student, department) VALUES (1, 1), (2, 2), (2, 3);

-- Major table inserts
INSERT INTO Major (student, department) VALUES (1, 3), (2, 1), (3, 3);

-- School_Program table inserts
INSERT INTO School_Program (program_id, department, name) VALUES ( 1, 1, 'MATH HELP'), ( 2, 2, 'Hackathon'), ( 3, 2, 'COMPUTER TUTORING');

-- Join table inserts
INSERT INTO Attend (joined_id, student, school_program)	VALUES	(1,	1, 1), (2,	2, 1), (3,	3, 2);

-- Mailing_List table inserts
INSERT INTO Mailing_List (mail_id, email_address, content) VALUES (1, 'University Sport NEWS!', 'Team University Beats Team University2!'), (2, 'University Courses NEWS!', 'NEW COURSES ADDED!'), (3, 'University Food NEWS!', 'NEW Food Menu Items Added!');

-- Sign_Up table inserts
INSERT INTO Sign_Up	(student, mailing_list) VALUES (1, 1), (1, 2), (3, 3);

-- Exam table inserts
INSERT INTO Exam (exam_id, name, next_date) VALUES (1, 'Math Assessment', current_timestamp), (2, 'English Assessment', '2021-07-02 06:14:00.742000000'), (3, 'Science Assessment', '2021-07-02 08:14:00.742000000');

-- Enroll_Exam table inserts
INSERT INTO Enroll_Exam (enroll_exam_id, student, exam) VALUES (1, 1, 1), (2, 2, 2), (3, 3, 3);

-- Animal table inserts
INSERT INTO Animal (animal_id, name, dob, animal_type) VALUES (1, 'Stompy', '2021-03-02 01:14:00.742000000', 'Roadrunner'), (2, 'Hopppy', current_timestamp, 'Frog'), (3, 'Chompy', '2021-05-02 04:12:00.742000000', 'Dog');

-- Research table inserts
INSERT INTO Research (research_id, student, animal) VALUES (1, 1, 1), (2, 2, 3), (3, 3, 2);

 -- Grader table inserts
 INSERT INTO Grader (grader_id) VALUES (1), (2), (3);
 
 -- Grades table inserts
 INSERT INTO Grades (grader, course, student) VALUES (1, 1, 2), (2, 1, 1), (3, 2, 2);
 
 -- Payment table inserts
	-- For Credit_Card
 INSERT INTO Payment (payment_id, amount, student) VALUES (1, 52.50, 1), (2, 532.50, 2), (3, 412.50, 3);
 	-- For Bank_Account
 INSERT INTO Payment (payment_id, amount, student) VALUES (4, 751.50, 1), (5, 523.50, 2), (6, 7468.50, 3);

-- Credit_Card table inserts
 INSERT INTO Credit_Card (payment, credit_card_number) VALUES (1, 371449635398431), (2, 378734493671000), (3, 5555555555554444);
 
-- Bank_Account table inserts
INSERT INTO Bank_Account (payment, bank_account_number) VALUES (4, 021000021), (5, 011401533), (6, 091000019);
 
-- Resource_Link table inserts
INSERT INTO Resource_Link (resource_link_id, url, title, category) VALUES (1, 'https://swe.org/', 'Society for Women Engineers', 'Diversity in Computing'), (2, 'https://www.jkcf.org/our-scholarships/college-scholarship-program/', 'Jack Kent Cooke Foundation College Scholarships', 'Scholarship'), (3, 'https://www.sae.org/students', 'SAE International Scholarships', 'Scholarship');
 
-- Links table inserts
INSERT INTO Links (resource_link, course) VALUES (1, 1), (1, 2), (2, 1), (2, 2);
 
-- Professor_Course table inserts
INSERT INTO Professor_Course (professor, course) VALUES (1, 1), (2, 2), (3, 3);
 
 -- Lecturer_Course table inserts
 INSERT INTO Lecturer_Course (lecturer, course) VALUES (1, 4), (2, 5), (3, 6);
 
-- Author table inserts
INSERT INTO Author (author_id, first_name, last_name, age) VALUES (1, 'Gayle', 'McDowell', 38), (2, 'Thomas', 'Cormen', 65), (3, 'Grant', 'Bucks', 20);

-- Book insert table
INSERT INTO Book (book_id, book_isbn, title, publisher, publish_date, category) VALUES (1, '9780984782857', 'Cracking the Coding Interview', 'CareerCup', '2015-07-01 00:14:00.742000000', 'Interview'), (2, '9780262033848', 'Introduction to Algorithms', 'MIT Press', '2009-09-01 00:14:00.742000000', 'Computer Algorithms'), (3, '9754782857', 'My Book', 'Me Inc', '2021-07-01 00:14:00.742000000', 'Interview');

-- Write table inserts
INSERT INTO Writes (writes_id, author, book) VALUES (1, 1, 1), (2, 2, 2), (3, 3, 3);
 
 -- Require table inserts
 INSERT INTO Requires (course, book) VALUES (4, 9780984782857), (4, 9780262033848), (1, 9754782857);