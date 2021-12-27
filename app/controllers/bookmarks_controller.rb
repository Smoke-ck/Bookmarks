class BookmarksController < ApplicationController
    before_action :authenticate_user!, except: [:home, :show]
    def index
        @bookmarks = current_user.bookmarks.order(created_at: :desc).page params[:page]
    end
    def new
    end

    def destroy 
        @bookmark = current_user.bookmarks.find(params[:id])
        @bookmark.destroy
        redirect_to home_path
    end

    def create
        @bookmark = current_user.bookmarks.build(bookmark_params)
        @bookmark.save
        redirect_to home_path
    end

    def search
        @query = params[:query]
        @bookmark = current_user.bookmarks.where("bookmarks.url LIKE ?",["%#{@query}%"])
        @bookmarks = @bookmark.order(created_at: :desc).page params[:page]
        render "index"
    end    

    private def bookmark_params
        params.require(:bookmark).permit(:title, :url , :body)
    end
end
