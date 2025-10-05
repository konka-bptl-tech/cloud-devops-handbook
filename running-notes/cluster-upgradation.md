once in every 3 month k8s comes with new version k8s only supports latest 3 version

It is responsibity of cloud and devops engineers to make sure k8s stack is upto date

k8s cluster in multiple environments unit,stage,pre-prod and prod we do it cluster upgradation very frequnetly

# Prerequisites
1. Cordon[unschedulable] the nodes no new deployment for 1-2 hours we stop it
2. Go through release notes need to understand the changelog what are the changes that maintain from 1.31 to 1.32
  - Earlier ingress api group was extensions/beta1 changed to networkin api group
  - API deprecations
Note: Once you upgrade the cluster you can not downgrade the cluster
Note: Before upgrading prod grade cluster always tested in lower environments first give 1 week time for each env testing then only move the prod if you're not doing this putting yourself in a huge risk
grace period for 2 weeks make sure lower env working seamlessly then only move to prod upgradation
3. both control plane and node group same k8s version
4. Make soure cluster auto scaler matches with the control plane other wise you will run into issues
5. Five avialable IP addresses for each subnet ensure during the cluster upgradation
6. kubelet also matches with the control plane

EKS - is a managed k8s they ensure HA and Scalability,Security,DR of COntrol Plane but not Control plane Upgradation


   
# Process

1. Upgrade the control plane via eksctl or UI
2. If you change upgrade via tf it will upgrade both control plane and ng at the same time this is not good it has downtime for applications
3. Create another nodegroup
4. Cordon the previous node group
5. Drain the workloads in previous nodegroup
6. upgrade the addons
6. Ensure sanity tests
7. Delete the previous ng

It would take 2 hours

If you have many worker nodes goto rollout strategy
If you less no of worker nodes goto blue-green strategy
If you're using force ful update when you're using PDB
cluster upgradation for EKS doc


After upgradation complete run the regression tests and functional tests