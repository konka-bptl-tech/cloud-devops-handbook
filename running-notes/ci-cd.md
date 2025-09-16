ci --> cd

developer ---> tester ----> staging ----> production

General workflow in any organization developer writes the code that would given to QA they do different kind of testing once QA certifies the product we deploy the application in to staging env this we are test based out of how the customer access which is what we called as the UAT once this is done then we put our product into env called production where endusers can access the application

The market moving very faster so what exactly we need is continuous delivery of your product 

# Continuous Delivery
Continuous Delivery is a practice where code changes are automatically prepared for release to production

The Entire Continuous delivery will be divided into 2 parts

CI = Continuous Inegration[Integrate development and testing]
CD = Continuous Deployment[The QA certifies the code how do you make sure you put into staging or prod enviroment]


CI/CD is a process which help us to implement continuous delivery

Generally in organizations follow  2 pipelines one for CI and another for CD ensure 2 parts of automation

We need to automate 2 half so one half is automating the build which is where as soon as developer completes his work how do we take that code converted into product would given to QA and at the same time when i have a product how do i make sure wheather if i want deploy on QA or an staging env or production enviroment I need to ability

How do we automate and secure build and deployment pipeline

Build is a process whene you take a program or source code of the program converted into artifact which can be consume by QA 

In traditional builds no automation for build
Bunch of developers write the code they do unit test locally and made commmits and then push to code central repo 
We accumulate all the code developed by multiple developers we do build generally we called as nightly build some point of a day this is one of the traditional methods what we follow earlier once in a while we build and if the build is success we give it to QA but what happens if the build fails [why build fails there could be a problem in any one of the developers code and developer modified the code and he has tested his code which is called as unit testing but multiple codes are combining some times might not work that exactly what happend] the problem that we have is we need ask QA to wait because we don't have a successful build if a QA waits entire release process would be delayed or effected . The next problem is we need to ask the developers to fix the code which developer you ask because in a matter of 5 to 6 hours there might be 10 or 15 commit ids there might be multiple developers who would modified the code so which developer you go and ask it takes lot of time for debug and find out which is exact code which is having problem overall when we follow this traditional method what happens is [more time to find bugs][Release is delayed]

Our interest is to overcome this issue or to enable continuous delivery

Which means as soon as developer completes his work we should be in a postion to test it if there is an issue immediatly notify the developer so that your code as problem please fix it as soon as possible this where the market came up with new process of automating the build pipeline which what we called as continuous integration


CI is a practice that helps to frequntly integrate code changes into central repo and then automate builds

Continuous Developemt = Code has he given the code have any problem if any we problem he should immedialty take and fix it give it back 

Advantages with CI/CD [Find bugs faster][faster releases][improve quality]


Prodcution grade DevSecops build pipeline
1. Build & Unit Test
2. Code Coverage
3. SCA
4. SAST
5. Quality Gates
6. Build Image
7. Scan Image
8. Smoke Test
notification 