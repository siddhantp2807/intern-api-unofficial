class Api::V1::TagController < ApplicationController
    before_action only: [:show]

    def index
        
        @tags = Tag.all

        render json: @tags
    end

    def show
        id = params[:id]

        @tag = Tag.where(id: id).first

        render json: @tag

    end

end