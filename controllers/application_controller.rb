# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader' if development?
require 'base64'

# Application Controller
class ApplicationController < Sinatra::Base
  helpers ApplicationHelpers
  helpers FeedHelpers

  set :root_folder, File.expand_path('../', __dir__)
  set :views, File.expand_path('../views', __dir__)
  set :public_folder, File.expand_path('../public', __dir__)
  set :haml, format: :html5

  not_found { haml :not_found }

  configure :production, :development do
    enable :logging
  end

  configure :development do
    register Sinatra::Reloader
  end
end
