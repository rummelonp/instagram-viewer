module ApplicationHelper

  def sort_images_by_size(images)
    images.sort_by do |image|
      image.width * image.height
    end
  end
  
end
