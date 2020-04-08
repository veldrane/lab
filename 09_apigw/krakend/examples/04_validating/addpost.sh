curl -X POST http://krakend.lab.local/simple/article -H "accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer $1" -d @./new-article.json -v
