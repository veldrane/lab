#### How to exec search via curl

curl -XGET --header 'Content-Type: application/json' "http://elastic-elastic.route.local/linux.main.bebebeaf/_search" -d @00_execve.elk | jq 

