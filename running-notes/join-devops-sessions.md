Company does not give CLI tools as it is they wrap up and given to you we are terraform enterprise

terraform workspaces is a isolated environment

In organization there is no admin access

In AWS we have organizations we can get the access via SSO

Roles - Adhere to follow lpa

I cannot create EC2 instance even a single ec2 instance

In Prod we have only read only access through UI Only thing that we have to via tf only

1. How do you optmize the costs of you application infra
- instance types
- decresing the containers in non business hours
- stop the servers non working hours
- use only when we needed
- use spot in test
Note: We don't do in prod env in lower envs we do that
Why becuase of HA for application 24/7 accessible

Task
----
I have 2 kinds of deployments one is normal deployment do via CLI and another one is via ArgoCD is it possible terminate those local deployment but it should not effect normal deployment

I did via k8s labels through I differentiate b/w them 

When Automated deployment is happend we need to remove manual deployment automatically I did via crohJob in k8

When I was deleteing pods via locally It was deleted when I was did via auotmation which are not deleted Why Becuase CronJob Does not have permissions to do it

2. How do you monitor your infra and application errors ?

For applications errors to get notfied we set alarm  I did via python script for example for 1m 1000 alerts how do you handle in this inbox is lot of alerts finally it's filled so we segragate the all the errors lets last 20 mins I will send in an single email if the error is repeasted I'll increase the count

3. How do you upgrade your infra ? in-place or destructive
- MongoDB Upgrade
- MSK Upgrade
- EKS Upgrade
- RDS Upgrade

All upgrades are done in non business hours[weekends,early-morning]

Highlander deployment[Approach]

Cluster-A[Previous Application Running]

Cluster-B[DeploySampleApplicationtotestDBConnections]

then only we migrate all other components to Cluster-B

Split the traffic 50% to old cluster 50% to new Cluster we would also observe the particular behaviour we would leave it for one day gradually increse the traffic flow to new cluster everything goes well we will remove old cluster

Why Becuase we did not have option do EKS Upgrade we must go through High lander approach they said 

3. Can we use terraform --auto-approve in organizatio? No Even if it is dev no
4. Is it possible to use your own modules in organization
No own modules concept in organization if you do need to take 100 of approvals need to do security checks is it okay to use or not all security guide lines all are passed if you do any enhancements download the code made the changes raise the PR

5. How do you handle secrets in your organization
- HV
- Secrets Manager

We have a rotation cycle[weekly,monthly,quarlty]

Becuase of secret rotation application got failed How can you remediate

We need implment the mechanism to restart deployment 

Event based approach as soon as secrets are rotated It trigger the lambda function to restasrt the deployment

Certificates also renewed

6. Will you use same AMI through out your project ? If not how do you handle it
Every week we do that or 15 days or 1,2 months

7. How do you ensure that your application infra is resiliant?
At any given point of time you application can be accessible
Multiple Regions and Multiple Az's

8. Will you use same module version through out your project? no
- new developments are happend there is an improvement performance enchancements,bug fixes

9. Will the commands that you runon dev work in the higher environements ? Yes 99.9999 Yes

10. Will we get a chance to to use terraoform CLI in Prod? NO

In DevOps Life Raising tickets is a daily task need to check

Incident management process While raising the ticket it can have severity level or priority level

P1 = 1 hour
P2 = 4 hours
P3 = 24 hours
P4 = 48 hours
P5 = 72 hours

If it is a p1 ticket we have bridge call
- all other teams also present
