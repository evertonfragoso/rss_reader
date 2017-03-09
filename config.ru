require 'rubygems'
require 'bundler'
require 'sinatra/base'
require 'active_record'

Bundler.require

Dir.glob('./{models,helpers,controllers}/*.rb').each { |file| require file }

require File.expand_path('../db', __FILE__) + '/connection.rb'

map('/') { run FeedController }