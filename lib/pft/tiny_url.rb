module Pft
  class TinyUrl
    
    def self.compact(url)
      Net::HTTP.start('is.gd', 80) do |http|
        short_url = http.get("/api.php?longurl=#{url}")
        short_url.body if short_url.value
      end
      rescue
        url
    end
    
  end
end