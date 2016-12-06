require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    index_page = Nokogiri::HTML(html)

    index_page.css(".student-card").map do |person|
      {
        :name => person.css(".card-text-container h4").text,
        :location => person.css(".card-text-container p.student-location").text,
        :profile_url => "./fixtures/student-site/" + person.css("a").attr('href').text
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    profile_page = Nokogiri::HTML(html)
    new_hash = {}
    # binding.pry
    profile_page.css(".social-icon-container a").each do |soc|
      if soc.attribute('href').text.include? "twitter"
        new_hash[:twitter] = soc.attribute('href').text
      elsif soc.attribute('href').text.include? "linkedin"
        new_hash[:linkedin] = soc.attribute('href').text
      elsif soc.attribute('href').text.include? "github"
        new_hash[:github] = soc.attribute('href').text
      elsif soc.css('img').attribute("src").text.include? "rss"
        new_hash[:blog] = soc.attribute('href').text
      end
    end
    if profile_page.css(".profile-quote")
      new_hash[:profile_quote] = profile_page.css(".profile-quote").text
    end
    if profile_page.css(".description-holder p")
      new_hash[:bio] = profile_page.css(".description-holder p").text
    end
    new_hash
  end

end
