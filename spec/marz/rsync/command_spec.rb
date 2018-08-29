
RSpec.describe Marz::Rsync::Command do
  it 'should return a Result object' do
    expect(Marz::Rsync::Command.run("/path/to/src/", "/path/to/dest", "-a")).to be_kind_of(Marz::Rsync::Result)
  end
end
