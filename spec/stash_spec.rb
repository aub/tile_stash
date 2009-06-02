require File.join(File.dirname(__FILE__), 'spec_helper')

describe 'the Stash class' do
  it 'should be creatable from a config hash' do
  end

  it 'should provide access to the layers' do
    stash = TileStash::Stash.new
    layer = TileStash::MapnikLayer.new('faker.xml')
    stash.add_layer(layer)
    stash.layers.should == [layer]
  end

  describe 'with services' do
    class HMS
      def handle_request(request)
      end
    end

    class FMS
      def handle_request(request)
      end
    end

    before do
      TileStash::Stash.services.delete('hms')
      TileStash::Stash.services.delete('fms')
    end

    it 'should allow registering of services' do
      service = HMS.new
      before_keys = TileStash::Stash.services.keys
      TileStash::Stash.register_service('hms', service)
      TileStash::Stash.services.keys.sort.should == (before_keys + ['hms']).sort
      TileStash::Stash.services['hms'].should == service
    end

    it 'should allow registering of services by giving a class' do
      TileStash::Stash.register_service('hms', HMS)
      TileStash::Stash.services['hms'].should be_an_instance_of(HMS)
    end

    it 'should pass requests on to services' do
      service = HMS.new
      TileStash::Stash.register_service('hms', service)
      service.should_receive(:handle_request).and_return(false)
      request = Rack::MockRequest.new(test_app('config2'))
      request.get('/service')
    end

    it 'should only pass requests to services that are enabled' do
      service1 = HMS.new
      service2 = FMS.new
      TileStash::Stash.register_service('hms', service1)
      TileStash::Stash.register_service('fms', service2)
      service1.should_receive(:handle_request)
      service2.should_not_receive(:handle_request)
      request = Rack::MockRequest.new(test_app('config2'))
      request.get('/service')
    end

    it 'should throw an InvalidServiceError if two services with the same name are registered' do
      TileStash::Stash.register_service('hms', HMS)
      lambda {
        TileStash::Stash.register_service('hms', FMS)
      }.should raise_error(TileStash::InvalidServiceError)
    end
    
    it 'should return an XML document describing the services at the root URL' do
      request = Rack::MockRequest.new(test_app('config1'))
      response = request.get('/')
      response.should be_ok
      response.content_type.should == 'application/xml'
      response.body.should have_nodes('/Services', 1)
      response.body.should have_nodes('/Services/TileMapService', 1)
      response.body.should have_xpath("/Services/TileMapService[@title='#{TileStash::TmsService.title}']")
      response.body.should have_xpath("/Services/TileMapService[@version='#{TileStash::TmsService.version}']")
    end
  end

  describe 'with caches' do
    class HashCache
    end

    before do
      TileStash::Stash.caches.delete('hash')
    end

    it 'should allow registering of caches' do
      TileStash::Stash.register_cache('hash', HashCache)
      TileStash::Stash.caches.should == { 'hash' => HashCache }
    end

    it 'should throw an InvalidCacheError if two caches with the same name are registered' do
      TileStash::Stash.register_cache('hash', HashCache)
      lambda {
        TileStash::Stash.register_cache('hash', HashCache)
      }.should raise_error(TileStash::InvalidCacheError)
    end

    it 'should throw an InvalidCacheError when registering a cache that is not a class' do
      lambda {
        TileStash::Stash.register_cache('hash', 123)
      }.should raise_error(TileStash::InvalidCacheError)
    end
  end
end
