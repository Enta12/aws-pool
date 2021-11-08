cd aws-pool
docker-compose down
git fetch
git rebase
docker-compose build
docker-compose up -d