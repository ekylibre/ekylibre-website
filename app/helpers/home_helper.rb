module HomeHelper

  def slide(name, &block)
    content_tag(:section, content_tag(:div, capture(&block), :class => "main"), :id => name, :class => "slide")
  end

  def screenshots
    # images = ["home", "animals-edit", "animals_new", "animals-show", "stock_dashboard", "incoming_delivery_new", "production_dashboard_1", "production_dashboard_2", "journals-show", "sales-show-pdf", "accountancy_dashboard"]
    image_dir = Rails.root.join("app", "assets", "images", "screenshots", "originals")
    images = Dir.glob(image_dir.join("*.png")).collect do |path|
      Pathname.new(path).basename(".png").to_s
    end
    html = "".html_safe
    for image in images
      html << link_to(image_tag("screenshots/thumbnails/#{image}.png"), image_path("screenshots/originals/#{image}.png"), rel: 'screenshots', 'data-gallery' => true, class: "screenshot")
    end
    return html
  end

end
