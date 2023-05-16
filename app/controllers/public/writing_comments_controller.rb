class Public::WritingCommentsController < ApplicationController

  def create
    writing = Writing.find(params[:writing_id])
    comment = current_member.writing_comments.new(writing_comment_params)
    comment.writing_id = writing.id
    if comment.save!
      flash[:notice] = "コメントを投稿しました。"
      redirect_to writing_path(writing)
    else
      flash[:notice] = "コメントの投稿に失敗しました。"
      redirect_to writing_path(writing)
    end
  end

  def destroy
    writing = Writing.find(params[:writing_id])
    if WritingComment.find(params[:id]).destroy
      flash[:notice] = "コメントは削除されました。"
      redirect_to writing_path(writing.id)
    else
      flash[:notice] = "コメントの削除に失敗しました。"
      redirect_to writing_path(writing.id)
    end
  end

  private

  def writing_comment_params
    params.require(:writing_comment).permit(:comment)
  end
end
