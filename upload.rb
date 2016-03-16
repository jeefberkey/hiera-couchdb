#!/usr/bin/env ruby

require 'couchrest'
require 'yaml'
require 'pry'

ENVIRONMENT = 'production'

db = CouchRest.database!("http://localhost:5984/#{ENVIRONMENT}")

docs = []
# get files to upload from the hieradata folder
Dir.glob('hieradata/**/*.yaml') do |file|
  hash = YAML.load(File.open(file))
  if File.dirname(file) == '.'
    hash['_id'] = File.basename(file, '.yaml')
  else
    hash['_id'] = File.dirname(file) +'/'+ File.basename(file, '.yaml')
  end

  docs << hash
end

# add empty docs for directories in hieradata
Dir.glob('hieradata/**/*/') do |dir|
  dir_w_sep = {
    '_id' => dir
  }
  docs << dir_w_sep
  dir = {
    '_id' => File.basename(dir)
  }
  docs << dir
end

# path separators don't work in HTTP
docs.each do |doc|
  doc['_id'].gsub!('/','::')
end

# upload docs
docs.each do |doc|
  print "Uploading #{doc['_id']}... "
  begin
    db.save_doc(doc)
    puts
  rescue RestClient::Conflict #'409 Conflict'
    puts "File #{doc['_id']} already exists!"
  end
end
