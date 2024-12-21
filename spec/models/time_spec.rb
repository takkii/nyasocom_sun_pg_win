# current time rspec tests

require 'time'

describe Time do
  it 'should return the current time' do
    t = Time.now
    expect(t).to be_within(1).of(Time.now)
  end
end

