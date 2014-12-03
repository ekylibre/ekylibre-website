require 'colored'

class ::Hash
  def deep_merge!(other_hash)
    other_hash.each_pair do |k,v|
      tv = self[k]
      self[k] = tv.is_a?(Hash) && v.is_a?(Hash) ? tv.deep_merge(v) : v
    end
    self
  end
end


# Create folder "_locales" and put some locale file from https://github.com/svenfuchs/rails-i18n/tree/master/rails/locale
module Jekyll
  module I18n

    module LocalizationFilter

      # Example:
      # {{ post.date | localize: "%d.%m.%Y" }}
      # {{ post.date | localize: ":short" }}
      def localize(input, locale = nil, format = nil)
        options = {locale: locale}
        if format
          options[:format] = (format =~ /^:(\w+)/) ? $1.to_sym : format
        end
        Jekyll::I18n.localize input, options
      end
      alias :l :localize
      
      # Example:
      # {{ post.date | localize: "en", ":short" }}
      # {{ post.date | localize }}
      def localize_date(input, locale = nil, format = nil)
        localize input.to_date, locale, format
      end

    end
    

    class << self
      attr_accessor :default_locale
      attr_reader :translations

      # Load translations in a big hash
      def load_translations(*files)
        @translations ||= {}
        files.flatten.each do |file|
          @translations.deep_merge! YAML.load_file(file)
        end
      end

      # Translate a key with translations
      def translate(key, options = {}) # :nodoc:
        keys = key.to_s.split(".")
        return value *keys.unshift(options[:locale] || Jekyll::I18n.default_locale)
      end
      alias :t :translate


      # Localize date and datetime with given format
      def localize(object, options = {})
        # unabashedly stole this snippet from Joshua Harvey's Globalize plugin,
        # which itself unabashedly stole it from Tadayoshi Funaba's Date class
        loc = options[:locale] || default_locale
        format = options[:format] || "default"
        format = Jekyll::I18n.t(:"#{object.is_a?(Time) ? :time : :date}.formats.#{format}", locale: loc)

        # Pre-process
        format = format.to_s.gsub(/%[c]/) do |match|
          case match
          when '%c' then Jekyll::I18n.t(:"time.formats.default",                 locale: loc)
          end
        end

        # format = resolve(locale, object, format, options)
        format = format.to_s.gsub(/%[aAbBpP]/) do |match|
          case match
          when '%a' then Jekyll::I18n.t(:"date.abbr_day_names",                  locale: loc)[object.wday]
          when '%A' then Jekyll::I18n.t(:"date.day_names",                       locale: loc)[object.wday]
          when '%b' then Jekyll::I18n.t(:"date.abbr_month_names",                locale: loc)[object.mon]
          when '%B' then Jekyll::I18n.t(:"date.month_names",                     locale: loc)[object.mon]
          when '%p' then Jekyll::I18n.t(:"time.#{object.hour < 12 ? :am : :pm}", locale: loc).upcase if object.respond_to? :hour
          when '%P' then Jekyll::I18n.t(:"time.#{object.hour < 12 ? :am : :pm}", locale: loc).downcase if object.respond_to? :hour
          end
        end
        
        return object.strftime(format)
      end

      protected

      # Get the value in translation tree by recursive access
      def value(*keys)
        tree = (keys[-1].is_a?(Hash) ? keys.delete_at(-1) : @translations)
        v = tree[keys.first.to_s]
        if keys.size > 1
          return (v.is_a?(Hash) ? value(*keys[1..-1], v) : nil)
        end
        return v
      end
      
      
    end


    

  end
end

Jekyll::I18n.load_translations Dir[File.join(File.dirname(__FILE__), '../_locales/*.yml')]
Jekyll::I18n.default_locale = :en

Liquid::Template.register_filter(Jekyll::I18n::LocalizationFilter)
