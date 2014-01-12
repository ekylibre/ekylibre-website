module HomeHelper

  def slide(name, &block)
    content_tag(:section, content_tag(:div, capture(&block), :class => "main"), :id => name, :class => "slide")
  end

  def news
    html = "".html_safe
    
    for news in Dir.glob(Rails.root.join("db", "news", I18n.locale.to_s, "*.md")).sort.reverse
      path = Pathname.new(news)
      time = path.basename.to_s.split('-')[0..1].join
      time = Time.new(time[0..3].to_i, time[4..5].to_i, time[6..7].to_i, time[8..9].to_i, time[10..11].to_i)
      title = path.basename.to_s.split('-')[2..-1].join('-').split('.')[0..-2].join('.').gsub('_', ' ')
      article = render("shared/article", :title => title, :referenced_on => time, :body => File.read(path.to_s))
      html << content_tag(:article, article)
    end

    return html
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
