This is one of the key concept Node brings to JS.

Node follows the Non-blocking event driven approach, which means multiple events can come to node simultaneously and node can execute them easily.
For e.g.: There is a web application that fetches data from the DB... Web App----------DB, Say if some Http req comes to the web application it generates an event, node sends the query to the DB and waits for the response. When DB send the response back then it acts as another event to the nodeJS event loop and it gets stored over here. After that a HTTP response is then sent in the response for the HTTP req which came previously.
The main point to note here is while the time node was waiting for the DB to respond for the request, Node was not sitting Idle, it could handle the other events also meanwhile.
