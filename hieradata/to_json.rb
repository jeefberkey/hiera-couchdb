#!/usr/bin/env ruby

require 'yaml'
require 'json'

Dir.glob('**/*.yaml') do |file|
  yaml = YAML.load(File.open(file))
  File.write(file+'.json',yaml.to_json)
end

