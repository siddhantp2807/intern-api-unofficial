require 'nokogiri'
require 'httparty'


class Scraper
    attr_accessor :page_no, :total_pages, :max_pages
    def initialize(page_no=1)
        @page_no = page_no
    end

    def read

        doc = HTTParty.get("https://internshala.com/internships/page-#{@page_no}")
        parsed_doc = Nokogiri::HTML(doc.body)
        
        delta =  parsed_doc.css("a.view_detail_button").map {|x| x.attribute("href").value}
        
        if @page_no == 1 
            @total_in_page = delta.count
            @max_pages = (parsed_doc.css("div.heading.heading_4_6")[0].text.match(/\d+/).to_s.to_f/delta.count.to_f).ceil
        end

        arr = []
        delta.each do |x|
            job = Job.new(x)
            job.get_details
            arr << job.values
        end

        arr
    end

    def iter_pages

        full = self.read
        @page_no += 1
        sleep(5)
        while @page_no <= 10
            puts "Scraping Page: #{@page_no}"
            full += self.read
            @page_no += 1
            sleep(5)
        end

        full
    end
end
