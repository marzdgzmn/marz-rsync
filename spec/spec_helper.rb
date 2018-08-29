require "bundler/setup"
require "marz/rsync"

root = File.expand_path("./..", __FILE__)

Dir[File.join(root, "setup/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:suite) do
    version = ENV["RSYNC_VERSION"] || "3.1.1"
    rsync = RsyncSetup.new(version)
    cmd = rsync.setup

    puts `#{cmd} --version`
    Marz::Rsync::Command.command = cmd
  end

end
