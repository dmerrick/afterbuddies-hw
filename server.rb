#!/usr/bin/env ruby

require 'awesome_print'
require 'pry'
require 'sinatra'
require 'aws-sdk'

output_dir = 'logs_received'

def write_log_to_file(text)
  filename = File.join(Dir.pwd, output_dir, "#{uuid}.log")
  File.open(filename, 'w') { |f| f.write(log_text) }
end

def write_log_to_kinesis(text)

end

get '/' do
  'logs must be posted to /log'
end

post '/log' do
  #binding.pry
  uuid = SecureRandom.uuid
  # read the first file (this could be updated to be a loop)
  log_text = request.params.first.last[:tempfile].read
  write_log_to_file(log_text)
  write_log_to_kinesis(log_text)
  return uuid
end

