# C =  Completed
# P = Progression
# NYP = Not Yet Plan
# Tasks list
- application flow tested end to end manually[c]

- create infra structure for hosting 3-tier application on aws services[c]
    - terraform modules need to develop and tested for application[c]
    - acm module for creating certificates[c]
    - iam module for creating required iam roles and attachments[c]
    - vpc for networking[c]
    - security group module[c]
    - ec2 module[c]
    - elastic cache module[c]
    - rds module[c]
    - ALB module[c]
    - ASG module[c]
    - Cloud front module[c]
- prometheus and grafana alert manager setup[p]
  - launch ec2 machine
  - write ansible playbooks to install prometheus,grafana,alert manager
  - ansible playbooks to install grafana dashboards
- elk stack setup[NYP]
  - launch ec2 machine
- CI/CD pipeline for blue-green deployments[NYP]








- develop ansible role for backend and frontend
