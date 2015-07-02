class HomeController < ApplicationController
  
  def index
    @video = Rails.cache.read(:video)
    unless @video
      feed = 'https://gdata.youtube.com/feeds/api/users/UC_yYJGkq-aqC-So8DlXtM5g/uploads'
      begin
        rss = Feedjira::Feed.fetch_and_parse(feed)
        entry = rss.entries.first
        parameters = CGI::parse(URI(entry.url).query)
        @video = parameters["v"].first
        Rails.cache.write(:video, @video, time_to_live: 1.day)
      rescue Feedjira::FetchFailure => e
        Rails.logger.warn "Cannot fetch youtube data"
      end
    end

    @articles = Rails.cache.read(:articles)
    unless @articles
      feed = 'http://forum.ekylibre.org/c/ekylibre/news.rss'
      begin
        rss = Feedjira::Feed.fetch_and_parse(feed)
        @articles = Array.new
        5.times do |i|
          item, article = rss.entries[i], Hash.new
          article[:title], article[:url] = item.title, item.url
          article[:published] = item.published.to_date
          @articles << article
        end
        Rails.cache.write(:articles, @articles, timeToLive: 15.minutes)
      rescue Feedjira::FetchFailure => e
        Rails.logger.warn "Cannot fetch forum data"
      end
    end
  end

  def not_found
    redirect_to root_url
  end

end
