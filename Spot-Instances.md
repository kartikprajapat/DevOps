What are spot Instances?
Spot instances are available to us at steep discounts compared to On-Demand prices. EC2 Spot enables us to optimize our costs on the AWS cloud and scale our application's throughput up to 10X for the same budget. By simply selecting Spot when launching EC2 instances, we can save up-to 90% on On-Demand prices.
Spot instances can be interrupted by EC2 with two minutes of notification when EC2 needs the capacity back.

How it works:
 


Pros of using Spot instances with Kubernetes cluster:
•	Kubernetes has some in-built resiliency and fault toleration and that seems like a good fit with these instances. If a node is taken away, the Kubernetes cluster will survive, the pods that were running on that node will be rescheduled to other nodes and life can go on.
•	Low pricing as compared to on-demand ec2 instances.

Cons of using Spot instances with Kubernetes cluster:
Spot instance price changes very frequently, so we need some automation to look at the base price and reset the bid accordingly.

Things that should be kept in mind:
•	Spot instances in the cluster must be diversified to different spot markets because otherwise there is a big chance that (almost) all of the instances will be taken away at once. If there are 3 availability zones in the region, it means that one third of the instances can be terminated at once. With additional instance types, the chances of losing a large part of the cluster all at once can be minimized.
•	On the Kubernetes side it is true that the cluster should survive the loss of a node, but it can have some side effects. If there were unreplicated pods on the node that is taken away the related services can be unavailable for a while. If a node is terminated without notice, the pods may not be terminated gracefully.


How to automate the management of Spot instances?
There are many approaches to automate the management of Spot instances like:
•	Minion manager
•	Spot Fleet (Offered by AWS)

Minion Manager
Minion manager works as follows:
 

•	The minion-manager periodically checks if the desired number of instances are running in the ASG.
•	If the desired number of instances are not running, the minion-manager looks at the pricing information of both the on-demand and the spot instances. If at that point in time, the spot instance prices are less than on-demand instance prices, the minion-manager updates the launch-config with the spot-instance price. Otherwise, it will change the launch-config with the on-demand instance price.

Spot Fleet
AWS also offers Spot Fleet, which automates the management of Spot instances. You simply tell Spot Fleet how much capacity you need and Fleet does the rest.
There are two approaches of using Spot fleet:
1. LowestPrice
2. Diversified
LowestPrice
The Spot Instances come from the pool with the lowest price. This is the default strategy.
If your fleet is small or runs for a short time, the probability that your Spot Instances will be interrupted is low, even with all the instances in a single Spot Instance pool. Therefore, the lowestPrice strategy is likely to meet your needs while providing the lowest cost.
Diversified
The Spot Instances are distributed across all pools.
If your fleet is large or runs for a long time, you can improve the availability of your fleet by distributing the Spot Instances across multiple pools. For example, if your Spot Fleet request specifies 10 pools and a target capacity of 100 instances, the Spot Fleet launches 10 Spot Instances in each pool. If the Spot price for one pool exceeds your maximum price for this pool, only 10% of your fleet is affected. Using this strategy also makes your fleet less sensitive to increases in the Spot price in any one pool over time.
With the diversified strategy, the Spot Fleet does not launch Spot Instances into any pools with a Spot price that is equal to or higher than the On-Demand price.

Thanks,
Kamal
