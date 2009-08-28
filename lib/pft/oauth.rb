module Pft
  class Oauth
    attr_accessor :key, :secret
    
    def initialize(*args)
      @key = "Imv819Ww77451xPcQ4Jxaw"
      @secret = "MIcYaAqL62S2L3nLSasSu4YjMo1Mydeh46ItULi5Tc"
    end
    
    def client
      @client ||= begin
        client_token   = Base.options[:token]
        client_secret  = Base.options[:secret]
        if !client_secret || !client_token
          raise "Please run it with -a"
        end
        oauth = Twitter::OAuth.new(@key, @secret)
        oauth.authorize_from_access(client_token, client_secret)
        Twitter::Base.new(oauth)
      end
    end
    
    def authorize
      puts "We are going to launch the brower, do you want to continue? [Y/n]"
      authorize = Base.input.gets.chomp
      raise "Cannot authorize the account" if authorize.downcase == "n"
      consumer = OAuth::Consumer.new(@key, @secret, {:site => 'http://twitter.com'})
      request_token = consumer.get_request_token
      url = request_token.authorize_url
      if RUBY_PLATFORM =~ /darwin/
        system "open #{url}"
      elsif !system("firefox #{url}")
          puts "Please point your browser to: \n\n#{url}\n\n"
      end
      puts "Please enter the provided PIN:"
      pin = Base.input.gets.chomp
      access_token = request_token.get_access_token(:oauth_verifier => pin) rescue false
      if access_token
        Base.options[:token]   = access_token.token
        Base.options[:secret]  = access_token.secret
        Base.write_options
        puts "Great we're done! You can now ridicolous tweet from pft!@"
      else
        raise "The PIN provided is incorrect"
      end
    end
    
  end
end