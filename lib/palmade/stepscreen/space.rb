module Palmade::Stepscreen
  class Space
    attr_accessor :id

    GET_URL = "http://%s.screenstepslive.com/spaces/%s.xml".freeze

    def initialize(xml)
      @id = xml.find("id").first.content
    end

    def self.get(permalink)
      unless Palmade::Stepscreen.initialized?
        raise "Stepscreen is not initialized properly"
      end

      url = build_get_url(permalink)
      response = Palmade::HttpService::Http.get(url, nil, Palmade::Stepscreen.prepare_headers)

      if response.success?
        new(response.xml_read)
      else
        nil
      end
    end

    protected

    def self.build_get_url(permalink)
      GET_URL % [Palmade::Stepscreen.account, permalink]
    end
  end
end
