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

require './lib/private_faye'

options = {
  mount: ENV['SOCKET_BACKEND'],
  timeout: 25,
  ping: 10,
 # extensions: [PrivateFaye.new],
  engine: {
    type: Faye::Redis,
    uri: ENV['REDIS_URL']
  }
}

#Faye::WebSocket.load_adapter('thin')
run Faye::RackAdapter.new(options)

require 'logger'
Faye.logger = Logger.new(STDOUT)
Faye.logger.level = Logger::DEBUG
