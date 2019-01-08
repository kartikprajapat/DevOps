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


