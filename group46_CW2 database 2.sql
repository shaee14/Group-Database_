CREATE DATABASE group46;


CREATE TYPE dep_type AS ENUM ('Mathematics', 'Computing', 'Humanities', 'Arts');
CREATE TABLE DEPARTMENT (
    department_id SERIAL PRIMARY KEY,
    department_type DEP_TYPE NOT NULL,
    department_name VARCHAR(20) NOT NULL
);

INSERT INTO DEPARTMENT (department_id, department_type, department_name) VALUES 
(1, 'Computing', 'Technology'),
(2, 'Humanities', 'History'),
(3, 'Arts', 'Drama');

CREATE TABLE SUBJECT (
    subject_id SERIAL PRIMARY KEY,
    department_id INT NOT NULL,
    subject_Name VARCHAR(30) NOT NULL,
    FOREIGN KEY (department_id) REFERENCES DEPARTMENT(department_id)
);

INSERT INTO SUBJECT (subject_id, department_id, subject_Name) VALUES
(1, 1, 'Mathematics'),
(2, 1, 'Chemistry'),
(3, 2, 'World History');

CREATE TABLE STAFF (
    staff_id SERIAL PRIMARY KEY,
    head_of_department BOOLEAN NOT NULL,
    first_name VARCHAR(30) NOT NULL,
    middle_name VARCHAR(30) NULL,
    last_name VARCHAR(30) NOT NULL
);

INSERT INTO STAFF (staff_id, head_of_department, first_name, middle_name, last_name) VALUES
(1, true, 'Rodney', 'Bordie', 'Brown'),
(2, false, 'Haley', 'Nev', 'Pincas');

CREATE TABLE COURSE (
    course_id SERIAL PRIMARY KEY,
    subject_id INT NOT NULL,
    department_id INT NOT NULL,
    staff_id INT NOT NULL,
    course_name VARCHAR(30),
    FOREIGN KEY (subject_id) REFERENCES SUBJECT(subject_id),
    FOREIGN KEY (department_id) REFERENCES DEPARTMENT(department_id),
    FOREIGN KEY (staff_id) REFERENCES STAFF(staff_id)
);

INSERT INTO COURSE (course_id, subject_id, department_id, staff_id, course_name) VALUES
(1, 1, 1, 1, 'Computer Science'),   
(2, 2, 2, 2, 'Dentistry');   


CREATE TABLE STUDENT (
    student_id SERIAL PRIMARY KEY,
    first_Name VARCHAR(30) NOT NULL,
    middle_name VARCHAR(30) NULL,
    last_Name VARCHAR(30) NOT NULL,
    email VARCHAR(40) NOT NULL UNIQUE
);

INSERT INTO STUDENT (student_id, first_Name, middle_name, last_Name, email) VALUES
(1, 'James', 'Caleb', 'Samuel', 'james.samuel@multiply.com'),
(2, 'Raina', 'Tasha', 'Johnson', 'raina.johnson@science.com');

CREATE TYPE acad_level AS ENUM ('set 1', 'set 2', 'set 3', 'set 4');
CREATE TABLE SET (
    set_id SERIAL PRIMARY KEY,
    course_id INT NOT NULL,
    department_id INT NOT NULL,
    student_id INT NOT NULL,
    academic_level ACAD_LEVEL NOT NULL,
    FOREIGN KEY (course_id) REFERENCES COURSE(course_id),
    FOREIGN KEY (department_id) REFERENCES DEPARTMENT(department_id),
    FOREIGN KEY (student_id) REFERENCES STUDENT(student_id)
);

INSERT INTO SET (set_id, course_id, department_id, student_id, academic_level) VALUES
(1, 1, 1, 1, 'set 1'), 
(2, 2, 2, 2, 'set 2'); 


CREATE TABLE PARENT_GUARDIAN (
    parent_guardian_id SERIAL PRIMARY KEY,
    student_id INT NOT NULL,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    email VARCHAR(40) NOT NULL UNIQUE,
    phone_number VARCHAR(20) NOT NULL,
    FOREIGN KEY (student_id) REFERENCES STUDENT(student_id)
);

