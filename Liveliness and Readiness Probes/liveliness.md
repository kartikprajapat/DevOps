This is used to check periodically that the service is running perfectly or not, it will periodically make the http request to the service (using the internal Ip provided by kubernetes and the TargetPort of the service) and wait for the response. If the response comes below 400 then it means that service is in the running state otherwise if the response is above 400 then the probe will restart the pod till particular number of time and after that if the error is not resolved then the Liveliness error will be thrown.


# Add below fields in the deployment file to enable liveliness probe:

            livenessProbe:
              httpGet:
                path: /payment-service/info
                port: 8305
              initialDelaySeconds: 10
              periodSeconds: 10

        # Here the port is TargetPort on which the service is running.