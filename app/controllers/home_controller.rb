class HomeController < ApplicationController
  
  def index
    feed = Feedjira::Feed.fetch_and_parse("https://gdata.youtube.com/feeds/api/users/UC_yYJGkq-aqC-So8DlXtM5g/uploads")
    entry = feed.entries.first
    parameters = CGI::parse(URI(entry.url).query)
    @video = parameters["v"].first
    # raise [entry.url, @video].inspect
  end

  def not_found
    redirect_to root_url
  end

end
