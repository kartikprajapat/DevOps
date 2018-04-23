# There are multiple reasons of weave network getting restarted:

1. Weave pod gets restarted multiple times because of docker. Due to heavy load on the machines the docker daemon sometimes gets overloaded, aftereffect of this results in the restarts of multiple containers include weave.

2. Sometimes kubernetes nodes gets not ready or went to the deadlock state due to which weave pods not able to discover each other. In this scenario kubernetes restarts the weave pod so that if the node comes back to the ready state again then pods should discover each other without the manual deletion of weave pod.