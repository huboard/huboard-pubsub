require 'bundler'
Bundler.require

require 'dotenv'
Dotenv.load

require 'faye'

options = {
  mount: ENV['SOCKET_BACKEND'],
  timeout: 10,
  ping: 5,
  engine: {
    type: Faye::Redis,
    uri: ENV['REDIS_URL']
  }
}

Faye::WebSocket.load_adapter('thin')
run Faye::RackAdapter.new(options)

require 'logger'
Faye.logger = Logger.new(STDOUT)
Faye.logger.level = Logger::INFO
