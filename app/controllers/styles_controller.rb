class StylesController < ApplicationController
  before_action :set_style, only: [:show, :edit, :destroy, :update]
  def index
    @styles = Style.all
  end

  def show
  end

  def edit
  end

  def update
    shared_update(@style, style_params)
  end

  def destroy
    @style.destroy
    respond_to do |format|
      format.html { redirect_to styles_url }
      format.json { head :no_content }
    end
  end

  private

    def set_style
      @style = Style.find(params[:id])
    end

    def style_params
      params.require(:style).permit(:name, :description)
    end
end
