# database.py
# Handles all the methods interacting with the database of the application.
# Students must implement their own methods here to meet the project requirements.

import os
import pymysql.cursors

db_host = os.environ['DB_HOST']
discord_token = os.environ['DISCORD_TOKEN']
discord_guild = os.environ['DISCORD_GUILD']
host = os.environ['DB_HOST']
user = os.environ['DB_USER']
db_name = os.environ['DB_NAME']
password = os.environ['DB_PASSWORD']





db_username = os.environ['DB_USER']
db_password = os.environ['DB_PASSWORD']
db_name = os.environ['DB_NAME']


def connect():
    try:
        
        conn = pymysql.connect(host=db_host,
                               port=3306,
                               user=db_username,
                               password=db_password,
                               db=db_name,
                               charset="utf8mb4", cursorclass=pymysql.cursors.DictCursor)

        print("Bot connected to database {}".format(db_name))
        return conn
    except:
        print("Bot failed to create a connection with your database because your secret environment variables " +
              "(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME) are not set".format(db_name))
        print("\n")


async def response(msg):
  if msg:
    print(msg)
    if "milestone3" in msg:
      response = "I am alive. Signed: 'your bot'"
      return response
    elif  "authorsteaching" in msg:
      response = getAuthorsTeaching()
      return response
    elif  "notifiedwaitlistedstudents" in msg:
      response = notifiedWaitListedStudents()
      return response
    elif "bankpaymentsgreaterthancreditavg" in msg:
      response = getBankPaymentsGreaterThanCreditAvg()
      return response
    elif "studentsfinancialhelpoveramount" in msg:
      inputs = msg.split()
      amount = inputs[1]
      response = studentsEnrolledInFinancialHelpMadePaymentOverAmount(amount);
      #print(response)
      return response
    elif "recommendschoolprograms" in msg:
      inputs = msg.split()
      student_id = inputs[1]
      response = recommendedSchoolPrograms(student_id)
      return response
    elif "studentsreseachinganimalmonitoredby" in msg:
      inputs = msg.split()
      animal = inputs[1]
      monitor = inputs[2]
      response = studentResearchingAnimalMonitoredBy(animal, monitor)
      return response
    elif "coursesinstudentcity" in msg:
      inputs = msg.split()
      student_id = inputs[1]
      response = coursesForStudentInTheirCity(student_id)
      return response
    elif "help" in msg:
      response = """To get the Authors that are teaching courses\nCommand: authorsteaching
      \nTo get the students that will be notified for waitlisted courses\nCommand: notifiedwaitlistedstudents
      \nTo get the bank payments that were greater than the total credit card average payments\nCommand: bankpaymentsgreaterthancreditavg
      \nTo get all students that are in the Financial Help program that have made payments over a certain amount\nCommand: studentsfinancialhelpoveramount <int amount>
      \nTo get recommendations to school programs based on the student's major\nCommand: recommendschoolprograms <student_id>
      \nTo get students that are researching a specified animal and are being monitored by a specified faculty member\nCommand: studentsreseachinganimalmonitoredby <animal_id> <faculty_id>
      \nTo get all the courses that are in the same city that the student is in\nCommand: coursesinstudentcity <student_id>"""
      return response
  return (msg + " Not a valid commmand")    
      

#Students in Waitlist that are also in the Student Course News Mailing_List
def notifiedWaitListedStudents():
  conn = connect()
  cursor = conn.cursor()

  cursor.execute('''SELECT student_id, first_name, last_name, email, Course.title, Course.section, email_address, content FROM Student
    INNER JOIN Waitlist ON Waitlist.student = Student.student_id
    INNER JOIN Sign_Up ON Sign_Up.student = Student.student_id
    INNER JOIN Mailing_List ON Mailing_List.mail_id = Sign_Up.mailing_list
    INNER JOIN Course ON Course.course_id = Waitlist.course
    WHERE Mailing_List.mail_id = 2''')

  conn.commit()
  data = cursor.fetchall()
  results = ''
  if data:
    for item in data:
      for key, value in item.items():
        if str (key) == "student_id":
          results = results + "\n\nStudent that will be notified is "
        elif str (key) == "title":
          results = results + "is waitlisting " + str (value)
        elif str (key) == "section":
          results = results + "-" + str (value)
        elif str (key) == "email_address":
          results = results + " is signed up to "
        #response += str(row)
        #print (results)
        if str (key) != "title" and str (key) != "section":
          results = results + str (value) + " "
  else:
    results = "Error: could not get data"    
  conn.close()  
  return results


