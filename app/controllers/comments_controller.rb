class CommentsController < ApplicationController
before_action :find_deck # before executing any action find the deck we are working with,
                         # no need to specify an 'only' since we want to get the deck on each operation

before_action :find_comment, only: [:edit, :update, :destroy] # same as above, but we don't need to find
                                                              # a comment for the 'create' function.
before_action :authenticate_user! # prevents unauthenticated user from creating a commment

    def create
        @comment = @deck.comments.create(comment_params)
        @comment.user_id = current_user.id
        
        if @comment.save
            redirect_to deck_path(@deck)
        else 
            render 'new'
        end
    end

    def edit
        @comment = @deck.comments.find(params[:id])
    end

    def update
        if @comment.update(comment_params)
            redirect_to deck_path(@deck)
        else 
            render 'edit'
        end
    end

    def destroy
        @comment.destroy
        redirect_to deck_path(@deck)
    end

    private
        def comment_params
            params.require(:comment).permit(:content) # grabs comment object from parameters, then sends
        end                                           # back a copy of the content inside permit

        def find_deck
            @deck = Deck.find(params[:deck_id])
        end

        def find_comment
            @comment = @deck.comments.find(params[:id])
        end

end
