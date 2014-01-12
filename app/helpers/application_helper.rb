module ApplicationHelper

  def title(text)
    content_for(:title, text)
  end

  def icon_tags(options = {})
    # Favicon
    html  = tag(:link, :rel => "icon", :type => "image/png", :href => image_path("icon/favicon.png"), "data-turbolinks-track" => true)
    html << "\n".html_safe + tag(:link, :rel => "shortcut icon", :href => image_path("icon/favicon.ico"), "data-turbolinks-track" => true)
    # Apple touch icon
    icon_sizes = {iphone: "57x57", ipad: "72x72", "iphone-retina" => "114x114", "ipad-retina" => "144x144"}
    unless options[:app].is_a?(FalseClass)
      for name, sizes in icon_sizes
        html << "\n".html_safe + tag(:link, rel: "apple-touch-icon", sizes: sizes, href: image_path("icon/#{name}.png"), "data-turbolinks-track" => true)
      end
    end
    if options[:precomposed]
      for name, sizes in icon_sizes
        html << "\n".html_safe + tag(:link, rel: "apple-touch-icon-precomposed", sizes: sizes, href: image_path("icon/precomposed-#{name}.png"), "data-turbolinks-track" => true)
      end
    end
    return html
  end

end
