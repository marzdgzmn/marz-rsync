RSpec.describe Marz::Rsync::Result do
  it 'should return success if exitcode == 0' do
    result = Marz::Rsync::Result.new("", 0)
    expect(result.error).to be_nil
    expect(result.success?).to be true
    expect(result.exitcode).to eql(0)
  end

  it 'should return the output of the rsync job' do
    result = Marz::Rsync::Result.new('output blah blah blah', 0)
    expect(result.output).to eql('output blah blah blah')
  end

  it 'should return the total size of the rsync job' do
    output = "2012/05/12 11:59:29 [18094] Number of files: 189315
              2012/05/12 11:59:29 [18094] Number of files transferred: 178767
              2012/05/12 11:59:29 [18094] Total file size: 241.57G bytes
              2012/05/12 11:59:29 [18094] Total transferred file size: 241.57G bytes
              2012/05/12 11:59:29 [18094] Literal data: 241.57G bytes
              2012/05/12 11:59:29 [18094] Matched data: 0 bytes
              2012/05/12 11:59:29 [18094] File list size: 4.08M
              2012/05/12 11:59:29 [18094] File list generation time: 0.002 seconds
              2012/05/12 11:59:29 [18094] File list transfer time: 0.000 seconds
              2012/05/12 11:59:29 [18094] Total bytes sent: 241.61G
              2012/05/12 11:59:29 [18094] Total bytes received: 3.44M
              2012/05/12 11:59:29 [18094] sent 241.61G bytes  received 3.44M bytes  30.67M bytes/sec
              2012/05/12 11:59:29 [18094] total size is 241.57G  speedup is 1.00"

    result = Marz::Rsync::Result.new(output, 0)
    expect(result.total_size).to eql('241.57G')
  end

  it 'should return the total bytes sent of the rsync job' do
    output = "2012/05/12 11:59:29 [18094] Number of files: 189315
              2012/05/12 11:59:29 [18094] Number of files transferred: 178767
              2012/05/12 11:59:29 [18094] Total file size: 241.57G bytes
              2012/05/12 11:59:29 [18094] Total transferred file size: 241.57G bytes
              2012/05/12 11:59:29 [18094] Literal data: 241.57G bytes
              2012/05/12 11:59:29 [18094] Matched data: 0 bytes
              2012/05/12 11:59:29 [18094] File list size: 4.08M
              2012/05/12 11:59:29 [18094] File list generation time: 0.002 seconds
              2012/05/12 11:59:29 [18094] File list transfer time: 0.000 seconds
              2012/05/12 11:59:29 [18094] Total bytes sent: 241.61G
              2012/05/12 11:59:29 [18094] Total bytes received: 3.44M
              2012/05/12 11:59:29 [18094] sent 241.61G bytes  received 3.44M bytes  30.67M bytes/sec
              2012/05/12 11:59:29 [18094] total size is 241.57G  speedup is 1.00"

    result = Marz::Rsync::Result.new(output, 0)
    expect(result.total_bytes_sent).to eql('241.61G')
  end

  it 'should return the total bytes received of the rsync job' do
    output = "2012/05/12 11:59:29 [18094] Number of files: 189315
              2012/05/12 11:59:29 [18094] Number of files transferred: 178767
              2012/05/12 11:59:29 [18094] Total file size: 241.57G bytes
              2012/05/12 11:59:29 [18094] Total transferred file size: 241.57G bytes
              2012/05/12 11:59:29 [18094] Literal data: 241.57G bytes
              2012/05/12 11:59:29 [18094] Matched data: 0 bytes
              2012/05/12 11:59:29 [18094] File list size: 4.08M
              2012/05/12 11:59:29 [18094] File list generation time: 0.002 seconds
              2012/05/12 11:59:29 [18094] File list transfer time: 0.000 seconds
              2012/05/12 11:59:29 [18094] Total bytes sent: 241.61G
              2012/05/12 11:59:29 [18094] Total bytes received: 3.44M
              2012/05/12 11:59:29 [18094] sent 241.61G bytes  received 3.44M bytes  30.67M bytes/sec
              2012/05/12 11:59:29 [18094] total size is 241.57G  speedup is 1.00"

    result = Marz::Rsync::Result.new(output, 0)
    expect(result.total_bytes_received).to eql('3.44M')
  end

  it 'should return error code if exitcode != 0' do
    result = Marz::Rsync::Result.new('', 10)
    expect(result.output).to eql('')
    expect(result.exitcode).to eql(10)
    expect(result.success?).to be false
    expect(result.error).to eql('Error in socket I/O')
    expect(result.total_size).to be_nil
  end
end
