all:
	MECHANIZE=true cucumber && cucumber

server:
	pogo ./app/server.pogo