cd aws-pool
docker-compose down
git fetch --rebase
docker-compose build
docker-compose up -d