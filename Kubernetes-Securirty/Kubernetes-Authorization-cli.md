# First we have to generate the private key //1

openssl genrsa -out jakub.pem 2048


# and the certificate signing request //2

openssl req -new -key jakub.pem -out jakub.csr -subj "/CN=jakub"


# Signing the certificate //3

    we simply create a YAML file:
apiVersion: certificates.k8s.io/v1beta1
kind: CertificateSigningRequest
metadata:
  name: user-request-japs
spec:
  groups:
  - system:authenticated
  request: <output-of-step-4>
  usages:
  - digital signature
  - key encipherment
  - client auth
  
# copy the ouput given below and paste it above //4

cat jakub.csr | base64 | tr -d '\n'
  
  
# But Kubernetes won't sign the new user certificate just like that. They will wait for approval that this certificate can be really signed. That can be done again using kubectl:


kubectl certificate approve user-request-japs

"............BELOW COMMAND IS GIVEN WRONG IN THE VIDEO.....PLZ FOLLOW THIS ONE..........."


kubectl get csr user-request-japs --output=jsonpath={.status.certificate} | base64 -d > japs.crt

# Create new config file

cp kubelet.conf /home/admindss/user-account/japs-user.conf


# Rest steps are in video

                                    <https://www.youtube.com/watch?v=slUMVwRXlRo>
                                    <https://www.linkedin.com/pulse/adding-users-quick-start-kubernetes-aws-jakub-scholz>

