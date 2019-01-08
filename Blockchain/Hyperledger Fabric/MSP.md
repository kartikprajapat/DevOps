# What is MSP?

Membership service provider. 

Organisation: Member of a trust Domain
When CA gives identities to actors MSP decides which one to include in BC. MSP first checks the Root CA and then intermediate for getting info about the Chain of Trust. After doing so it creates a member of trust domain which is called ORGANISATION.

Other than deciding that which actors can be the part of BC n/w, MSP also decides that what are the permissions associated with that actor.
The permission can be decided on two level:
    1. At organisation level (admin of org, member of org, member of sub-org group, etc)
    2. At BC n/w level (channel admins, reader, writer, etc)

There can be two types of MSP:
    1. Channel MSP
    2. Local MSP: This is holded by the individual components of BC n/w, like peer, orderer, client. This can be used for e.g. that who has the permission to install chaincode on the peer or who is not.
    
    



# Mapping MSP to organisation

An organisation is the collection of members in BC, this could be as big as a MNC corporation or this could be as small as flower shop. Every orgainisation must have alteast one MSP mapped to it.
We generally name the MSP as per the org with which it is associated, like if the organisation name is "ORG1" then its MSP could be named as "ORG1-MSP".

In some scenarios we could also have a need to have muliple MSPs attached to a single org. This could be a case when some org want to sell it specific products in State spaecific, some of them Nationally and some of them Internationally. In that case we could have 3 MSPs one for State, sec for Nation, Third for International. This eventually forms a Oganisational group which we mentioned earlier.


# Organisatioal Units and MSPs

