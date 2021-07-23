-- Script name: tests.sql
-- Author:      Luis Alfaro
-- Purpose:     test the integrity of a univeristy's student record keeping.
       
-- the database used to insert the data into.
USE universityDB;
SET SQL_SAFE_UPDATES = 0;

-- 1. Testing Course for Enrollment, Waitlist, Lecturer_Course, and Professor_Course
DELETE FROM Course WHERE course_id = 6;
#UPDATE Course SET course_id = 6 WHERE title = 'CSC415';

-- 2. Testing Time_Slot table
DELETE FROM Time_Slot WHERE time_slot_id = 2;
UPDATE Time_Slot SET time_slot_id = 1 WHERE start_time = '2021-07-02 06:14:00.742000000';

-- 3. Testing Classroom table
DELETE FROM Classroom WHERE Classroom_id = 1;
UPDATE Classroom SET Classroom_id = 1 WHERE Classroom_id = '2';

-- 4. Testing Section table
DELETE FROM Section WHERE section_id = 1;
UPDATE Section SET section_id = 1 WHERE section_id = '2';

-- 5. Testing Resource_Link table
DELETE FROM Resource_Link WHERE resource_link_id = 1;
UPDATE Resource_Link SET resource_link_id = 1 WHERE resource_link_id = '2';

-- 6. Testing Payment for
	-- Bank_Account
DELETE FROM Payment WHERE payment_id = 4;
UPDATE Payment SET payment_id = 4 WHERE payment_id = '5';
	-- Credit_Card
DELETE FROM Payment WHERE payment_id = 3;
UPDATE Payment SET payment_id = 3 WHERE payment_id = '2';

-- 7. Testing Building for Dorm
DELETE FROM Building WHERE building_id = 2;
UPDATE Building SET building_id = 2 WHERE address = '2 Varela Ave San Francisco, CA 94132';

-- 8. Testing Room for Student and Contain
DELETE FROM Room WHERE room_id = 3;
UPDATE Room SET room_id = 3 WHERE room_id = 2;

-- 9. Testing Mailing_List for Sign_Up
DELETE FROM Mailing_List WHERE mail_id = 2;
UPDATE Mailing_List SET mail_id = 2 WHERE mail_id = 3;

-- 10. Testing School_Program for Attend
DELETE FROM School_Program WHERE program_id = 2;
UPDATE School_Program SET program_id = 4 WHERE program_id = 1;

-- 11. Testing Department table for Appoint, Minor, Major and School_Program
DELETE FROM Department WHERE department_id = 1;
UPDATE Department SET department_id = 1 WHERE department_id = 2;

-- 12. Testing Faculty_Member table: Should also delete records of Professor_Course and Lecturer_Course
	-- for Advisor
DELETE FROM Faculty_Member WHERE faculty_id = 2;
#UPDATE Faculty_Member SET faculty_id = 2 WHERE faculty_id = 1;
	-- Professor
DELETE FROM Faculty_Member WHERE faculty_id = 4;
UPDATE Faculty_Member SET faculty_id = 4 WHERE faculty_id = 5;
    -- Lecturer
DELETE FROM Faculty_Member WHERE faculty_id = 7;
UPDATE Faculty_Member SET faculty_id = 7 WHERE faculty_id = 8;

-- 13. Testing Write table with Author
#DELETE FROM Author WHERE author_id = 3;
UPDATE Author SET author_id = 4 WHERE author_id = 3;

-- 14. Testing Requires table with Book
#DELETE FROM Book WHERE book_id = 3;
UPDATE Book SET title = 'Aliens' WHERE book_isbn = '9780984782857';






-- 1. Testing Appoint table
#DELETE FROM Appoint WHERE appoint_id = 1;
#UPDATE Appoint SET appoint_id = 1 WHERE appoint_id = '2';

-- 2. Testing Minor table
#DELETE FROM Minor WHERE student = 1;
#UPDATE Minor SET department = 1 WHERE department = '2';

-- 3. Testing Major table
#DELETE FROM Major WHERE student = 1;
#UPDATE Major SET department = 1 WHERE department = '3';

-- 4. Testing Enroll_Exam table
#DELETE FROM Enroll_Exam WHERE student = 1;
#UPDATE Enroll_Exam SET exam = 1 WHERE exam = '3';

-- 5. Testing Attend table
#DELETE FROM Attend WHERE attend_id = 1;
#UPDATE Attend SET school_program = 1 WHERE school_program = '2';

-- 6. Testing Sign_Up table
#DELETE FROM Sign_Up WHERE student = 1;
#UPDATE Sign_Up SET mailing_list = 2 WHERE mailing_list = '3';

-- 7 Testing Research table
#DELETE FROM Research WHERE animal= 1;
#UPDATE Research SET animal = 3 WHERE animal = 2;

-- 8 Testing Grades table
#DELETE FROM Grades WHERE grader = 1;
#UPDATE Grades SET Course = 2 WHERE Course = 1;

-- 9 Testing Payment table
#DELETE FROM Payment WHERE payment_id = 1;
#UPDATE Payment SET amount = '35696.31' WHERE student = 1;

-- 10 Testing Bank_Account table
#DELETE FROM Bank_Account WHERE payment = 4;
#UPDATE Bank_Account SET bank_account_number = '3569654685' WHERE payment = 5;

-- 11 Testing Credit_Card table
#DELETE FROM Credit_Card WHERE payment = 1;
#UPDATE Credit_Card SET credit_card_number = '45669654685' WHERE payment = 3;

-- 12 Testing Enrollment table
#DELETE FROM Enrollment WHERE student = 1;
#Update Enrollment SET course = 2 WHERE Student = 2;

-- 13 Testing Waitlist table
#DELETE FROM Waitlist WHERE student = 1;
#Update Waitlist SET course = 2 WHERE Student = 2;

-- 14 Testing Dorm table
#DELETE FROM Dorm WHERE building = 1;
#Update Dorm SET building = 1 WHERE building = 3;

-- 15 Testing Contain table
#DELETE FROM Contain WHERE Dorm = 1;
#UPDATE Contain SET Room = 3 WHERE Room = 1;

-- 16 Testing Advisor table
#DELETE FROM Advisor WHERE faculty = 1;
#UPDATE Advisor SET faculty = 10 WHERE faculty = 2;

-- 17 Testing Professor table
#DELETE FROM Professor WHERE faculty = 4;
#UPDATE Professor SET faculty = 11 WHERE faculty = 5;

-- 18 Testing Lecturer table
#DELETE FROM Lecturer WHERE faculty = 7;
#UPDATE Lecturer SET faculty = 12 WHERE faculty = 8;

-- 19 Testing Lecturer_Course table
#DELETE FROM Lecturer_Course WHERE lecturer = 1;
#UPDATE Lecturer_Course SET lecturer = 1 WHERE course = 5;

-- 20 Testing Professor_Course table
#DELETE FROM Professor_Course WHERE professor = 1;
#UPDATE Professor_Course SET professor = 1 WHERE course = 2;

-- 21 Testing Links table
#DELETE FROM Links WHERE resource_link = 1;
#UPDATE Links SET course = 3 WHERE course = 2;

-- 22 Testing Writes table
#DELETE FROM Writes WHERE author = 1;
#UPDATE Writes SET book = 1 WHERE author = 2;

-- 23 Testing Requires table
#DELETE FROM Requires WHERE course = 1;
#Update Requires SET book = '9780984782857' WHERE course = 4;