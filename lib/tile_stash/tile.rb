module TileStash
  class Tile
    attr_reader :layer, :x, :y, :z

    def initialize(layer, x, y, z)
      @layer, @x, @y, @z = layer, x, y, z
    end
  end
end
