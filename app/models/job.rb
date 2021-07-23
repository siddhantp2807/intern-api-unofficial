require 'nokogiri'
require 'httparty'

class Job
    attr_accessor :scraped_at, :base, :header, :url, :id, :co, :locus, :begin_date, :duration, :pay, :expiration, :co_url, :tags, :applicants
    
    def initialize(smth)
        @base = "https://internshala.com"
        @header = smth.css("div.profile a").text.strip || ""
        @url = smth.css("div.profile a")[0].attributes["href"].value || ""
        @id = smth.attributes["internshipid"].value.to_i || ""
        
        @co_name = smth.css("div.company_name a").text.strip || ""

        @locus = smth.css("div#location_names span a").map {|t| t.text} || ""
        
        @begin_date = smth.css("div#start-date-first span").map {| elmt | elmt.text} || ""
        @duration = smth.css("div.other_detail_item div.item_body")[1].text.strip || ""
        pay_raw = smth.css("span.stipend")
        pay = pay_raw.text.scan(/\d+/).to_a != [] ? pay_raw.text.scan(/\d+/).to_a : ["0", "0"]
        @pay_struct = pay_raw.text.match(/[a-zA-Z]+/).to_s.downcase
        @min_pay = pay.first.to_i
        @max_pay = pay.last.to_i
        @exp_str = smth.css("div.other_detail_item div.item_body")[3].text.strip.scan(/[a-zA-Z0-9]+/).join(" ")
        begin
            @exp_stamp = DateTime.strptime(@exp_str, "%d %b %y")  
        rescue
            @exp_stamp = ""
        end
    end

    def get_details
        page = HTTParty.get(@base + @url)
        parsed_page = Nokogiri::HTML(page.body)
        begin
            @co_url = parsed_page.css("div.website_link a")[0].attributes['href'].value
        rescue
            @co_url = ""
        end

        begin
            @tags = parsed_page.css("div.round_tabs_container span.round_tabs").map {|d| d.text }
        rescue
            @tags = []
        end

        begin
            @applicants = parsed_page.css("div.applications_message").text.split("applicants")[0].to_i
        rescue
            @applicants = -1
        end
        @openings = parsed_page.css("div.text-container").last.text.strip.to_i
    end

    def values
        hash = {}
        self.instance_variables.each {|var| hash[var.to_s.delete("@")] = self.instance_variable_get(var) }

        hash
    end
end

