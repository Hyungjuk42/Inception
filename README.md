- How to mount shared folder into virtual machine

`mount -t voxsf inception_shared SharedFolder`

- deal the database
	show DATABASES;
	USE wordpress;
	show TABLES;
	select * from {col val};
	
- how to mount shared folder 
	mount -t vboxsf <host folder> <guest folder>

- how to chk tls
	openssl s_client -connect localhost:443 -tls1_2

- how to chk docker volume info
	docker volume inspect {docker volume name}
	
- advantage of docker
	run like a same environment.
	less overhead.
	sandbox environment.
	pre setting.

- docker vs docker compose
	docker
	- platform of creation and management of containers. build and run.
	docker compose
	- management of multi-container application
	
	there are no difference between images with using docker compose or not

- SSL(Secure Sockets Layer)/TLS(Transport Layer Security)


- docker network
	host : use the host network. act like containers are in same network. (port?)
	birdge : allocates 172.17.0.x to container. treats those container has own network.
	none : Do not use any network.
	ipvlan : using single mac address.
	macvlan : using mac address per each devices.
	overlay : connect docker daemon together. 다중 docker hosts
	--link : legacy feature of the docker. network two container using name. 단일 docker host


- Should FIX
	- code Makefile more simply
	- remove .env file from git

- Question
	- What is --link?
	- docker vs virtual box
	- How to implement docker os/kernel?
	- Why mysqld_safe didn't die when `kill {# of mysqld_pid}`
		ref : https://www.44bits.io/ko/post/is-docker-container-a-virtual-machine-or-a-process
	- What is PID 1 and dumb init?
	- What if we didn't set the openssl's destination and address?
	- 