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
  ping: 20,
  extensions: [PrivateFaye.new],
  engine: {
    type: Faye::Redis,
    uri: ENV['REDIS_URL']
  }
}

Faye::WebSocket.load_adapter('thin')
client = Faye::RackAdapter.new(options)

client.on(:unsubscribe) do |client_id|
  STDOUT.puts "#{client_id} unsubscribed"
end

client.on(:disconnect) do |client_id|
  STDOUT.puts "#{client_id} disconnected"
end

run client

require 'logger'
Faye.logger = Logger.new(STDOUT)
Faye.logger.level = Logger::INFO
