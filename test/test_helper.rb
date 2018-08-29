$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "marz/rsync"

require "minitest/autorun"

root = File.expand_path("./..", __FILE__)

Dir[File.join(root, "setup/**/*.rb")].each { |f| require f }

version = "3.1.1"

rsync = RsyncSetup.new(version)
cmd = rsync.setup

puts `#{cmd} --version`
Marz::Rsync::Command.command = cmd
