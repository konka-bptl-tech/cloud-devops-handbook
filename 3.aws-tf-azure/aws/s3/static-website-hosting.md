### What is it?

* **Static** → Website files don’t change dynamically; they are delivered “as is.”
* **S3** → Object storage service where you put your files (HTML, CSS, JS, images).
* When you enable **static website hosting** on an S3 bucket, AWS gives you an endpoint URL where your website is served from.

---

### Key Features

1. **Simple hosting** – Upload files, enable hosting, done.
2. **Scalable** – Automatically handles any amount of traffic.
3. **Low cost** – Pay only for storage and data transfer.
4. **Integration** – Works well with **CloudFront** for CDN, **Route 53** for DNS, and **ACM** for SSL certificates.


---

## 2. How to Enable Static Website Hosting

1. Create an **S3 bucket** (best practice: name = your domain).
2. Upload website files (`index.html`, `error.html`, CSS, JS).
3. Go to **Bucket Properties → Static website hosting**.

   * Enable it.
   * Enter **index document** → `index.html`.
   * Enter **error document** → `error.html`.
4. Copy the **bucket website endpoint URL** and test in browser.

---

## 3. Permissions Setup

By default, S3 blocks public access. To serve a website:

### a) Bucket Policy (for public read access)

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::my-bucket-name/*"
    }
  ]
}
```

### b) Disable “Block Public Access”

* Go to **Permissions → Block public access settings**.
* Turn off **Block all public access** (only for static sites).

---

✅ Now your website is live via the S3 endpoint.
👉 If you want HTTPS + custom domain → use **CloudFront + Route 53 + ACM certificate**.

---
