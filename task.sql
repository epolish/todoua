-- get all statuses, not repeating, alphabetically ordered
SELECT DISTINCT status FROM tasks
ORDER BY status;

-- get the count of all tasks in each project, order by tasks count descending 
SELECT project_id, COUNT(*) FROM tasks
GROUP BY project_id
ORDER BY 2 DESC;

-- get the count of all tasks in each project, order by projects names
SELECT projects.name, COUNT(*) FROM tasks
INNER JOIN projects ON tasks.project_id = projects.id
GROUP BY project_id
ORDER BY 1;

-- get the tasks for all projects having the name beginning with "N" letter 
SELECT t.id, t.name, t.status, t.project_id FROM tasks AS t
INNER JOIN projects ON t.project_id = projects.id
WHERE projects.name LIKE 'N%';

/*
  get the list of all projects containing the 'a' letter in the middle of the name, and
  show the tasks count near each project. Mention that there can exist projects without
  tasks and tasks with project_id=NULL 
*/
SELECT projects.name, COUNT(*) FROM tasks
INNER JOIN projects ON tasks.project_id = projects.id
WHERE projects.name LIKE '%a%'
GROUP BY project_id;

-- get the list of tasks with duplicate names. Order alphabetically
SELECT * FROM tasks
GROUP BY name
HAVING COUNT(*) > 1
ORDER BY name;

/*
  get the list of tasks having several exact matches of both name and status, from
  the project 'Garage'. Order by matches count
*/
SELECT t.id, t.name, t.status, t.project_id FROM tasks AS t
INNER JOIN projects ON t.project_id = projects.id
WHERE projects.name = 'Garage'
GROUP BY t.name, t.status
HAVING COUNT(*) > 1
ORDER BY COUNT(*);

/*
  get the list of project names having more than 10 tasks in status 'completed'. Order
  by project_id
*/
SELECT p.name FROM projects AS p
INNER JOIN tasks ON p.id = tasks.project_id
WHERE (
    SELECT COUNT(*) FROM tasks AS t
    WHERE t.project_id = p.id AND t.status = 'completed'
) > 10
GROUP BY p.name
ORDER BY p.id;