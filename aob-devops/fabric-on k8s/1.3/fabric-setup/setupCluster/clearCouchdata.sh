#!/bin/sh
curl -X DELETE http://<username>:<password>@erp-couch-public-262842995.us-west-1.elb.amazonaws.com:5984/mychannel_
curl -X DELETE http://<username>:<password>@erp-couch-public-262842995.us-west-1.elb.amazonaws.com:5984/mychannel_aob-erp-inventory-mgmt
curl -X DELETE http://<username>:<password>@erp-couch-public-262842995.us-west-1.elb.amazonaws.com:5984/mychannel_aob-labs
curl -X DELETE http://<username>:<password>@erp-couch-public-262842995.us-west-1.elb.amazonaws.com:5984/mychannel_aob-sales-invoice
curl -X DELETE http://<username>:<password>@erp-couch-public-262842995.us-west-1.elb.amazonaws.com:5984/mychannel_lscc

