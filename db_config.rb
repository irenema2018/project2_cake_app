
require 'pg'
require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'mini_cake_web_app'
}

ActiveRecord::Base.establish_connection( ENV['DATABASE_URL'] || options)