#Find all the Courses where an Author of its required Books is also teaching the Course
def getAuthorsTeaching():
  conn = connect()
  cursor = conn.cursor()
  sql = '''SELECT course_id, course_title, course_section, Faculty_Member.first_name, Faculty_Member.last_name FROM 
	  (SELECT first_name AS author_first_name, last_name AS author_last_name, Course.course_id AS course_id,
    Course.title AS course_title, Course.section AS course_section FROM Author
    INNER JOIN Writes ON Writes.author = Author.author_id
    INNER JOIN Book ON Book.book_id = Writes.book
    INNER JOIN Requires ON Requires.book = Book.book_isbn
    INNER JOIN Course ON Course.course_id = Requires.course) sub,
  Faculty_Member
  WHERE author_first_name = Faculty_Member.first_name
  AND author_last_name = Faculty_Member.last_name; '''

  cursor.execute(sql)
  conn.commit()
  data = cursor.fetchall()
  results = ""
  if data:
    for item in data:
      results = results + "\n"
      for key, value in item.items():
        if str (key) == "course_title":
          results = results + " Course: "
        elif str (key) == "course_section":
          results = results + "-"
        elif str (key) == "first_name":
          results = results + " taught by "
        elif str (key) == "last_name":
          results = results + " "
          results = results + " " + str (value) + " is making bank" 
        if (str (key) != "last_name") and (str(key) != "course_id"):
          results = results + str (value)
  else:
    results = "Error: could not get data" 
  conn.close()
  return results


#Find the all the Bank Account Payments made that are greater than the total average sales of credit Card Payments
def getBankPaymentsGreaterThanCreditAvg():
  conn = connect()
  cursor = conn.cursor()
  sql = '''SELECT student, MAX(payment_id), MAX(Payment.amount) AS amount, total_credit_card_average FROM 
	  (SELECT AVG(Payment.amount) AS total_credit_card_average
    FROM Credit_Card
    INNER JOIN Payment ON Payment.payment_id = Credit_Card.payment) sub,
    Payment
  INNER JOIN Bank_Account ON Bank_Account.payment = Payment.payment_id
  GROUP BY Student, total_credit_card_average
  HAVING amount > total_credit_card_average
  ORDER BY amount ASC;   '''

  cursor.execute(sql)
  conn.commit()
  data = cursor.fetchall()
  results = ""
  if data:
    for item in data:
      results = results + "\n"
      for key, value in item.items():
        print("Id: ", key, value)
        if str (key) == "student":
          results = results + "Student ID "
        elif str (key) == "MAX(payment_id)":
          results = results + "made payment "
        elif str (key) == "amount":
          results = results + "of $"
        if str (key) != "total_credit_card_average":
          results = results + str (value) + " "
    results = results + "\nThe average payment amount with a Credit Card is " + str (value)    
  else:
    results = "Error: could not get data"   
  conn.close()
  return results


#Find Students that are enrolled in the Financial Help department that have made a payment over x amount
def studentsEnrolledInFinancialHelpMadePaymentOverAmount(passedAmount):
  conn = connect()
  cursor = conn.cursor()
  amount = int (passedAmount)
  sql = '''SELECT MAX(student_id), MAX(first_name), MAX(last_name), amount
  FROM Student
  INNER JOIN Payment ON Payment.student = Student.student_id
  INNER JOIN Attend ON Attend.student = Student.student_id
  INNER JOIN School_Program ON School_Program.program_id = Attend.school_program
  GROUP BY amount
  HAVING amount > %s; '''

  cursor.execute(sql, amount)
  conn.commit()
  data = cursor.fetchall()
  results = ""
  if data:
    for item in data:
      results = results + "\n"
      for key, value in item.items():
        print("Id: ", key, value)
        if str (key) == "MAX(student_id)":
          results = results + "Student "
        elif str (key) == "amount":
          results = results + "made payment of $"
        elif str (key) == "total_credit_card_average":
          results = results + " greater than the credit card average of $"
        results = results + str (value) + " "
  else: 
    results = "No student made a payment over " + passedAmount
  conn.close()
  return results


