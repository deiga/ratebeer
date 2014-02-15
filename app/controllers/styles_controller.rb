class StylesController < ApplicationController
  before_action :set_style, only: [:show, :edit]
  def index
    @styles = Style.all
  end

  def show
  end

  def edit
  end

  private

    def set_style
      @style = Style.find(params[:id])
    end
end
