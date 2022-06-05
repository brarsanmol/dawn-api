require 'kimurai'

class CoursesSpider < Kimurai::Base
  @name = 'courses_spider'
  @engine = :mechanize
  @start_urls = ['https://www.mcgill.ca/study/2022-2023/courses/search']
  @config = {}

  def parse(response, url:, data: {})
    urls = []
    response.search('.pager-last > a').each do |link|
      pages = link[:href].partition('=').last.to_i
      (0..pages).each { |index|
        urls << "https://www.mcgill.ca/study/2022-2023/courses/search?page=#{index}"
      }
    end

    in_parallel(:parse_courses_page, urls, threads: 3)
  end

  def parse_courses_page(response, url:, data: {})
    20.times do |index|
      parse_course(response, index)
    end
  end

  def parse_course(response, index)
    name = response.search("div.views-row-#{index} > div.views-field-field-course-title-long > h4 > a").text.strip
    faculty = response.search("div.views-row-#{index} > span.views-field-field-faculty-code > span").text.strip
    department = response.search("div.views-row-#{index} > span.views-field-field-dept-code > span").text.strip
    level = response.search("div.views-row-#{index} > span.views-field-level > span").text.strip
    terms = response.search("div.views-row-#{index} > span.views-field-terms > span").text.strip.split(', ')

    course = Course.new(name:, faculty:, department:, level:, terms:)
    course.save
  end
end