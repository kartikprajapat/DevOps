Identity: Every component in BC gets an identity, which is a proof that component belongs to the BC n/w.

Principal: Collection of Identities. They decides the permissions associated with the identities.

MSP (Membership Service Provider): This tells us that the Identity is valid or not. It has all the rules that define identity is valid or not. This is a Trusted Athority.

Simple scenario to know about Identity and its use:
Suppose we went to the supermarket for buying something. The there are only two types of cards that are accepted. The cards other than these are not acceped.

PKI is the athority that makes all types of cards(certificates) and MSP selects from them and adds them to the blockchain network.
MSP is the subset of PKI.
So Idebtities are those members which has been first verfied by PKI and then selected by MSP to get into the blockchain network.


What are PKIs?
PKI (Public key infrastructure) is the collection of internet technologies that provides secure communication on n/w.
When we do any transaction in BC then that transaction must be secure. So PKI must be useful over there.
PKI verifies everyting on N/W. If someone has opened some webpage then PKI is responsible for 's' in https, PKI is responsible for the content loaded on that page is from the certified and correct provider.

Components of PKI:
1. CA

2. CRL

3. Principal

4. Digital Certificate: They are made using the attributes of the holder of the certificate. Say, Merry is the name of the holder, so here a document will be created by using diff attributes of merry. These attributes first gets converted into some other secure form using CRYPTOGRAFY because in future if someone(hacker) do some changes in the certificate than the certificate will become invalid automatically.
This is like Adhar card, marry can use this DC(Digital Certificate) and show it to anyone to show her Identity. Now here this identity is valid only if the third party trusts CA or not. If not then this DC is not valid.

Please make a note that Merry's Public key is used to make DC not the private key.

5. Public and private keys: Marry signs her document with her private key and sends it over n/w. The reciever recieves the message in the cryptographic form and recreates the origional one using Merry's Public key.

The Private and public keys are made such like that the same message can be signed and retrived in origional form only when there is no tempring of message in b/w. If there is some change in the message in n/w public key will not decode it and discard it.

Principal is the collection of Identites that want to get authorised from CA, they send REQUEST to get cetificates to CA. CA then responds back with RESPONSE CERTIFICATE. When CA sends certificates to the Principal then the Identitty becomes certified.
Digital certificate than is allocated to the identuity.
CRL is the Certificate Revocation List that is a collection of revocated certificates which are no more valid.

BC is the n/w that is way more than the just communication n/w. It reqires all of its identities to be verified as per PKI standards.


# CA
Trusted athority, they provide certificate to the actors of BC n/w. If someone trust CA than they could trust the actor also.
Some of the tusted CAs are GeoTrust, Godaddy, Symantec, etc.
In blockchain every actor that want to be the part of the BC n/w needs an Identity which is again issued by CAs. 

# Root CA, Intermediate CA and Chain of trust
Root CA are the ones that provide the origional certificate (GeoTrust, Symantec, etc), but intermediate certificates came into existance when the BC kind of n/w is introduced. To increase the security of root CA they are hidden form the end user, the end user just only knows about the intermediate CA. There could be multiple intermediate CAs in this chain. This makes the CHAIN OF TRUST. This means if intermediate CA becomes traitor then the COT is broken and it will be reported in BC n/w, which will eventually is more secure than only trusting on root CA.

yellow certs -> green -> bule -> grey...... makes COT.


# Fabric CA
As we know that CA are very imp part, thats why Fabric n/w has its own CA. This CA provides certificates to the BC n/w. The certificates are then used by actors to get identity so that they can do transactions in the blockchain n/w. These certificates can not be used like the Root CA's certificate for browser and all. Rather they are limited for the BC n/w only.



# Certificate revocation list
The reference to the revoked certificates goes to this list. When one party wants to make trust with second party using second party's certificates then the first party goes to the CA and checks its CRL to check whether the certificates are expired or not. The second party have no mandation to check CRL but for security purpose it is recommended for them to do so.

NOTE: The Revoked certificates are not the ones which are expired ones. They both are different.


# Conclusion on CA and Identity
1. We use CA for certification of the actors.
2. BC has its own CA, whose certificates can be used within its network only.
3. Root CA with intermediate CAs makes the Chain of trust.
4. When certificates are assigned with the actors, they gets the identity.
5. The revoked certificates goes to the CRL.
6. Revoked and Expired certificates are diff.
7. When the actors gets the identity it is decided by MSP that which actors will be the part of BC n/w.


Further go to MSP for detail.
