# rspec sample string matcher.

require 'spec_helper'

describe String do
  it 'should be a kind of String' do
    expect('hello').to be_kind_of(String)
  end

  it 'should be a kind of String' do
    expect('hello').to be_a_kind_of(String)
  end

  it 'should be a kind of String' do
    expect('hello').to be_an_instance_of(String)
  end

  it 'should be a kind of String' do
    expect('hello').to be_instance_of(String)
  end

  it 'should be a kind of String' do
    expect('hello').to be_a(String)
  end

  it 'should be a kind of String' do
    expect('hello').to be_an(String)
  end
end
