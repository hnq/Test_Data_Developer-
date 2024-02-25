# MySQL Database Table Setup Scripts

This updated README includes the commands for running the bash script to set up Tableau Server and deploying Tableau Server using Docker, along with the instructions for creating MySQL tables.



This repository contains scripts to set up tables in a MySQL database.

## Part 1: Creating the Database

Run the following command to create the database:

```sql
CREATE DATABASE challenge;

Execute the SQL scripts to create the necessary tables in your MySQL database. These scripts are divided into four parts:

1_part.sql: Defines the structure for the weather data table.
2_part.sql: Defines an additional table needed for the project.
3_part.sql: Defines another new table as per the updated requirements.
4_part.sql: Adds a new column for temperature delta to the existing tables.

mysql -u your_username -p your_database_name < script_file.sql
SHOW TABLES;

Build the Docker image:
docker build -t tableau-server .

Run the Docker container:
docker run -d -p 80:80 -p 8850:8850 tableau-server

Running Tableau Server Bash Script
./tableau_installation_script.sh

