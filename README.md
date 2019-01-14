```
bundle
mkdir logs_received
ruby server.rb
curl -F "file=@/path/to/logfile" http://localhost:4567/log
```
