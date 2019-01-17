When we write code in this Non-Blocking asynchronous env, then we need to follow the different approach.

Here is the typical approach to write code:

    var conn = getDbConnection(connectionString);
    var stmt = conn.createStatement();
    var result = stmt.executeQuery(sqlQuery);
    for(var i=0; i<result.length; i++) {
    //print results[i]
    }
  
  
Here the main point to note is that each function returns a value before the next function is called. Here each statement is build on the result of the prior one.
First, we connect to the DB, then we use that connection to create a statement, from that statement we execute a query and gets back a set of results, finally we perform some iterations on that result.



Here is the approach of nodeJS (an asynchronous, "non blocking" approach)

    getDbConnection(connectionString, function(err, conn)){ //here the getDbConnection takes two parameters rather than the above one which takes only the single one, here the second parameter is a function which makes node independent in terms of execution, here the getDbConnection is called meanwhile when the getDbConnection is getting the connection from database, node is doing some other task. The function(the second parameter) is helping in this process, "function" acts as a CALLBACK funation that sends the result back to the getDbConnection once it is done, in the case there is some error then it returns error in err variable.
    
    conn.createStatement(function(err, stmt)){ //this works same as the above but the only difference is that here only callack function has been used as a parameter
    
    var results = stmt.executeQuery(sqlQuery); // this variable does not contains the result immidiately from the DB, it takes time to get response so we uses an approach called "EventEmitter"
    
    result.on('row', function(result)) { // this is the EventEmitter which is capable of emmiting events in future when each row of the query is available. 
        //print result
    });
    });
    });




# Some points to remember about callbacks:
           
    1. Error parameter should be the first parameterto the callback function
            
            var handleResults = function(error, results) {
                //some code
            }
     
     2. A callback function should be the last parameter to the function:
     
            getStuff(inputParam, handleResults); //here handleResults is the callback functions
