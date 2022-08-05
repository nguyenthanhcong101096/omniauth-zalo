require 'rails'
require 'set'
require 'active_support/dependencies'
require 'omniauth/zalo/version'
require 'omniauth/strategies/build_access_token'
require 'omniauth/strategies/zalo'

module Omniauth
  module Zalo
    class Error < StandardError; end
    class Engine < ::Rails::Engine; end
  end
end
