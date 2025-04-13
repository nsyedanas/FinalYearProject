create database job__finder;
use job__finder;
CREATE TABLE skills(
	skill_id INT AUTO_INCREMENT PRIMARY KEY,
    skill_name VARCHAR(255) UNIQUE NOT NULL
    );
    
 CREATE TABLE passout_years (
    year_id INT AUTO_INCREMENT PRIMARY KEY,
    year INT UNIQUE NOT NULL
);

CREATE TABLE edu_qualifications(
	qualification_id INT AUTO_INCREMENT PRIMARY KEY,
    qualification_name VARCHAR(255) UNIQUE NOT NULL
    );
    
CREATE TABLE edu_streams(
	stream_id INT AUTO_INCREMENT PRIMARY KEY,
    stream_name VARCHAR(255) UNIQUE NOT NULL
    );
       
CREATE TABLE experiences(
	experience_id INT AUTO_INCREMENT PRIMARY KEY,
	experience_label VARCHAR(50) NOT NULL, -- e.g., 'Fresher', '2 Years', '3+ Years'
	experience_min INT NOT NULL,          -- e.g., 0, 2, 3
	experience_max INT                    -- NULL for 3+ years
);

CREATE TABLE experience_fields (
    field_id INT AUTO_INCREMENT PRIMARY KEY,
    field_name VARCHAR(100) NOT NULL UNIQUE -- e.g., Java, Full Stack Development
);


CREATE TABLE locations (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    state VARCHAR(100) NOT NULL,
    city VARCHAR(100) DEFAULT NULL  -- NULL means the whole state
);

-- master tables
CREATE TABLE jobs(
    job_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    company VARCHAR(255) NOT NULL,
    description TEXT,        
    posted_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
 
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    resume_path VARCHAR(500),     
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- mapping tables
CREATE TABLE job_skills(
	job_id INT NOT NULL,
    skill_id INT NOT NULL,
    PRIMARY KEY (job_id,skill_id),
    FOREIGN KEY (job_id) REFERENCES jobs(job_id) ON DELETE CASCADE,
    FOREIGN KEY (skill_id) REFERENCES skills(skill_id) ON DELETE CASCADE
); 

CREATE TABLE job_passout_years(
    job_id INT,
    year_id INT,
    PRIMARY KEY (job_id, year_id),
    FOREIGN KEY (job_id) REFERENCES jobs(job_id) ON DELETE CASCADE,
    FOREIGN KEY (year_id) REFERENCES passout_years(year_id) ON DELETE CASCADE
);


CREATE TABLE job_experiences(
    job_id INT NOT NULL,
    field_id INT NOT NULL,
    experience_id INT NOT NULL,

    PRIMARY KEY (job_id, field_id),
    FOREIGN KEY (job_id) REFERENCES jobs(job_id) ON DELETE CASCADE,
    FOREIGN KEY (field_id) REFERENCES experience_fields(field_id) ON DELETE CASCADE,
    FOREIGN KEY (experience_id) REFERENCES experiences(experience_id) ON DELETE CASCADE
);


CREATE TABLE job_edu_eligibility (
    job_id INT,
    qualification_id INT,  -- BE, ME, MSc, etc.
    stream_id INT,         -- CSE, IT, ECE, etc.
    FOREIGN KEY (job_id) REFERENCES jobs(job_id) ON DELETE CASCADE,
    FOREIGN KEY (qualification_id) REFERENCES edu_qualifications(qualification_id),
    FOREIGN KEY (stream_id) REFERENCES edu_streams(stream_id),
    PRIMARY KEY (job_id, qualification_id, stream_id)
);

CREATE TABLE job_locations (
    job_id INT,
    location_id INT,
    PRIMARY KEY (job_id, location_id),
    FOREIGN KEY (job_id) REFERENCES jobs(job_id) ON DELETE CASCADE,
    FOREIGN KEY (location_id) REFERENCES locations(location_id) ON DELETE CASCADE
);

CREATE TABLE user_locations (
    user_id INT NOT NULL,
    location_id INT NOT NULL,
    PRIMARY KEY (user_id, location_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (location_id) REFERENCES locations(location_id) ON DELETE CASCADE
);

CREATE TABLE user_skills (
    user_id INT NOT NULL,
    skill_id INT NOT NULL,
    PRIMARY KEY (user_id, skill_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (skill_id) REFERENCES skills(skill_id) ON DELETE CASCADE
);

CREATE TABLE user_experiences (
    user_id INT NOT NULL,
    field_id INT NOT NULL,
    years_of_experience INT NOT NULL,

    PRIMARY KEY (user_id, field_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (field_id) REFERENCES experience_fields(field_id) ON DELETE CASCADE
);


CREATE TABLE user_projects (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    project_title VARCHAR(255) NOT NULL,
    project_description TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE user_certifications (
    cert_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    cert_name VARCHAR(255) NOT NULL,
    cert_description TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

use job__finder;
CREATE TABLE user_educations (
    user_id INT,
    qualification_id INT,
    stream_id INT,
    PRIMARY KEY (user_id, qualification_id, stream_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (qualification_id) REFERENCES edu_qualifications(qualification_id),
    FOREIGN KEY (stream_id) REFERENCES edu_streams(stream_id)
);

alter table users add column passout_year int;
alter table users modify column created_at timestamp default current_timestamp;
alter table jobs modify column posted_date timestamp default current_timestamp;

