class Public::TagsController < ApplicationController
  def index
    @tags = Tag.order(:tag_name)
  end

  private

  def tag_params
    params.require(:tag).permit(:tag_name)
  end
end
