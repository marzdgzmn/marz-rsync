
module Marz
  module Rsync
    # The result of an rsync job
    class Result
      # Exit code of an rsync job
      attr_accessor :exitcode

      # Output of an rsync job
      attr_accessor :output

      #Rsync exit values/error codes
      ERROR_CODES = {
        #'0'  =>   'Success',
        '1'  =>   'Syntax or usage error',
        '2'  =>   'Protocol incompatibility',
        '3'  =>   'Errors selecting input/output files, dirs',
        '4'  =>   'Requested action not supported: an attempt was made to manipulate 64-bit files on a platform that cannot support them; or an option was specified that is supported by the client and not by the server.',
        '5'  =>   'Error starting client-server protocol',
        '6'  =>   'Daemon unable to append to log-file',
        '10' =>   'Error in socket I/O',
        '11' =>   'Error in file I/O',
        '12' =>   'Error in rsync protocol data stream',
        '13' =>   'Errors with program diagnostics',
        '14' =>   'Error in IPC code',
        '20' =>   'Received SIGUSR1 or SIGINT',
        '21' =>   'Some error returned by waitpid()',
        '22' =>   'Error allocating core memory buffers',
        '23' =>   'Partial transfer due to error',
        '24' =>   'Partial transfer due to vanished source files',
        '25' =>   'The --max-delete limit stopped deletions',
        '30' =>   'Timeout in data send/receive',
        '35' =>   'Timeout waiting for daemon connection'
      }

      def initialize(output, exitcode)
        @output = output
        @exitcode = exitcode
      end

      # Whether rsync job run without errors
      # @return {Boolean}
      def success?
        @exitcode == 0
      end

      # Error message corresponding to the exit code/error code
      # @return {String}
      def error
        return nil if @exitcode == 0
        error_key = @exitcode.to_s
        if ERROR_CODES.has_key? error_key
          ERROR_CODES[error_key].to_s
        elsif  @raw_output =~ /Permission denied \(publickey\)/
          "Permission denied (publickey)"
        else
          "Unknown Error"
        end
      end

      # Total size of the rsync job
      # @return {String}
      def total_size
        return nil if @exitcode != 0 || @output.nil?
        @output.match(/^*(?:total size is )(\d+\.\d+\S)/)[1]
      end

    end
  end
end
