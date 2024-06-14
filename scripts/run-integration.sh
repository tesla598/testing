# Print the shell being used to execute this script
echo "Running script with shell: $(ps -p $$ -o comm=)"

# Print the current shell to verify
echo "Current shell is: $SHELL"

docker compose up -d

echo '🟡 - Waiting for database to be ready...'
bash ./scripts/wait-for-it.sh "postgresql://postgres:mysecretpassword@localhost:5432/postgres" -- echo '🟢 - Database is ready!'


npx prisma migrate dev --name init
npm run test
docker compose down
