we have multiple accounts we need to provision infra
- dev
- qa
- stage
- prod

Seperate user accounts to provision infra

When we do IaC we keep our code in github 

1. Developing
2. Using

IAC branching Strategy

main branch -- ready to use code no vulnerabilites best practices

dev1 branch --
                 once the development is over raise PR once it is accepted merged into main branch
dev2 branch -- 


one machine for development
one machine for QA,Stage and Prod

DevSecOps[Dev]
----------------
1. Code Checkout
2. tf init
3. tf plan
4. SCA[Checkov]
5. tf apply 
6. tf destroy