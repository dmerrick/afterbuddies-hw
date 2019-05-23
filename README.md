## Dana's "Afterbuddies" Homework

For my solution I decided to keep things very simple and created a Sinatra app.

Since infrastructure should be managed as code, I also included Terraform code to set up the Kinesis stream.
I do not think this is necessary, because it's easy to do this in the AWS SDK as well, but it's good practice.

### Example Setup

```bash
# set up the infrastructure
cd infra
terrafrom init
terraform apply

# set up the server
cd ..
bundle
# create the logs dir on disk
mkdir logs_received
# start the sever
ruby server.rb

# send a test file
curl -F "file=@/path/to/logfile" http://localhost:4567/log
```

### To Be Improved

There is no error handling on writing to disk or talking to Kinesis.
There is no security on the webapp.
Many variables are hardcoded.
Kinesis details leave something to be desired, but I don't know the best practices (this is my first time using it).
Moving the server to a Docker image would be nice, so it comes with all dependencies and is easily deployable.