INSERT INTO PARENT_GUARDIAN (parent_guardian_id, student_id, first_name, last_name, email, phone_number) VALUES
(1, 1, 'Claudio', 'radin', 'claudio.radin@reddit.com', '1234567890'),
(2, 2, 'Karlylin', 'Johnson', 'Karlylin.johnson@digg.com', '9876543210');

CREATE TABLE SESSION (
    session_id SERIAL PRIMARY KEY,
    staff_id INT NOT NULL,
    no_Of_Students INT NOT NULL,
    next_session DATE NOT NULL,
    completed BOOLEAN NOT NULL,
    FOREIGN KEY (staff_id) REFERENCES STAFF(staff_id)
);

INSERT INTO SESSION (session_id, staff_id, no_Of_Students, next_session, completed) VALUES
(1, 1, 25, '2024-02-20', false),   
(2, 2, 20, '2024-03-15', true); 

CREATE TABLE ROLE (
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(40) NOT NULL
);

INSERT INTO ROLE (role_id, role_name) VALUES
(1, 'Head Teacher'),
(2, 'Teacher'),
(3, 'Administrator');

CREATE TABLE COUNTRIES (
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(20) NOT NULL,
    country_code INT NOT NULL
);

INSERT INTO COUNTRIES (country_id, country_name, country_code) VALUES
(1, 'United States', 1),
(2, 'United Kingdom', 44),
(3, 'Canada', 1),
(4, 'Australia', 61);

CREATE TABLE ATTENDANCE (
    attendance_id SERIAL PRIMARY KEY,
    student_id INT NOT NULL,
    session_id INT NOT NULL,
    attendance BOOLEAN NOT NULL,
    FOREIGN KEY (student_id) REFERENCES STUDENT(student_id),
    FOREIGN KEY (session_id) REFERENCES SESSION(session_id)
);

INSERT INTO ATTENDANCE (attendance_id, student_id, session_id, attendance) VALUES
(1, 1, 1, true),   
(2, 2, 2, false);


CREATE TABLE STAFF_SUBJECT (
    staff_id INT NOT NULL,
    subject_id INT NOT NULL,
    FOREIGN KEY (staff_id) REFERENCES STAFF(staff_id),
    FOREIGN KEY (subject_id) REFERENCES SUBJECT(subject_id)
);

INSERT INTO STAFF_SUBJECT (staff_id, subject_id) VALUES
(1, 1),  
(2, 2);

CREATE TYPE grade AS ENUM ('A*', 'A', 'B', 'C', 'D', 'E', 'F', 'U');
CREATE TABLE STUDENT_SUBJECT (
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    grade GRADE NOT NULL,
    FOREIGN KEY (student_id) REFERENCES STUDENT(student_id),
    FOREIGN KEY (subject_id) REFERENCES SUBJECT(subject_id)
);

INSERT INTO STUDENT_SUBJECT (student_id, subject_id, grade) VALUES
(1, 1, 'A'),    
(2, 2, 'B');

CREATE TABLE STUDENT_PARENT_GUARDIAN (
    student_id INT NOT NULL,
    parent_guardian_id INT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES STUDENT(student_id),
    FOREIGN KEY (parent_guardian_id) REFERENCES PARENT_GUARDIAN(parent_guardian_id)
);

INSERT INTO STUDENT_PARENT_GUARDIAN (student_id, parent_guardian_id) VALUES
(1, 1),   
(2, 2);

CREATE TABLE STAFF_DEPARTMENT (
    staff_id INT NOT NULL,
    department_id INT NOT NULL,
    FOREIGN KEY (staff_id) REFERENCES STAFF(staff_id),
    FOREIGN KEY (department_id) REFERENCES DEPARTMENT(department_id)
);

INSERT INTO STAFF_DEPARTMENT (staff_id, department_id) VALUES
(1, 1),    
(2, 2); 

CREATE TABLE STAFF_ROLE (
    staff_id INT NOT NULL,
    role_id INT NOT NULL,
    FOREIGN KEY (staff_id) REFERENCES STAFF(staff_id),
    FOREIGN KEY (role_id) REFERENCES ROLE(role_id)
);

INSERT INTO STAFF_ROLE (staff_id, role_id) VALUES
(1, 1),    
(2, 2);