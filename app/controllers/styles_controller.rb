class StylesController < ApplicationController
  before_action :set_style, only: [:show, :edit, :destroy]
  def index
    @styles = Style.all
  end

  def show
  end

  def edit
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
end
