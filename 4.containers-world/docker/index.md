# Docker Learning Roadmap

## Legend:
- [ ] Not Started  
- [/] In Progress  
- [x] Completed  

---

## 1. VM vs Containers
- [ ] Understand Virtual Machines
- [ ] Understand Containers
- [ ] Differences between VM and Containers
- [ ] Use cases of Containers over VM

## 2. What is Docker
- [ ] Introduction to Docker
- [ ] Benefits of Docker
- [ ] Use cases in DevOps

## 3. Docker Architecture
- [ ] Docker Engine components (Daemon, CLI, REST API)
- [ ] Docker Client vs Docker Daemon
- [ ] Docker Registries (Docker Hub, private registries)
- [ ] Images, Containers, and Layers
- [ ] Docker objects (Volumes, Networks)

## 4. What is Containerization
- [ ] Concept of containerization
- [ ] Isolation of apps & dependencies
- [ ] Comparison with traditional deployment
- [ ] Benefits in CI/CD pipelines

## 5. Docker Basic Commands
- [ ] `docker run`, `docker ps`, `docker stop`, `docker rm`
- [ ] `docker images`, `docker rmi`
- [ ] `docker exec`, `docker logs`, `docker inspect`
- [ ] Running containers in detached & interactive mode

## 6. Dockerfile & Instructions & Best Practices
- [ ] What is Dockerfile
- [ ] Instructions: `FROM`, `RUN`, `CMD`, `ENTRYPOINT`, `COPY`, `ADD`, `ENV`, `WORKDIR`, `EXPOSE`
- [ ] Best practices for Dockerfile
- [ ] Building and tagging images

## 7. Docker Networking
- [ ] Docker default networks (bridge, host, none)
- [ ] Custom networks
- [ ] Linking containers
- [ ] Exposing ports
- [ ] Docker network commands (`docker network ls`, `docker network inspect`)

## 8. Docker Volumes
- [ ] Difference between volumes, bind mounts, tmpfs
- [ ] Creating and mounting volumes
- [ ] Persisting data using volumes
- [ ] Volume commands (`docker volume create`, `docker volume inspect`, `docker volume rm`)

## 9. Docker Compose
- [ ] Introduction to Docker Compose
- [ ] `docker-compose.yml` structure (services, networks, volumes)
- [ ] Running multi-container apps
- [ ] Common commands (`docker-compose up`, `docker-compose down`, `docker-compose logs`)

## 10. Docker Best Practices
- [ ] Image size optimization
- [ ] Use of official images
- [ ] Minimize layers
- [ ] Security considerations
- [ ] Keeping Docker images updated
