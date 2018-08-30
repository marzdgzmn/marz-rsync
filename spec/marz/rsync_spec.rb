require 'pry'
RSpec.describe Marz::Rsync do
  it "has a version number" do
    expect(Marz::Rsync::VERSION).not_to be nil
  end

  context 'configure with localhost' do
    before do
      Marz::Rsync.configure do |config|
        config.host = 'root@127.0.0.1'
      end
    end

    it "should respond to host" do
      expect(Marz::Rsync).to respond_to(:host)
      expect(Marz::Rsync.host).to eql('root@127.0.0.1')
    end

    describe ".run" do
      it 'prepends the host to the destination' do
        expect(Marz::Rsync::Command).to receive(:run).with('/foo1', 'root@127.0.0.1:/foo2', ["-a"])
        Marz::Rsync.run('/foo1', '/foo2', ["-a"])
      end
    end
  end

  around(:each) do |example|
    TempDir.create do |src, dest|
      @src = src
      @dest = dest
      example.run
    end
  end

  it 'should have similar contents' do
    @src.mkdir("hmm")
    Marz::Rsync.run(@src.path + '/', @dest.path, ["-a"])
    expect(@dest.contents).to eql(@src.contents)
  end

  it 'should perform a trial run with no changes made with dry run option given' do
    @src.mkdir("hmm")
    Marz::Rsync.run(@src.path + '/', @dest.path, ['-a', '-n'])
    expect(@dest.contents).to_not eql(@src.contents)
  end

  it "should return a result object containing the rsync job's output and exitcode" do
    @src.mkdir("hmm")
    result =  Marz::Rsync.run(@src.path + '/', @dest.path, ['-a'])
    expect(result).to be_success
    expect(result.exitcode).to eql(0)
    expect(result.error).to be_nil
    expect(@dest.contents).to eql(@src.contents)
    binding.pry
  end

end
