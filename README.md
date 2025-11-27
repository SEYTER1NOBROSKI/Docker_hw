# Linux Docker Homework

This repository contains the solution for the Linux Docker homework. It demonstrates how to establish communication between two Alpine containers using `netcat` scripts, custom bridge networks, and bind mounts.

## Project Structure
* **Dockerfile**: Configuration for the Alpine image with `netcat-openbsd` installed.
* **server.sh**: Script that listens for incoming data on port 9090.
* **client.sh**: Script that sends data to the server container.

---

## Instructions

### How to run project

#### It's important to run every command with *sudo*
According to the assignment requirements, we create two separate images from the same Dockerfile.

1. Build the **server** and **client** image:
```bash
docker build -t server-img .
docker build -t client-img .
```

2. Create a custom non-default bridge network to allow automatic DNS resolution between containers (so they can communicate by name).
```bash
docker network create my-net
```

3. How to run containers. We use bind mounts to make the scripts (server.sh and client.sh) available inside the containers at /scripts.

Run the Server container:
```bash
docker run -d --name server-con --network my-net -v $(pwd):/scripts server-img sh /scripts/server.sh
```
* Starts in detached mode (-d)

* Listens on port 9090

Run the Client container:
```bash
docker run --rm --name client-con --network my-net -v $(pwd):/scripts client-img sh /scripts/client.sh server-con
```
* Connects to server-con

* Sends a message and exits

* Automatically removes itself after execution (--rm)

---

## Сommands to verify correct execution and results

1. To verify that containers in my-net can reach the server-con, we can run a temporary container to ping it:
```bash
docker run --rm --network my-net alpine ping -c 4 server-con
```

If the ping is successful, the network is configured correctly.

2. Commands to verify netcat scripts

To verify that the data was successfully transmitted from the client to the server, check the logs of the server container:
```bash
docker logs server-con
```

3. Command to check your images
```bash
docker images
```

4. Command to check all networks
```bash
docker network ls
```

---

## Cleanup

To remove the containers and network created during this homework:
```bash
docker stop server-con
docker rm server-con
docker network rm my-net
```