require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    html = open(index_url)
    index = Nokogiri::HTML(html)
    index.css("div.student-card").each do |student| # you got to find a css selector that contains all the studens and will iterate through all of one student information a scrape what we want
      student_details = {}
      student_details[:name] = student.css("h4.student-name").text
      student_details[:location] = student.css("p.student-location").text
      profile_path = student.css("a").attribute("href").value
      student_details[:profile_url] = profile_path
      #student_details[:profile_url] = './fixtures/student-site/' + profile_path
      students << student_details
    end
    students
    #binding.pry
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    index = Nokogiri::HTML(html)
    student_profile = {}
    social_icon_container = index.css("div.social-icon-container a")
    student_profile[:twitter] = social_icon_container[0].attribute("href").value
    student_profile[:linkedin] = social_icon_container[1].attribute("href").value
    student_profile[:github] = social_icon_container[2].attribute("href").value
    student_profile[:blog] = social_icon_container[3].attribute("href").value
    student_profile[:profile_quote] = index.css("div.profile-quote").text
    student_profile[:bio] = index.css("div.description-holder p").text
    student_profile
    #binding.pry
  end

end
