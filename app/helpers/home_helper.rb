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

end
