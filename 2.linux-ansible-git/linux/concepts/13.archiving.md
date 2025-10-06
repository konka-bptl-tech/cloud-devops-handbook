# ✅ Linux Archiving & File Sharing Cheat Sheet

---

## **1. What is Archiving and File Sharing in Linux?**

* **Archiving**: Combining multiple files and directories into a single file for easier storage or transfer.
* **Compression**: Reducing file size using algorithms (e.g., gzip, bzip2, xz).
* **File Sharing**: Copying or transferring files between systems (local to remote or vice versa).

---

## **2. Archiving with `tar`**

**Definition:**
`tar` (Tape Archive) is used to **create, extract, and manage archive files**. It does not compress by default; it only combines files.

### **Commands & Examples**

* **Create an archive**

```
tar -cvf archive.tar file1 file2 dir/
```

* `-c` → create

* `-v` → verbose

* `-f` → specify file name

* **Extract an archive**

```
tar -xvf archive.tar
```

* **List archive contents**

```
tar -tvf archive.tar
```

---

## **3. Compression with tar + gzip/bzip2/xz**

**Definition:**
To save storage or speed up transfer, archives are compressed using algorithms like gzip (`.gz`), bzip2 (`.bz2`), or xz (`.xz`).

### **Commands & Examples**

* **tar + gzip**

```
tar -czvf archive.tar.gz files/
```

* `-z` → use gzip

* **tar + bzip2**

```
tar -cjvf archive.tar.bz2 files/
```

* `-j` → use bzip2

* **tar + xz**

```
tar -cJvf archive.tar.xz files/
```

* `-J` → use xz

* **Extract compressed archives**

```
tar -xzvf archive.tar.gz   # gzip
tar -xjvf archive.tar.bz2  # bzip2
tar -xJvf archive.tar.xz   # xz
```

---

## **4. gzip & gunzip**

**Definition:**
`gzip` compresses individual files (not directories). `gunzip` decompresses `.gz` files.

### **Examples**

```
gzip file.txt        # Compress → file.txt.gz
gunzip file.txt.gz   # Decompress
```

---

## **5. zip & unzip**

**Definition:**
`zip` creates compressed archives in `.zip` format; `unzip` extracts them.

### **Examples**

```
zip archive.zip file1 file2
zip -r archive.zip dir/    # Include directories
unzip archive.zip
```

---

## **6. File Transfer**

### **6.1 What is `scp`?**

**Definition:**
`scp` (Secure Copy Protocol) is a command-line tool to **copy files between local and remote systems over SSH**. It uses SSH for security but does **not support resuming transfers**.

#### **Examples**

```
scp file.txt user@remote:/path/
scp user@remote:/path/file.txt /local/path/
scp -r dir/ user@remote:/path/   # Copy directory
```

---

### **6.2 What is `rsync`?**

**Definition:**
`rsync` is an **efficient file copy and synchronization tool** that minimizes data transfer by copying only differences between source and destination. It supports **resume**, **incremental sync**, and **compression**.

#### **Examples**

```
rsync -avz /local/dir/ user@remote:/remote/dir/
rsync -avz user@remote:/remote/dir/ /local/dir/
rsync -avz --progress file.txt user@remote:/path/
```

* `-a` → archive mode
* `-v` → verbose
* `-z` → compress during transfer

---

### ✅ **Difference Between `scp` and `rsync`**

| Feature         | `scp`                    | `rsync`                         |
| --------------- | ------------------------ | ------------------------------- |
| **Protocol**    | Uses SSH                 | Uses SSH                        |
| **Efficiency**  | Always copies full files | Copies only differences (delta) |
| **Resume**      | ❌ No                     | ✅ Yes                           |
| **Compression** | ❌ No                     | ✅ Yes (`-z` option)             |
| **Speed**       | Slower for large data    | Faster for repeated syncs       |

---

### **Using `sftp` (Interactive)**

```
sftp user@remote
sftp> put file.txt
sftp> get file.txt
sftp> exit
```

---

## **7. Download Files from Internet**

**Definition:**
Use `wget` or `curl` to download files from URLs.

### **wget**

```
wget https://example.com/file.zip
wget -c https://example.com/file.zip   # Resume download
```

### **curl**

```
curl -O https://example.com/file.zip
curl -L -o file.zip https://example.com/file.zip   # Follow redirects
```

---

## **8. Combine Compression & Transfer**

**Definition:**
Archive and send data over SSH in a single command.

### **Examples**

