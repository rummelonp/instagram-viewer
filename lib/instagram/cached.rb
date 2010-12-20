module Instagram
  module Cached
    extend Instagram

    class << self
      attr_accessor :cache

      def discover_user_id(url)
        url = Addressable::URI.parse url unless url.respond_to? :host
        $1.to_i if get_url(url) =~ %r{profiles/profile_(\d+)_}
      end

      def setup(options = {})
        self.cache = FailsafeStore.new(RAILS_CACHE.cache_path, {
          namespace: 'instagram',
          exceptions: [Net::HTTPServerException, JSON::ParserError]
        }.update(options))
      end

      private
      def get_url(url)
        cache.fetch(url.to_s) { super }
      end
    end

  end
end
