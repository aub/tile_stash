require File.join(File.dirname(__FILE__), 'spec_helper')

describe 'disk cache' do
  before do
    @cache_dir = 'spec/cache'
    @layer = TileStash::Layer.new('test_layer')
    @cache = TileStash::DiskCache.new(:base_path => @cache_dir)
  end

  after do
    FileUtils.rm_rf(@cache_dir)
  end

  it 'should require a root directory' do
    lambda {
      stash = TileStash::DiskCache.new({})
    }.should raise_error(TileStash::InvalidCacheError)
  end
  
  it 'should create the base directory when initialized' do
    FileUtils.rm_rf(@cache_dir)
    File.exists?(@cache_dir).should be_false
    TileStash::DiskCache.new(:base_path => @cache_dir)
    File.exists?(@cache_dir).should be_true
  end

  it 'should generate the correct directory' do
    tile = TileStash::Tile.new(@layer, 500, 600, 7)
    @cache.directory_for(tile).should == %q(spec/cache/test_layer/007/000/000/500/000/000/600) 
  end

  it 'should create the directory' do
    tile = TileStash::Tile.new(@layer, 50000, 60000, 7)
    @cache.directory_for(tile)
    File.exists?(%q(spec/cache/test_layer/007/000/050/000/000/060/000)).should be_true
  end

  it 'should get the correct full path for a tile' do
    tile = TileStash::Tile.new(@layer, 1234567890, 10000, 15)
    @cache.file_for(tile).should == %q(spec/cache/test_layer/015/1234/567/890/000/010/000/tile.png)
  end

  it 'should write data to the cache' do
    tile = TileStash::Tile.new(@layer, 1234567890, 10000, 15)
    @cache.file_for(tile).should == %q(spec/cache/test_layer/015/1234/567/890/000/010/000/tile.png)
  end

  it 'save the data on set' do
    tile = TileStash::Tile.new(@layer, 123, 456, 2)
    @cache.set(tile, 'abc')
    filename = %q(spec/cache/test_layer/002/000/000/123/000/000/456/tile.png) 
    File.exists?(filename).should be_true
    File.open(filename) do |file|
      file.gets.should == 'abc'
    end
  end

  it 'should access the data on get' do
    tile = TileStash::Tile.new(@layer, 123, 456, 2)
    @cache.set(tile, 'abc')
    @cache.get(tile).should == 'abc'
  end

  it 'should delete the directory when clearing the cache' do
    tile = TileStash::Tile.new(@layer, 123, 456, 2)
    @cache.set(tile, 'abc')
    filename = %q(spec/cache/test_layer/002/000/000/123/000/000/456/tile.png)
    File.exists?(filename).should be_true
    @cache.clear
    File.exists?(filename).should be_false
  end
end
