# frozen_string_literal: true

require 'rubygems'
require 'bundler'
require 'sinatra/base'
require 'active_record'

Bundler.require

require File.expand_path('db', __dir__) + '/connection.rb'

Dir.glob('./{config,lib}/**/*.rb').each { |file| require file }
Dir.glob('./{use_cases,services}/**/*.rb').each { |file| require file }
Dir.glob('./{models,helpers,controllers}/*.rb').each { |file| require file }

run FeedController
