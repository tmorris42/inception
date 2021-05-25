docker build --tag tmorris-img .
echo "RUNNING CONTAINER"
docker run --env AUTOINDEX=off -it -p 80:80 -p 443:443 --name tmorris-server tmorris-img:latest