#Find all the School Programs that belong to the same Departments that a Student is Majoring in.
def recommendedSchoolPrograms(student_id):
  conn = connect()
  cursor = conn.cursor()
  sql = '''SELECT first_name, last_name, Department.name, School_Program.program_id, School_Program.name AS program_name  FROM
	  (SELECT DISTINCT Department.department_id AS majoring_departments, Student.first_name AS first_name, Student.last_name AS last_name FROM Department
    INNER JOIN Major ON Major.department = Department.department_id
    INNER JOIN Student ON Student.student_id = Major.student
    WHERE student_id = %s) sub,
  Department
  INNER JOIN School_Program ON School_Program.department = Department.department_id
  WHERE Department.department_id = majoring_departments; '''
  cursor.execute(sql, student_id)
  conn.commit()
  data = cursor.fetchall()
  results = ""
  if data: 
    for item in data:
      results = results + "\n \n"
      for key, value in item.items():
        print("Id: ", key, value)
        if str (key) == "first_name":
          results = results + "For student "
        elif str (key) == "name":
          results = results + " majoring in department "
        elif str (key) == "program_id":
          results = results + " would be a good idea to sign up to school program"
        results = results + " " + str (value) + " "
  else: 
    results = "No school programs to recommend"
  conn.close()
  return results


#Find all Students that are being monitored by a certain Faculty Member and are researching a certain Animal.
def studentResearchingAnimalMonitoredBy(animal, monitor):
  conn = connect()
  cursor = conn.cursor()
  sql = ''' SELECT Student.first_name AS student_first_name, Student.last_name AS student_last_name, Animal.animal_id,
   Animal.name AS animal_name,Animal.animal_type, Faculty_Member.first_name AS faculty_first_name, Faculty_Member.last_name FROM Student
  INNER JOIN Research ON Research.student = Student.student_id
  INNER JOIN Faculty_Member ON Faculty_Member.faculty_id = Student.monitor
  INNER JOIN Animal ON Animal.animal_id = Research.animal
  WHERE Animal.animal_id = %s
  AND  Student.monitor = %s; '''
  cursor.execute(sql, (animal, monitor))
  conn.commit()
  data = cursor.fetchall()
  results = ""
  if (data):
    for item in data:
      results = results + "\n\n"
      for key, value in item.items():
        print("Id: ", key, value)
        if str (key) == "student_first_name":
          results = results + "Student "
        elif str (key) == "animal_id":
          results = results + " is researching animal "
        elif str (key) == "animal_type":
          results = results + " which is a "
        elif str (key) == "faculty_first_name":
          results = results + " and is being monitored by "
        results = results + str (value) + " "
  else:
    results = "Data not found with those parameters"
  conn.close()
  return results


#Find courses that a student is able to take that are located in the same city
def coursesForStudentInTheirCity(student):
  conn = connect()
  cursor = conn.cursor()
  sql = '''SELECT title, section, Time_Slot.start_time, Time_Slot.end_time, classroom, City.name FROM Course
INNER JOIN City ON City.city_id = Course.city
INNER JOIN Student ON Student.city = City.city_id
INNER JOIN Time_Slot ON Time_Slot.time_slot_id = Course.time_slot
WHERE Student.student_id = %s; '''
  cursor.execute(sql, student)
  conn.commit()
  data = cursor.fetchall()
  results = ""
  if (data):
    for item in data:
      results = results + "\n\n"
      for key, value in item.items():
        print("Id: ", key, value)
        if str (key) == "title":
          results = results + "Course " + str (value)
        elif str (key) == "section":
          results = results + "-"
        elif str (key) == "start_time":
          results = results + " starts at "
        elif str (key) == "end_time":
          results = results + " ends at "
        elif str (key) == "classroom":
          results = results + " in the room "
        elif str (key) == "name":
          results = results + " and is located in "
        if str (key) != "title":
          results = results + str (value) + " "
  else:
    results = "No courses found with that student"

  conn.close()
  return results