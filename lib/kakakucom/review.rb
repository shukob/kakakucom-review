require 'nokogiri'
require 'open-uri'
require_relative "review/version"
require_relative 'review/review'

module Kakakucom
  module Review
    def self.find_reviews(url)
      reviews = []

      # iterate through the pages of reviews

      product_id = url.split('/').compact.last
      url = "http://review.kakaku.com/review/#{product_id}/"
      html = open(url, "r:CP932").read.encode("UTF-8")
      doc = Nokogiri::HTML.parse(html)
      doc.css(".reviewBox").each do |review_html|
        reviews << Review::Review.new(review_html)
      end
      # go to next page

      reviews
    end
  end
end

