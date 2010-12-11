xml = Builder::XmlMarkup.new(:indent => 2)
xml.feed "xml:lang" => "ja", :xmlns => 'http://www.w3.org/2005/Atom' do
  xml.id "tag:#{request.host},#{schema_date}:#{request.path.split(".").first}"
  xml.link :rel => 'alternate', :type => 'text/html',
           :href => request.url.split(@popular? 'popular': '.atom').first
  xml.link :rel => 'self', :type => 'application/atom+xml', :href => request.url
  xml.title "#{@title} - Instagram Viewer"
  xml.updated @photos.first.taken_at.xmlschema
  xml.author { xml.name @photos.first.user.username } unless @popular
  @photos.each do |photo|
    min, mid, max = sort_images_by_size photo.images
    xml.entry do
      xml.title photo.caption || 'Photo'
      xml.published photo.taken_at.xmlschema
      if @popular
        xml.link :rel => 'alternate', :type => 'text/html', :href => "/user/#{photo.user.id}"
        xml.author { xml.name photo.user.username }
      end
      xml.content :type => 'xhtml' do |content|
        content.div :xmlns => "http://www.w3.org/1999/xhtml" do
          content.a :href => max.url do
            content.img :src => mid.url,
                        :width => mid.width,
                        :height => mid.height,
                        :alt => photo.caption,
                        :titie => photo.caption
          end
          content.p "#{photo.likers.size} likes this" unless photo.likers.empty?
        end
      end
    end
  end
end
