class Admin::TagsController < ApplicationController

  def index
    @tag = Writing.new
    @tags = Writing.tag_counts_on(:tags)
  end

  def edit
  end

  def create
    @tag = Writing.new(tag_params)
    @tag.member_id = current_admin.id
    @tag.tag_list = params[:writing][:tag_list]
    if @tag.save!
      flash[:notice] = "作品を新しく投稿しました。"
      redirect_to admin_tags_path
    else
      @tags = Writing.tag_counts_on(:tags)
      flash[:notice] = "作品投稿に失敗しました。"
      render :index
    end
  end

  def update
  end

  private

  def tag_params
    params.require(:writing).permit(:tag_list)
  end
end
