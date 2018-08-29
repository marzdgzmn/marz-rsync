require "test_helper"

class Marz::RsyncTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Marz::Rsync::VERSION
  end

  def setup
    Marz::Rsync.configure do |config|
      config.host = 'root@127.0.0.1'
    end
  end

  #def test_it_does_something_useful
  #  assert false
  #end

  def test_rsync_run_should_prepend_host_to_destination
    mock = MiniTest::Mock.new
    result = MiniTest::Mock.new
    mock.expect(Marz::Rsync::run, result, ['/foo1', 'root@127.0.0.1:/foo2', ['-a']])
    Marz::Rsync::Command.stub :run, result do
      mock.run('/foo1', '/foo2', ['-a'])
    end
    mock.verify
  end
end
