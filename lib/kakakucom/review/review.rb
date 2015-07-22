module Kakakucom
  module Review
    class Review
      class Review
        def initialize(html)
          @html = html
        end

        def inspect
          "<Review: id=#{id}>"
        end

        def url
          @url ||= @html.css('.reviewTitle > span > a').first["href"]
        end

        def user_id
          ""
        end

        def title
          @title ||= @html.css('.reviewTitle > span > a').first.text
        end

        def date
          unless @date
            match_data = /(?<year>\d+)年(?<month>\d+)月(?<day>\d+)日.+/.match(@html.css('.entryDate').first.text)
            @date = Date.new(match_data[:year].to_i, match_data[:month].to_i, match_data[:day].to_i)
          end
          @date
        end

        def text
          # remove leading and trailing line returns, tabs, and spaces
          @text ||= @html.css('.revEntryCont').first.text
        end

        def rating
          @rating ||= @html.css('th[contains("満足度")] + td').first.text
        end

        def helpful_count
          @helpful_count ||= Int(@html.css('.referCount > span').first.text)
        end

        def to_hash
          attrs = [:url, :user_id, :title, :date, :text, :rating, :helpful_count]
          attrs.inject({}) do |r, attr|
            r[attr] = self.send(attr)
            r
          end
        end

      end
    end
  end
end
