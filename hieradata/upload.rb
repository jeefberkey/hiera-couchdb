#!/usr/bin/env ruby

require 'couchrest'
require 'yaml'

ENVIRONMENT = 'production'

db = CouchRest.database!("http://localhost:5984/#{ENVIRONMENT}")

Dir.glob('**/*.yaml') do |file|
  hash = YAML.load(File.open(file))

  file.gsub!('/','&')

  hash['_id'] = file
  puts "Uploading file #{file}"
  db.save_doc(hash)

end
