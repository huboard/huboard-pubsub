require 'bundler'
Bundler.require

require 'dotenv'
Dotenv.load

module PrivatePub
  class << self
    def set_config(config={})
      config = config
    end
  end
end
PrivatePub.set_config secret_token: ENV['SECRET_KEY']

require 'logger'
Faye.logger = Logger.new(STDOUT)
Faye.logger.level = Logger::INFO

require './lib/private_faye'

options = {
  mount: ENV['SOCKET_BACKEND'],
  timeout: 25,
  ping: 20,
  extensions: [PrivateFaye.new],
  engine: {
    type: Faye::Redis,
    uri: ENV['REDIS_URL']
  }
}

Faye::WebSocket.load_adapter('thin')
client = Faye::RackAdapter.new(options)
run client
