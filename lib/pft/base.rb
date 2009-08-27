module Pft
  class Base
    attr_accessor :oauth, :message, :configuration
    
    def initialize(*args)
      options = args.pop || {}
      @oauth = Oauth.new
    end
    
    def reply_to(user, message)
      user = get_user(user)
      @oauth.client.update("@#{user.screen_name} #{message}", :in_reply_to_status_id => user.status.id)
      message_for('reply', user)
    end
    
    def retweet(user)
      user = get_user(user)
      @oauth.client.update("RT @#{user.screen_name} #{user.status.text}")
      message_for('retweet', user)
    end
    
    def direct_message(user, message)
      user = get_user(user).screen_name
      @oauth.client.direct_message_create(user, message)
      message_for('direct message', user)
    end
    
    def get_user(user)
      user = @oauth.client.user(user) rescue false
      if !user || !user.status
        raise "User or last tweet not found"
      end
      user
    end
    
    def parse_urls(message)
      return message unless message.=~(/(?:http:\/\/|ftp:\/\/|https:\/\/|www\.|ftp\.[\w]+)(?:[\w\-\.,@?^=%&amp;:\/~\+#]*[\w\-\@?^=%&amp;\/~\+#])/)
      parsed_message = ""
      message.each(" ") do |word|
        if word.=~(/(?:http:\/\/|ftp:\/\/|https:\/\/|www\.|ftp\.[\w]+)(?:[\w\-\.,@?^=%&amp;:\/~\+#]*[\w\-\@?^=%&amp;\/~\+#])/)
          word = "#{TinyUrl.compact(word.delete(' '))} "
        end
        parsed_message << word
      end
      parsed_message
    end
    
    def message_for(type, user = nil)
      "pft! successfully sent a #{type}#{" to #{user}" if user}"
    end
    
    def self.tweet(*options)
      base = self.new
      message = options.pop || []
      message = base.parse_urls(message.join(" "))
      options = options.pop || {}
      
      if options[:authorize]
        base.oauth.authorize
      elsif options[:reply]
        puts base.reply_to(options[:reply], message)
      elsif options[:rt]
        puts base.retweet(options[:rt])
      elsif options[:dm]
        puts base.direct_message(options[:dm], message)
      elsif message.size > 0
        base.oauth.client.update(message)
        puts base.message_for('tweet')
      else
        raise "Please provide a message"
          # class HighLine
          #   public :get_character
          # end
          # input = HighLine.new
          # while (c = input.get_character) != ?\e do
          #   puts "You typed #{c.chr.inspect}"
          # end
      end
    end
    
    def self.version
      "0.1"
    end
    
    def self.options(file=nil)
      @@options ||= begin
        @@file = File.expand_path(file || "~/.pftrc")
        configuration = []
        File.open(@@file).each do |line|
          configuration << [$1.to_sym, $2.chomp] if line =~ /(\w+)=(.+)/
        end rescue nil
        Hash[*configuration.flatten]
      end
    end
    
    def self.write_options
      File.open(@@file, "w") do |f|
        options.each { |key, value| f.puts "#{key}=#{value}" }
      end
    end

    def self.input
      @@input ||= IO.new(2,"r")
    end

  end    
end