class SearchesController < ApplicationController

    def create
        p 'params = '
        p params
        term = params[:term]
        drinks = Search.search_for(term)
        render json: drinks
    end

end
