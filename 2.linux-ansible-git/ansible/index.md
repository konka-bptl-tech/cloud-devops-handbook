# Ansible Learning Roadmap

## Legend:
- [ ] Not Started  
- [/] In Progress  
- [x] Completed  

---

## 1. What is Configuration Management
- [ ] Introduction to Configuration Management
- [ ] Benefits of Configuration Management
- [ ] Examples of CM tools (Ansible, Puppet, Chef, SaltStack)
- [ ] Why Ansible is agentless

## 2. Pull Based and Push Based Mechanism
- [ ] Pull-based vs Push-based explanation
- [ ] Examples: Puppet (pull) vs Ansible (push)
- [ ] How Ansible communicates with nodes over SSH

## 3. Ansible Configuration Files
- [ ] `ansible.cfg` basics
- [ ] Inventory files (static & dynamic)
- [ ] Hosts file structure
- [ ] Group variables & host variables
- [ ] Config precedence (CLI > env var > ansible.cfg)

## 4. Adhoc Commands
- [ ] Running simple commands on remote hosts
- [ ] Using modules in adhoc commands (ping, shell, copy, file)
- [ ] Targeting groups or specific hosts
- [ ] Checking return codes & output formatting

## 5. Playbooks
- [ ] YAML basics (syntax, indentation)
- [ ] Writing your first playbook
- [ ] Tasks, handlers, and tags
- [ ] Idempotency in Ansible
- [ ] Running playbooks with `ansible-playbook`

## 6. Variables, Loops, Conditions
- [ ] Defining variables in playbooks
- [ ] Variable precedence
- [ ] Using `with_items` and loops
- [ ] Conditional execution (`when`)
- [ ] Jinja2 templating basics

## 7. Roles
- [ ] What are roles?
- [ ] Role directory structure
- [ ] Creating & using roles
- [ ] Role dependencies
- [ ] Importing roles in playbooks

## 8. Vault
- [ ] Introduction to Ansible Vault
- [ ] Encrypting and decrypting files
- [ ] Using vault in playbooks
- [ ] Vault passwords and prompting for passwords

## 9. Galaxy
- [ ] Introduction to Ansible Galaxy
- [ ] Downloading roles from Galaxy
- [ ] Uploading your own roles to Galaxy
- [ ] Managing roles in `requirements.yml`

## 10. Ansible HashiCorp Vault Integration
- [ ] Introduction to HashiCorp Vault
- [ ] Storing secrets in HashiCorp Vault
- [ ] Retrieving secrets in Ansible
- [ ] Using community modules for HashiCorp Vault
- [ ] Best practices for secret management

---