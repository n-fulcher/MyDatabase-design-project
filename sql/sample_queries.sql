USE fitness_log;

-- Query 1: all workout sessions for a user in February 2025, with total reps
SELECT
  workout_sessions.session_id,
  workout_sessions.session_dt,
  workout_sessions.workout_type,
  workout_sessions.duration_min,
  IFNULL(SUM(session_exercises.sets * session_exercises.reps), 0) AS total_reps
FROM workout_sessions
LEFT JOIN session_exercises 
  ON session_exercises.session_id = workout_sessions.session_id
WHERE workout_sessions.user_id = 1
  AND workout_sessions.session_dt BETWEEN '2025-02-01' AND '2025-02-28'
GROUP BY workout_sessions.session_id
ORDER BY workout_sessions.session_dt;

-- Query 2: clients of trainer 5 and their last workout date
SELECT
  trainer_clients_view.trainer_id,
  trainer_clients_view.trainer_name,
  trainer_clients_view.user_id,
  trainer_clients_view.user_name,
  MAX(workout_sessions.session_dt) AS last_workout
FROM trainer_clients_view
LEFT JOIN workout_sessions 
  ON workout_sessions.user_id = trainer_clients_view.user_id
WHERE trainer_clients_view.trainer_id = 5
GROUP BY trainer_clients_view.trainer_id, trainer_clients_view.trainer_name, 
         trainer_clients_view.user_id, trainer_clients_view.user_name;

-- Query 3: top 5 most used exercises
SELECT
  exercises.exercise_id,
  exercises.exercise_name,
  COUNT(*) AS times_used
FROM session_exercises
JOIN exercises ON exercises.exercise_id = session_exercises.exercise_id
GROUP BY exercises.exercise_id, exercises.exercise_name
ORDER BY times_used DESC
LIMIT 5;

-- Query 4: goals with number of sessions during their timeframe
SELECT
  user_goals_view.user_id,
  user_goals_view.user_name,
  user_goals_view.goal_id,
  user_goals_view.target_goal,
  user_goals_view.progress,
  user_goals_view.start_date,
  user_goals_view.end_date,
  user_goals_view.days_left,
  COUNT(workout_sessions.session_id) AS session_count
FROM user_goals_view
LEFT JOIN workout_sessions
  ON workout_sessions.user_id = user_goals_view.user_id
 AND workout_sessions.session_dt BETWEEN user_goals_view.start_date AND user_goals_view.end_date
GROUP BY user_goals_view.user_id, user_goals_view.goal_id;
