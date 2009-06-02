require 'rubygems'

gem 'builder'
require 'builder'

%w(core_extensions disk_cache layer mapnik_layer response stash stash_configuration tile tms_service).each do |file|
  require File.join(File.dirname(__FILE__), 'tile_stash', file)
end

# Services
#   * TMS, WMS, etc.
#   * Given a request, produce either a response or nil.
#   * Return a response that may or may not contain a tile.
# Caches
#   * DiskCache, S3Cache, etc.
#   * Given a tile, cache it.
# Layers
#   * Mapnik, WMS, etc.
#   * Given a tile, render it.
module TileStash
  class InvalidCacheError < StandardError; end
  class InvalidConfigurationError < StandardError; end
  class InvalidServiceError < StandardError; end
end

TileStash::Stash.register_service('tms', TileStash::TmsService)

