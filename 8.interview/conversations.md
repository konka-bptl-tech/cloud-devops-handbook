### Scenario: Daily Standup Call

Participants: **Scrum Master (SM), DevOps Engineer (You/Konka), Backend Developer (BD), QA Engineer (QA), Product Owner (PO)**

---

**Scrum Master (SM):**
Good morning, everyone. Let’s start today’s standup. Please remember to keep it short and focused: what you did yesterday, what you’re planning for today, and if there are any blockers. Let’s begin with Konka.

**DevOps Engineer (Konka):**
Good morning.

* **Yesterday**, I worked on fixing the CI/CD pipeline issue for the backend service. The deployment was failing because of a misconfigured IAM role in AWS. I corrected the policy and redeployed successfully.
* **Today**, I’ll be focusing on integrating monitoring with Prometheus and Grafana for our ECS cluster. I’ll also create alerts for high CPU usage.
* **Blockers**, none from my side at the moment.

**SM:**
Great, thanks Konka. That’s a good improvement. Please sync with QA once alerts are ready so they can validate. Next, Backend Developer?

**Backend Developer (BD):**
Sure.

* **Yesterday**, I was working on the authentication API. I completed the logic for token refresh and tested it locally.
* **Today**, I’ll push the changes to the development branch and request a deployment from Konka.
* **Blockers**, I need some clarification from the Product Owner regarding the session timeout requirement.

**PO:**
Noted, I’ll connect with you after this standup to clarify.

**SM:**
Perfect. Now QA?

**QA Engineer (QA):**

* **Yesterday**, I finished regression testing on the frontend service. Everything passed except one minor UI bug, which I’ve reported to the frontend team.
* **Today**, I’ll test the authentication API once Konka deploys it to the dev environment.
* **Blockers**, I need access to CloudWatch logs so I can validate backend errors.

**DevOps Engineer (Konka):**
I can help you with that today. I’ll set up the necessary permissions for you.

**QA:**
Thanks, Konka.

**SM:**
Awesome collaboration. Last, Product Owner?

**PO:**

* **Yesterday**, I reviewed the user stories for the next sprint and clarified acceptance criteria for the payment module.
* **Today**, I’ll prepare the backlog refinement session.
* **Blockers**, none from my side.

**SM:**
Great, thanks everyone. So, action items: Konka to give QA CloudWatch access, PO and BD will sync on session timeout, and QA will validate new alerts once they’re set up. Let’s keep moving forward. Standup is done.

---

✅ This conversation gives you:

* **English practice** with natural workplace tone
* **Agile context** (daily standup format)
* **DevOps terms** (CI/CD, IAM roles, ECS, CloudWatch, Prometheus, Grafana)

---