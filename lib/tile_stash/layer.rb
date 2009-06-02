module TileStash
  class Layer
    attr_reader :extension, :name

    def initialize(name)
      @name = name
      @extension = 'png'
    end
  end
end
