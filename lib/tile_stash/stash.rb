module TileStash
  class Stash

    attr_reader :layers

    class << self
      attr_reader :services
      attr_reader :caches
    end

    @services = {}
    @caches = {}

    def initialize(params={})
      @configuration = StashConfiguration.new(params)
      @layers = []
    end

    def handle_request(request)
      if request.path.split('/').reject { |p | p.empty? }.size == 0
        return service_list_response(request)
      end
      @configuration.services.each do |service| 
        service.handle_request(request, layers)
      end
      Response.new('image/png', 'ack')
    end

    def add_layer(layer)
      @layers << layer
    end

    def self.register_service(name, service)
      if @services.has_key?(name)
        raise InvalidServiceError.new("A service named #{name} has already been registered.")
      end
      @services[name] = service.is_a?(Class) ? service.new : service
    end

    def self.register_cache(name, cache)
      raise InvalidCacheError.new('Only classes can be registered as caches.') unless cache.is_a?(Class)
      raise InvalidCacheError.new("A cache named #{name} has already been registered.") if @caches.has_key?(name)
      @caches[name] = cache
    end

    protected

    def service_list_response(request)
      output = ''
      builder = Builder::XmlMarkup.new(:target => output, :indent => 2)
      builder.instruct!
      builder.Services do |services_tag|
        @configuration.services.each do |service|
          services_tag.tag!(service.class.name, 
                            { :title => service.class.title, :version => service.class.version, :href => request.host })
        end
      end
      Response.new('application/xml', output)
    end
  end
end
