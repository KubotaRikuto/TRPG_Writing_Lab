class Public::WritingLikesController < ApplicationController

  def create
    writing = Writing.find(params[:writing_id])
    writing_like = current_member.writing_likes.new(writing_id: writing.id)
    writing_like.save
    redirect_to writing_path(writing.id)
  end

  def destroy
    writing = Writing.find(params[:writing_id])
    writing_like = current_member.writing_likes.find_by(writing_id: writing.id)
    writing_like.destroy
    redirect_to writing_path(writing.id)
  end
end
