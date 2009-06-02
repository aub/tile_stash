require File.join(File.dirname(__FILE__), 'spec_helper')

describe 'stash configuration' do
  class BMS; end
  class CMS; end

  before do
    TileStash::Stash.services.delete('bms')
    TileStash::Stash.services.delete('cms')
  end

  it 'should give a list of enabled services' do
    TileStash::Stash.register_service('bms', BMS.new)
    config = TileStash::StashConfiguration.new(:services => 'bms')
    config.services.size.should == 1
    config.services.first.should be_an_instance_of(BMS)
  end

  it 'should return the full list of services if none are specified' do
    service1, service2 = BMS.new, CMS.new
    config = TileStash::StashConfiguration.new({})
    old_services = config.services
    TileStash::Stash.register_service('bms', service1)
    TileStash::Stash.register_service('cms', service2)
    config.services.sort_by { |s| s.class.name }.should == 
      ([service1, service2] + old_services).sort_by { |s| s.class.name }
  end

  it 'should raise an InvalidConfigurationError if a service that does not exist is specified' do
    TileStash::Stash.register_service('bms', BMS.new)
    config = TileStash::StashConfiguration.new({ :services => 'jms' })
    lambda {
      config.services
    }.should raise_error(TileStash::InvalidConfigurationError)
  end

  it 'should be loadable from a file' do
    TileStash::Stash.register_service('bms', BMS.new)
    config = TileStash::StashConfiguration.new(File.join(File.dirname(__FILE__), 'configs', 'config3.yml'))
    config.services.size.should == 1
    config.services.first.should be_an_instance_of(BMS)
  end

  it 'should raise an exception if something that is neither a hash nor a string is provided' do
    lambda {
      config = TileStash::StashConfiguration.new(123)
    }.should raise_error(TileStash::InvalidConfigurationError)
  end
end
