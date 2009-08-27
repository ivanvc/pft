require File.dirname(__FILE__) + '/../lib/pft.rb'

describe "Pft::TinyUrl" do
  
  it "should shorten one url" do
    url = "http://example.org/1234567/abcdef/gtr"
    shorten = Pft::TinyUrl.compact(url)
    shorten.should_not == url
  end
  
  it "should not short one bad formated url" do
    url = "http://example.org/123334/3 "
    shorten = Pft::TinyUrl.compact(url)
    shorten.should == url
  end
  
  it "should not short a non url" do
    url = "test"
    shorten = Pft::TinyUrl.compact(url)
    shorten.should == url
  end
  
end