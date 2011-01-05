module Palmade::Stepscreen
  class Space
    attr_accessor :id

    def initialize(xml)
      @id = xml.find("id").first.content
    end

    def self.get(permalink)
      unless Palmade::Stepscreen.initialized?
        raise "Stepscreen is not initialized properly"
      end

      url = "http://#{Palmade::Stepscreen.account}.screenstepslive.com/spaces/#{permalink}.xml"
      response = Palmade::HttpService::Http.get(url, nil, Palmade::Stepscreen.prepare_headers)

      if response.success?
        new(response.xml_read)
      else
        nil
      end
    end

    protected

    def self.build_get_url

    end
  end
end
