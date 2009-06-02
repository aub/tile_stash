module TileStash
  class StashConfiguration
    def initialize(params)
      if params.is_a?(String)
        @params = load_from_file(params)
      elsif params.is_a?(Hash)
        @params = params
      else
        raise InvalidConfigurationError.new('Stashes must be configured with either a hash or a valid filename.')
      end
      @params.symbolize_keys!
    end

    def services
      if @params.has_key?(:services)
        @params[:services].split(',').map do |svc| 
          unless Stash.services.has_key?(svc)
            raise InvalidConfigurationError.new("The service #{svc.strip} was not registered.")
          end
          Stash.services[svc.strip]
        end
      else
        Stash.services.values
      end
    end

    protected

    def load_from_file(file)
      YAML.load_file(file)
    end
  end
end
