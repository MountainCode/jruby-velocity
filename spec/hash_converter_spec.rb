require 'lib/velocity'

class Person
  attr_accessor :name, :address
end

class Address
  attr_accessor :city, :state, :zip
end

describe Velocity::HashConverter do
  describe 'when object is converted to hash' do
    converter = Velocity::HashConverter.new
    person = Person.new
    person.name = 'Chris'
    person.address = Address.new
    person.address.city = 'Londonderry'
    person.address.state = 'VT'
    person.address.zip = '05148'

    hash = converter.to_hash person

    it 'should convert an object to a hash' do
      hash['name'].should eq 'Chris'
    end
    it 'should convert all child objects to hashes' do
      hash['address'].is_a?(Hash).should be_true
    end
  end

  describe 'when a hash contains an object' do
    converter = Velocity::HashConverter.new
    person = Person.new
    person.name = 'Chris'
    outer_hash = { 'person' => person }
    converted = converter.to_hash(outer_hash)

    it 'should convert objects to a hash' do
      converted['person'].is_a?(Hash).should be_true
    end
    it 'inner hashes should have correct values' do
      converted['person']['name'].should eq 'Chris'
    end
  end

  describe 'when a hash contains an array of objects' do
    converter = Velocity::HashConverter.new
    person = Person.new
    person.name = 'Chris'
    outer_hash = { 'people' => [person] }
    converted = converter.to_hash outer_hash

    it 'should convert objects inside lists to hashes' do
      converted['people'][0].is_a?(Hash).should be_true
    end
  end

  describe 'when a hash uses symbols as keys' do
    converter = Velocity::HashConverter.new
    context = { :name => 'Bob' }
    converted = converter.to_hash context
    it 'should convert the keys to strings' do
      converted.should have_key 'name'
    end
  end
end
