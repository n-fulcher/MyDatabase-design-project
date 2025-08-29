USE fitness_log;

-- View: show each user with their goals and days remaining
CREATE VIEW user_goals_view AS
SELECT
  users.user_id,
  users.name AS user_name,
  fitness_goals.goal_id,
  fitness_goals.start_date,
  fitness_goals.end_date,
  fitness_goals.target_goal,
  fitness_goals.progress,
  DATEDIFF(fitness_goals.end_date, CURDATE()) AS days_left
FROM users
JOIN fitness_goals ON fitness_goals.user_id = users.user_id;

-- View: show which users belong to each trainer
CREATE VIEW trainer_clients_view AS
SELECT
  trainers.trainer_id,
  trainers.name  AS trainer_name,
  users.user_id,
  users.name  AS user_name,
  users.email
FROM trainer_clients
JOIN trainers ON trainers.trainer_id = trainer_clients.trainer_id
JOIN users    ON users.user_id    = trainer_clients.user_id;
