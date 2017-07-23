class DecksController < ApplicationController
    before_action :find_deck, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user! # protects new deck route from unauthenticated
                                                               # access.
    def index
        @decks = Deck.all.order("created_at DESC")
    end

    def show
        find_deck
    end

    def new
        @deck = current_user.decks.build
    end

    def create
        @deck = current_user.decks.build(deck_params) # message params is what is passed in from forms
        if @deck.save
            redirect_to root_path
        else
            render 'new'
        end
    end

    def edit
    end

    def update
        if @deck.update(deck_params)
            redirect_to deck_path
        else 
            render 'edit'
        end
    end

    def destroy 
        @deck.destroy
        redirect_to root_path
    end

    private 
    def deck_params
        params.require(:deck).permit(:title, :description, :format) # keeps code dry
    end

    def find_deck
        @deck = Deck.find(params[:id])
    end
end
