require File.join(File.dirname(__FILE__), 'stash')

module TileStash
  class DiskCache

    def initialize(params={})
      @base_path = params[:base_path]
      raise TileStash::InvalidCacheError.new('Disk caches require a base_path parameter.') unless @base_path
      FileUtils.mkdir_p(@base_path)
    end

    def directory_for(tile)
      dir = File.join(@base_path,
                tile.layer.name,
                '%03d' % tile.z,
                '%03d' % (tile.x / 1000000).round,
                '%03d' % ((tile.x / 1000).round % 1000),
                '%03d' % (tile.x.round % 1000),
                '%03d' % (tile.y / 1000000).round,
                '%03d' % ((tile.y / 1000).round % 1000),
                '%03d' % (tile.y.round % 1000))
      FileUtils.mkdir_p(dir)
      dir
    end

    def file_for(tile)
      File.join(directory_for(tile), "tile.#{tile.layer.extension}")
    end

    def set(tile, data)
      File.open(file_for(tile), 'w') do |file|
        file.write(data)
      end
    end

    def get(tile)
      if File.exists?(file = file_for(tile))
        File.open(file, 'r').read
      else
        nil
      end
    end

    def clear
      FileUtils.rm_rf(@base_path)
      FileUtils.mkdir_p(@base_path)
    end
  end
end
