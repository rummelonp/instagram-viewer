module ApplicationHelper

  def sort_images_by_size(images)
    images.sort_by do |image|
      image.width * image.height
    end
  end

  def photo_image_tag(image, photo)
    image_tag image.url,
              :width => image.width,
              :height => image.height,
              :alt => photo.caption,
              :title => photo.caption
  end

  def schema_date
    Time.now.year
  end

end
