class LinksController < ApplicationController
  
  before_action :authenticate_user!, except: [:home, :show]
  before_action :set_link, only: %i[ show edit update destroy ]

  # GET /links or /links.json
  def index
    @links = current_user.links.order(created_at: :desc).page params[:page]
  end

  # GET /links/1 or /links/1.json
  def show
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # POST /links or /links.json
  def create
    @link = current_user.links.build(link_params)
    respond_to do |format|
      if @link.save
        MicrolinkImageAttacherJob.perform_later(@link)
        format.html { redirect_to link_url(@link), notice: "Link was successfully created." }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
   
  end

  # DELETE /links/1 or /links/1.json
  def destroy
    @link = current_user.links.find(params[:id])
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url, notice: "Link was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search
    @query = params[:query]
    @link = current_user.links.where("links.url LIKE ?",["%#{@query}%"])
    @links = @link.order(created_at: :desc).page params[:page]
    render "index"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def link_params
      params.require(:link).permit(:url, :description, :image, :title)
    end
end
