require 'marz/rsync/result'

module Marz
  module Rsync
    #The rsync command to be run
    class Command
      # Runs an rsync job, returns the exit code, and does logging
      #
      # @param opts {Array}
      # @return {ExitCode}
      def self.run(*opts)
        cmd = ['rsync', '--itemize-changes', '--stats', '-h', opts].flatten.shelljoin
        output = `#{cmd} 2>&1`
        Result.new(output, $?.exitstatus)
      end

      def self.command
        @command ||= "rsync"
      end

      def self.command=(cmd)
        @command = cmd
      end

    end
  end
end
