class Admin::WritingCommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @comments = WritingComment.all
    @new_comments = WritingComment.all.order(updated_at: :desc).limit(10)
  end

  def destroy
    writing = Writing.find(params[:writing_id])
    if WritingComment.find(params[:id]).destroy
      flash[:notice] = "コメントは削除されました。"
      redirect_to admin_writing_path(writing.id)
    else
      flash[:notice] = "コメントの削除に失敗しました。"
      redirect_to admin_writing_path(writing.id)
    end
  end

  private

  def writing_comment_params
    params.require(:writing_comment).permit(:comment)
  end
end
