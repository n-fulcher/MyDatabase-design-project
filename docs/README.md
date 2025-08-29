# MyDatabase-design-project
## Project Overview  
This database was designed to track workouts, exercises, trainers, and fitness goals in an organized way.  
The schema uses junction tables (like trainer_clients, plan_exercises, and session_exercises) to handle many-to-many relationships, keeping the data clean and avoiding repeats. Keys and constraints link everything together so users, trainers, workout plans, and sessions connect properly.  
Sample data was added to test real use cases like logging sessions, tracking goals, and checking trainer-client progress.

## How to Run the Database

1. Open MySQL Workbench (or another SQL tool).  
2. Run create_tables.sql to set up the database and tables.  
3. Run (in this order) the load scripts to add sample data:  
   - load_users.sql  
   - load_trainers.sql  
   - load_exercises.sql  
   - load_sessions.sql  
4. Run views.sql to create the views.  
5. Run sample_queries.sql to try out some example queries.  

## Example Queries

A few examples included in sample_queries.sql:

- User sessions in February 2025  
  Shows one user’s workouts in a date range and counts up total reps.  

- Trainer’s clients and last workout  
  Lists a trainer’s clients and the most recent session each one logged.  

- Top 5 most common exercises  
  Ranks which exercises show up the most in the session data.  

- User goals and progress  
  Displays each user’s goal, progress status, and how many sessions they logged during that goal’s time period.  

## SQL Scripts

- create_tables.sql – builds all tables, keys, and constraints  
- insert_users_trainers.sql – loads sample users and trainers  
- insert_exercises.sql – loads 40 sample exercises  
- load_sessions.sql – inserts workout sessions and session exercises  
- insert_goals_plans.sql – adds goals, workout plans, and plan exercises  
- create_views.sql – defines views for goals and trainer-clients  
- sample_queries.sql – test queries to check data and relationships  
