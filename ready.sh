echo "Waiting for postgrest to become ready:"
until $(curl --output /dev/null --silent --head --fail http://127.0.0.1:3000); do
    printf '.'
    sleep 5
done
echo ""
