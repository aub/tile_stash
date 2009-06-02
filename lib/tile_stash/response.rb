module TileStash
  class Response

    attr_reader :content_type
    attr_reader :body

    def initialize(content_type, body)
      @content_type, @body = content_type, body
    end
  end
end
