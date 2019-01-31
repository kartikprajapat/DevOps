# WAF

Here we can manage the security of:

    1. Api gateway
	  2. ELB
	  3. CloudFront

We can create Rules, ACLs, Conditions on the basis of which the requests will come.
We define the conditions, convert those conditions to the rules and then rules to ACLs(Access control list).


Conditions:
	1. We could detect the malicious scripts that may harm the application, we call that as CROSS_SITE_SCRIPTING.
	2. We can also specify the IP add or the IP ranges which can access the app or not.
	3. Country or some location.
	4. Length of the request parameter.
	5. SQL code that can extract the data from our DB

Rules:
	We can  combine the conditions and make the rules. So that we could specify that what are the things that we need to allow and what to block or what to count.
	
	AWS WAF provides us the two types of rules:
	1. Regular 
	2. Rate based



		Regular:	
