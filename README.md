To "start" the project:
0. install linux, ruby, rails, bundler, etc...
1. clone repo
<b>https://github.com/VitaliyLazebny/task_manager.git</b>
2. enter directory
<b>cd task_manager</b>
3. install all necessary gems:
<b>bundler install</b>
4. execute migrations
<b>rails db:migrate</b>
5. start server
<b>rails s</b>
6. open app in browser (defails url: <b>http://0.0.0.0:3000</b>)

To execute tests do:
<b>rspec</b>

<h1>Task manager</h1>
I'm a person who passionate about own productivity. I want to manage my tasks and projects more effectively. I need simple tool that support me in controlling my task-flow.<br />

Functional requirements:<br />
● I want to be able to create/update/delete projects<br />
● I want to be able to add tasks to my project<br />
● I want to be able to update/delete tasks<br />
● I want to be able to prioritize tasks into a project<br />
● I want to be able to choose deadline for my task<br />
● I want to be able to mark a task as 'done'<br />

Technical requirements:<br />
● It should be WEB application<br />
● For the client side must be used: HTML, CSS (any libs as Twitter Bootstrap, Blueprint ...), JavaScript (any libs as jQuery, Prototype ...)<br />

Additional functionality:<br />
● It should have user authentication solution and a user should only have access to their own projects and tasks.<br />
● It should have automated tests for all functionality.<br />
