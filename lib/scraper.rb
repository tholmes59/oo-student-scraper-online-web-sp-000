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
  #   profile = {}
  #   profile_page = Nokogiri::HTML(open(profile_url))
   
  #   profile[:twitter] = profile_page.css(".social-icon-container").children.css("a")[0].attribute("href").value
  #   if profile_page.css(".social-icon-container").children.css("a")[0]
  #   profile[:linkedin] = profile_page.css(".social-icon-container").children.css("a")[1].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[1]
  #   profile[:github] = profile_page.css(".social-icon-container").children.css("a")[2].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[2]
  #   profile[:blog] = profile_page.css(".social-icon-container").children.css("a")[3].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[3]
  #   profile[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
  #   profile[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")
  #   profile
  # end
  # end
  
  
  student = {}
    profile_page = Nokogiri::HTML(open(profile_slug))
    links = profile_page.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
    links.each do |link|
      if link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?("twitter")
        student[:twitter] = link
      else
        student[:blog] = link
      end
    end
    # student[:twitter] = profile_page.css(".social-icon-container").children.css("a")[0].attribute("href").value
    # # if profile_page.css(".social-icon-container").children.css("a")[0]
    # student[:linkedin] = profile_page.css(".social-icon-container").children.css("a")[1].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[1]
    # student[:github] = profile_page.css(".social-icon-container").children.css("a")[2].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[2]
    # student[:blog] = profile_page.css(".social-icon-container").children.css("a")[3].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[3]
    student[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
    student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")

    student
  end


end