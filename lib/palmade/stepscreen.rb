# -*- coding: utf-8 -*-
# encoding: utf-8

require 'base64'
require 'libxml'

STEPSCREEN_LIB_DIR = File.dirname(__FILE__) unless defined?(STEPSCREEN_LIB_DIR)
STEPSCREEN_ROOT_DIR = File.join(STEPSCREEN_LIB_DIR, '..') unless defined?(STEPSCREEN_ROOT_DIR)

# == Overview
#
# This is a gem for communicating with ScreenSteps Live API
#
module Palmade
  module Stepscreen
    class << self
      attr_accessor :account, :space_permalink, :username, :password

      def prepare_headers
        if @username.nil? || @password.nil?
          raise "missing credentials"
        end
        headers = {}
        headers[:authorization] = "Basic #{Base64.encode64(@username + ':' + @password)}"
        {:headers => headers}
      end

      def initialized?
        @account && @space_permalink && @username && @password
      end
    end

    autoload :Http, File.join(STEPSCREEN_LIB_DIR, 'stepscreen/http')
    autoload :Space, File.join(STEPSCREEN_LIB_DIR, 'stepscreen/space')
    autoload :Lesson, File.join(STEPSCREEN_LIB_DIR, 'stepscreen/lesson')
  end
end
