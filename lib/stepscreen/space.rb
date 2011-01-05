class Stepscreen::Space
  attr_accessor :id

  def initialize(xml)
    @id = xml.find("id").first.content
  end

  def self.get(permalink)
    unless ::Stepscreen.initialized?
      raise "Stepscreen is not initialized properly"
    end

    url = "http://#{::Stepscreen.account}.screenstepslive.com/spaces/#{permalink}.xml"
    response = Palmade::HttpService::Http.get(url, nil, ::Stepscreen.prepare_headers)

    if response.success?
      new(response.xml_read)
    else
      nil
    end
  end
end
