require File.join(File.dirname(__FILE__), 'spec_helper')

describe 'mounting TileStash in an app' do
  describe 'at the root level' do
    it 'should respond' do
      request = Rack::MockRequest.new(TestApp)
      response = request.get('/')
      response.should be_ok
      response.content_type.should == 'image/jpg'
      response.body.should == 'ack'
    end
  end
end

