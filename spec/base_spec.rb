require File.dirname(__FILE__) + '/../lib/pft.rb'

describe "Pft::Base" do
      
  it "should raise an error with no arguments" do
    lambda { Pft::Base.tweet.should_not }.should raise_error("Please provide a message")
  end
  
  it "should respond with the version" do
    Pft::Base.version
  end
  
  it "should open not default configuration file" do
    File.stub!(:open).and_return(["token=test"])
    Pft::Base.options("blah")[:token].should eql("test")
  end
    
end

describe "Pft::Base instance" do

  before(:each) do
    @pft = Pft::Base.new
  end
  
  it "should have a oauth client" do
    @pft.oauth.should_not be_nil
  end
  
  describe "handling no such user error" do
  
    it "should raise it if the user is invalid when posting a reply" do
      lambda { @pft.reply_to('123123wjas8duas8d', 'blah') }.should raise_error("User or last tweet not found")
    end

    it "should raise it if the user is invalid when posting a direct message" do
      lambda { @pft.direct_message('123123wjas8duas8d', 'blah') }.should raise_error("User or last tweet not found")
    end

    it "should raise it if the user is invalid when posting a retweet" do
      lambda { @pft.retweet('123123wjas8duas8d') }.should raise_error("User or last tweet not found")
    end
  
  end
  
  it "should print confirmation message" do
    @pft.message_for('test').should == "pft! successfully sent a test"
  end

  it "should print confirmation message with an user" do
    @pft.message_for('test', 'testo').should == "pft! successfully sent a test to testo"
  end
  
  it "should handle urls" do
    original_text = "testing http://www.example.com/blaaaaaaaaaaaaaaaaaaaaaaaah a"
    @pft.parse_urls(original_text).should_not == original_text
  end
      
end