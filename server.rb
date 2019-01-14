#!/usr/bin/env ruby

# this is homework for my Postmates interview
# the goal: implement an HTTP endpoint that accepts logs from mobile devices,
# and writes the logs out to disk and to AWS kinesis

require 'sinatra'
require 'aws-sdk'

##### variables #####
# this is defined in the terraform code
$output_stream = 'postmates_homework_stream_test'
# this can be anything, as long as the dir exists
$output_dir = 'logs_received'

# takes a log file and writes it to disk
def write_log_to_file(uuid, text)
  filename = File.join(Dir.pwd, $output_dir, "#{uuid}.log")
  File.open(filename, 'w') { |f| f.write(text) }
end

# takes a log file and puts it on a kinesis stream
def write_log_to_kinesis(uuid, text)
  # this assumes that you have already configured your AWS SDK gem
  client = Aws::Kinesis::Client.new
  client.put_record(
    stream_name: $output_stream,
    data: text,
    partition_key: "PartitionKey"
  )
end

# this is just a simple endpoint so you can check that the server is working
get '/' do
  'logs must be posted to /log'
end

post '/log' do
  uuid = SecureRandom.uuid
  # read the first file (this could be updated to loop over all files)
  log_text = request.params.first.last[:tempfile].read
  # save the log to the two places
  write_log_to_file(uuid, log_text)
  write_log_to_kinesis(uuid, log_text)
  return uuid
end

