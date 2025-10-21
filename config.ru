require "bundler/setup"
Bundler.require(:default)
require 'sinatra'
require 'resque/server'
require 'resque/status_server'
require 'resque/lock_server'
require 'resque/scheduler'
require 'resque/scheduler/server'
require 'yaml'

# Build Redis connection options
redis_options = {
  host: ENV["REDIS_HOST"] || "127.0.0.1",
  port: (ENV["REDIS_PORT"] || 6379).to_i,
  db: (ENV["REDIS_DB"] || 0).to_i
}

# Add password if provided
redis_options[:password] = ENV["REDIS_PASSWORD"] if ENV["REDIS_PASSWORD"]

# Add TLS/SSL support if enabled
if ENV["REDIS_TLS"] == "true" || ENV["REDIS_SSL"] == "true"
  redis_options[:ssl] = true
  redis_options[:ssl_params] = { verify_mode: OpenSSL::SSL::VERIFY_NONE } if ENV["REDIS_SSL_VERIFY"] == "false"
end

# Add namespace if provided
redis_namespace = ENV["REDIS_NAMESPACE"] || "resque"

# Configure Resque to use Redis/Valkey
Resque.redis = Redis.new(redis_options)
Resque.redis.namespace = redis_namespace

map "/" do
  run Resque::Server.new
end
