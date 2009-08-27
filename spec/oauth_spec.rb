require File.dirname(__FILE__) + '/../lib/pft.rb'

describe "Pft::OAuth" do
  
  before(:each) do
    @pft_oauth = Pft::Oauth.new
  end
  
  it "should have a key and a secret" do
    @pft_oauth.key.should_not be_nil
    @pft_oauth.secret.should_not be_nil
  end
  
  it "should ask you to allow oauth client" do
    Pft::Base.stub!(:options).and_return({})
    lambda { @pft_oauth.client }.should raise_error("Please run it with -a")
  end
  
  it "should not ask you to allow oauth client" do
    Pft::Base.stub!(:options).and_return({:token => "aaa", :secret => "bbb"})
    lambda { @pft_oauth.client }.should_not raise_error("Please run it with -a")
  end
    
end