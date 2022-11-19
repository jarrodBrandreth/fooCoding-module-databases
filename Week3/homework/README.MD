- Make sure you have todo_database created

- node index.js [YourMysqlPassword] to start server connected to todo_database on localhost

- test with postman

enpoints

to set user
post /user with "name":value in JSON format in request body

to get users list
get /lists with "name":value in JSON format in request body

to delete item in list
delete /deleteItem with "task_id":value in JSON format in request body

to delete list  
delete /deleteList with "list_id":value in JSON format in request body

to create list
put /createList with user_id:value, list_name:value in JSON format in request body

to insert item in to do list
put /insertItem with list_id:value, item:value in JSON format in request body

to mark task as completed
put /completed with completed:1 for true 0 for false, task_id:value in JSON format in request body
