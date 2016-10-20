for i in {1..300}
do
printf "\n------------------\n"
echo "Welcome $i times"
printf "\n"
# curl -i -H "Authorization: Token token=3Hu9orST5sKDHUPJBwjbogtt" http://localhost:3000/v1/users >> /dev/null
# curl -i -H "Authorization: Token token=3Hu9orST5sKDHUPJBwjbogtt" http://10.1.0.201:3000/v1/users
curl -i -H "Authorization: Token token=3Hu9orST5sKDHUPJBwjbogtt" http://localhost:3000/v1/users
done
