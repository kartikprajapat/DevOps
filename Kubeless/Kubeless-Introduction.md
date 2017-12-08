# KUBELESS


This is the plugin that works with kubernetes to deploy and manage the server less applications.
The server less framework are diff from the application framework as they manages the :
	Code by themselves like as the infrastructure do  &
	Supports the multiple languages like nodjs, ruby, etc.

# Main concepts in Kubeless:

	1. Function:
		 They are merely the code and is an independent unit like the running microservice within the kubernetes cluster. They are used for performing some jobs like Saving data to the DB, Processing the any file in DB, 		etc.
	2. Events:
		Used for triggering the events within the kubeless.
	3. Services: 
		Functions and events are bundled together within the service. Its not like the Kubernetes’s service. This is the yaml or json service.

	# serverless.yml
	
	service: users
	
	functions: # Your "Functions"
  		usersCreate:
    		handler: hello.hello # The code to call as a response to the event
    		events: # The "Events" that trigger this function
      	- http: 
        	      path: /hello
	

All we have to do to deploy the above is server less deploy, everything in the above file will be deployed at once.

