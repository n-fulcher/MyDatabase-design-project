-- create database and tables
CREATE DATABASE IF NOT EXISTS fitness_log;
USE fitness_log;

CREATE TABLE users (
  user_id    INT PRIMARY KEY,
  name       VARCHAR(100) NOT NULL,
  email      VARCHAR(255) NOT NULL UNIQUE,
  phone      VARCHAR(25),
  age        INT,
  weight_lb  INT
);

CREATE TABLE trainers (
  trainer_id INT PRIMARY KEY,
  name       VARCHAR(100) NOT NULL,
  phone      VARCHAR(25),
  email      VARCHAR(255) NOT NULL UNIQUE,
  expertise  VARCHAR(100)
);

-- Junction table for trainer/client relationships
CREATE TABLE trainer_clients (
  trainer_id INT NOT NULL,
  user_id    INT NOT NULL,
  PRIMARY KEY (trainer_id, user_id),
  FOREIGN KEY (trainer_id) REFERENCES trainers(trainer_id),
  FOREIGN KEY (user_id)    REFERENCES users(user_id)
);

CREATE TABLE exercises (
  exercise_id      INT PRIMARY KEY,
  exercise_name    VARCHAR(100) NOT NULL,
  muscle_group     VARCHAR(50)  NOT NULL,
  equipment_needed VARCHAR(100) NOT NULL
);

CREATE TABLE fitness_goals (
  goal_id     INT PRIMARY KEY,
  user_id     INT NOT NULL,
  start_date  DATE NOT NULL,
  end_date    DATE NOT NULL,
  target_goal VARCHAR(255) NOT NULL,
  progress    ENUM('On Track','Ahead','Behind Schedule') NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE workout_plans (
  plan_id   INT PRIMARY KEY,
  plan_name VARCHAR(100) NOT NULL,
  user_id   INT NOT NULL,
  goal_text VARCHAR(255) NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE plan_exercises (
  plan_id     INT NOT NULL,
  exercise_id INT NOT NULL,
  target_sets INT,
  target_reps INT,
  notes       VARCHAR(255),
  PRIMARY KEY (plan_id, exercise_id),
  FOREIGN KEY (plan_id)     REFERENCES workout_plans(plan_id),
  FOREIGN KEY (exercise_id) REFERENCES exercises(exercise_id)
);

CREATE TABLE workout_sessions (
  session_id    INT PRIMARY KEY,
  user_id       INT NOT NULL,
  session_dt    DATE NOT NULL,
  workout_type  VARCHAR(50) NOT NULL,
  duration_min  INT,
  notes         VARCHAR(255),
  plan_id       INT NULL,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (plan_id) REFERENCES workout_plans(plan_id)
);

CREATE TABLE session_exercises (
  session_id   INT NOT NULL,
  exercise_id  INT NOT NULL,
  sets         INT NOT NULL,
  reps         INT NOT NULL,
  weight_used  INT NOT NULL,
  intensity    ENUM('Low','Medium','High') NOT NULL,
  PRIMARY KEY (session_id, exercise_id),
  FOREIGN KEY (session_id)  REFERENCES workout_sessions(session_id),
  FOREIGN KEY (exercise_id) REFERENCES exercises(exercise_id)
);