```
tar -czvf - dir/ | ssh user@remote "cat > /path/dir.tar.gz"
ssh user@remote "tar -czf - /remote/dir" | tar -xzf -
```

---

## ✅ **Common Use Cases**

* **Backup directories** → `tar + gzip`
* **Share files between servers** → `scp` or `rsync`
* **Download from web** → `wget` or `curl`
* **Sync large files efficiently** → `rsync` (resume supported)

---

## **1. Create a backup of `/etc` daily at 2 AM (cron + tar + gzip)**

```
0 2 * * * tar -czvf /backup/etc-$(date +\%F).tar.gz /etc
```

---

## **2. Backup `/var/www` and keep last 7 backups**

```
tar -czvf /backup/www-$(date +%F).tar.gz /var/www && find /backup -type f -mtime +7 -delete
```

---

## **3. Extract a `.tar.gz` file to `/opt`**

```
tar -xzvf archive.tar.gz -C /opt
```

---

## **4. Compress all `.log` files in `/var/log`**

```
gzip /var/log/*.log
```

---

## **5. Decompress all `.gz` files in `/tmp`**

```
gunzip /tmp/*.gz
```

---

## **6. Zip a folder and exclude `.git` directory**

```
zip -r project.zip project/ -x "*.git*"
```

---

## **7. Unzip to a specific directory**

```
unzip archive.zip -d /opt/app
```

---

## **8. Download a file and extract it in one command**

```
curl -L https://example.com/archive.tar.gz | tar -xz
```

---

## **9. Download and resume broken download using wget**

```
wget -c https://example.com/largefile.iso
```

---

## **10. Transfer a file to remote server using scp**

```
scp backup.tar.gz user@192.168.1.10:/opt/backup/
```

---

## **11. Copy a directory recursively using scp**

```
scp -r /var/www user@192.168.1.10:/var/www-backup/
```

---

## **12. Transfer with progress bar using rsync**

```
rsync -avz --progress /var/www user@192.168.1.10:/backup/
```

---

## **13. Mirror a remote directory locally using rsync**

```
rsync -avz user@192.168.1.10:/remote/dir/ /local/dir/
```

---

## **14. Sync files but delete extra files on remote**

```
rsync -avz --delete /local/dir/ user@remote:/remote/dir/
```

---

## **15. Backup home directory and exclude cache**

```
rsync -avz --exclude='.cache' /home/user /backup/
```

---

## **16. Upload a file to a remote server using sftp**

```
sftp user@remote
sftp> put file.txt
```

---

## **17. Download a file from a remote server using sftp**

```
sftp user@remote
sftp> get file.txt
```

---

## **18. Compress and transfer directory in one line**

```
tar -czf - /var/www | ssh user@remote "cat > /backup/www.tar.gz"
```

---

## **19. Extract a remote tar archive without saving it locally**

```
ssh user@remote "tar -czf - /remote/dir" | tar -xzf -
```

---

## **20. Split a large tar.gz file into 100MB chunks**

```
tar -czvf - /large/dir | split -b 100M - backup.tar.gz.part-
```

---

## **21. Combine split files and extract**

```
cat backup.tar.gz.part-* | tar -xzvf -
```

---

## **22. Create incremental backup using rsync**

```
rsync -avz --link-dest=/backup/previous/ /data/ /backup/current/
```

---

## **23. Create a backup and verify integrity**

```
tar -czvf backup.tar.gz /data && tar -tzf backup.tar.gz
```

---

## **24. Backup PostgreSQL database and compress**

```
pg_dump dbname | gzip > backup.sql.gz
```

---

## **25. Backup MySQL database and compress**

```
mysqldump dbname | gzip > backup.sql.gz
```

---

## **26. Archive all `.conf` files from `/etc`**

```
find /etc -name "*.conf" | tar -czvf conf-backup.tar.gz -T -
```

---

## **27. Backup and encrypt using OpenSSL**

```
tar -czvf - /data | openssl enc -aes-256-cbc -out backup.tar.gz.enc
```

---

## **28. Decrypt and extract**

```
openssl enc -d -aes-256-cbc -in backup.tar.gz.enc | tar -xzvf -
```

---

## **29. Compress directory and email it**

```
tar -czvf backup.tar.gz /data && mail -s "Backup" user@example.com < backup.tar.gz
```

---

## **30. Sync data every 5 minutes using cron + rsync**

```
*/5 * * * * rsync -avz /data user@remote:/backup/
```

---