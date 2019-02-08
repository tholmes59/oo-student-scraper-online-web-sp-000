require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_page = Nokogiri::HTML(open(index_url))
    students = []
    student_page.css("div.roster-cards-container").each do |info|
      info.css(".student-card a").each do |student|
        hash = {
        :name => student.css('.student-name').text,
        :location => student.css('.student-location').text,
        :profile_url => "#{student.attribute('href')}"
        }
        students << hash
    end
  end
  students 
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    profiles = {}
    # profile_page.css("").each do |profile|
        hash = {
        :twitter => profile_page.css(".social-icon-container").children.css("a")[0].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[0],
        :linkedin => profile_page.css(".social-icon-container").children.css("a")[1].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[1],
        :github => profile_page.css(".social-icon-container").children.css("a")[2].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[2],
        :blog => profile_page.css(".social-icon-container").children.css("a")[3].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[3],
        :profile_quote => profile_page.css('.vitals-text-container .profile-quote').text if profile_page.css('.vitals-text-container .profile-quote').text,
        :bio => profile_page.css('div.bio-content.content-holder div.description-holder p').text if profile_page.css('div.bio-content.content-holder div.description-holder p').text
        }
        profiles << hash
    end
  
  profiles 
 end
  

end