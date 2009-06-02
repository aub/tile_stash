module TileStash
  class TmsService
    def handle_request(request, layers)
      Response.new
    end

    def self.name
      'TileMapService'
    end

    def self.title
      'Tile Map Service'
    end

    def self.version
      '1.0.0'
    end
  end
end
