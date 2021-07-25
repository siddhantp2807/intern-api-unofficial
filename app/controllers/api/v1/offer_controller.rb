class Api::V1::OfferController < ApplicationController
    before_action only: [:show]

    def index
        number = params[:count].nil? ? 40 : params[:count]
        @offers = Offer.last(number)

        render json: @offers    
    end

    def show
        id = params[:id]
        @offer = Offer.where(id: id)

        render json: @offer
    end

    def filter

        count = params[:count].nil? ? 40 : params[:count]

        if params[:tags].nil? or params[:tags] == ""
            @selected_offers = Offer.all
        elsif params[:tags] == "all"
            @selected_offers = Offer.all
        else
            tgs = params[:tags].split(",").map { |pr| pr.strip }.select { |t| Tag.where(name: t) != [] }
            select_by_tag = []
            tgs.map { |t| select_by_tag += Tag.where(name: t).first.offers.all }
            @selected_offers = select_by_tag.uniq
        end
        
        @selected_offers = @selected_offers.select { |offer| Offer.select_by_pay(params[:max_pay], params[:min_pay], offer) }

        render json: @selected_offers.last(count)
    end

end
