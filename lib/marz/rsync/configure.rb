module Marz
  module Rsync
    module Configure
      CONFIG_KEYS = [
        :host
      ].freeze


      attr_accessor *CONFIG_KEYS

      def configure
        yield self
      end
      
    end
  end
end
