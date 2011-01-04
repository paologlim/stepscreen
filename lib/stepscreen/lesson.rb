class Stepscreen::Lesson

  def self.get(id, manual_id)
    unless ::Stepscreen.initialized?
      raise "Stepscreen is not initialized properly"
    end

    url = "http://#{::Stepscreen.account}.screenstepslive.com/spaces/#{::Stepscreen.space_permalink}/manuals/#{manual_id}/lessons/#{id}.xml"
    response = Palmade::Http.get(url, nil, ::Stepscreen.prepare_headers)

    if response.success?
      self.build(response.xml_parse).first
    else
      nil
    end
  end

  def self.with_tags(tags)
    unless ::Stepscreen.initialized?
      raise "Stepscreen is not initialized properly"
    end

    url = "http://#{::Stepscreen.account}.screenstepslive.com/spaces/#{::Stepscreen.space_permalink}/tags.xml?tag=#{tags}"
    response = Palmade::Http.get(url, nil, ::Stepscreen.prepare_headers)

    if response.success?
      self.build(response.xml_parse)
    else
      nil
    end
  end

  protected

  def self.build(xml_data)
    lessons = []
    if xml_data.find("lesson").empty?
      xml_records = [xml_data]
    else
      xml_records = xml_data.find("lesson")
    end

    xml_records.each do |xml_record|
      lesson = {}

      [:title, :url, :id, :description].each do |attr_name|
        lesson[attr_name] = xml_record.find(attr_name.to_s).first.content
      end

      lesson[:tags] = build_tags(xml_record)
      lesson[:manual_id] = build_manual_id(xml_record)
      lesson[:steps] = build_steps(xml_record)

      lessons << lesson
    end
    lessons
  end

  def self.build_tags(xml_record)
    tags = []
    xml_record.find("tags").first.find("tag").each do |xml_tag|
      tags << xml_tag.find("name").first.content
    end
    tags
  end

  def self.build_manual_id(xml_record)
    unless xml_record.find("asset").empty?
      manual_id = xml_record.find("asset").first.find("id").first.content
    else
      manual_id = xml_record.find("manual").first.find("id").first.content
    end
    manual_id
  end

  def self.build_steps(xml_record)
    steps = []
    xml_steps = xml_record.find("steps")
    unless xml_steps.empty?
      xml_steps.first.find("step").each do |xml_step|
        step = {}

        [:title, :instructions].each do |attr_name|
            step[attr_name] = xml_step.find(attr_name.to_s).first.content
        end

        unless xml_step.find("media").empty?
          step[:media_url] = xml_step.find("media").first.find("url").first.content
        end

        steps << step
      end
    end
    steps
  end
end
