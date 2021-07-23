class ScrapeSiteJob < ApplicationJob
  queue_as :default

  def perform
    # Do something later
    sc = Scraper.new
    data = sc.iter_pages

    Offer.add_multiple(data)
  end
end
