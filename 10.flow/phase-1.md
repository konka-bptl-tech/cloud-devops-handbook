# 3-tier application setup on AWS

1. AWS services
   - vpc
   - sg
   - iam
   - r53
   - s3
   - asg
   - elb
   - parameter store
   - secrets manager
   - elastic cache
   - rds[mysql]
   - cloudfront

2. infra creation using terraform
3. AMI build using packer
4. Ansible roles for configuration
   - backend AMI build
   - frotend AMI build
5. CI/CD pipelines for automating the deployment
6. Monitoring[Prometheus&Grafana]
7. Centralized Logging with EFK