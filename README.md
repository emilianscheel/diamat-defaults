# diamat-defaults

TEST
docker-compose -f docker-compose/diamat-mongodb.yml up -d

INSTALLATION

- download installation.sh file
  'sudo chmod +x installation.sh'
  './installation.sh -n 1 -t basic'

docker-compose \
 -f ~/.diamat/1/diamat-mongodb.yml \
 -f ~/.diamat/1/diamat-dev.yml \
 up --detach
