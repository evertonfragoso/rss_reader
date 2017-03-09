require 'sinatra/base'
require 'active_record'
require 'open-uri'
require 'base64'

class ApplicationController < Sinatra::Base
  helpers ApplicationHelpers

  set :root_folder, File.expand_path('../../', __FILE__)
  set :views, File.expand_path('../../views', __FILE__)
  set :public_folder, File.expand_path('../../public', __FILE__)
  set :haml, format: :html5, provides: :html5

  not_found { haml :not_found }
end
