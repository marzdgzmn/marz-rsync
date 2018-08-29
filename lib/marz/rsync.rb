require 'marz/rsync/version'
require 'marz/rsync/configure'
require 'marz/rsync/command'


module Marz
  # Main interface to rsyunc
  module Rsync
    extend Configure
    # Runs an rsync {Command} and return the {Result}
    # @param source {String}
    # @param destination {String}
    # @param opts {Array}
    # @return {Result}
    # @yield {Result}
    def self.run(source, destination, opts = [], &block)
      destination = "#{self.host}:#{destination}" if self.host
      result = Command.run(source, destination, opts)
      yield(result) if block_given?
      result
    end
  end
end
