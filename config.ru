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

options = {
  mount: ENV['SOCKET_BACKEND'],
  timeout: 25,
  ping: 20,
  extensions: [PrivatePub::FayeExtension.new],
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
