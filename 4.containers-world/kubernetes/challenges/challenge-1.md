# Migrate Ingress from Ingress controller to Gateway to manage North-South Traffic
















---
### Migration & Design Questions
1. Why did you decide to migrate from IngressController to Gateway API?
2. What were the main challenges you faced during the migration?
3. How did you ensure that north-south traffic worked correctly after migration?
4. Can you explain the separation of concerns between Gateway API and IngressController in your cluster?
5. Which protocols are handled by Gateway API and which by IngressController?
6. How did you test the migration to make sure it didn’t break existing services?
7. Did you face any performance improvements or drawbacks after the migration?
8. How did you handle security (TLS, mTLS) after moving to Gateway API?
9. Can you describe a situation where Gateway API was necessary and IngressController alone couldn’t handle it?
10. How did you handle the deployment—was it gradual (blue-green/canary) or all at once?
