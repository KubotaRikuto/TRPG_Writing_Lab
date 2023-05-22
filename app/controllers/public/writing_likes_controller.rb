class Public::WritingLikesController < ApplicationController

  def create
    writing = Writing.find(params[:writing_id])
    like = current_member.writing_likes.new(writing_id: writing.id)
　  like.save!
    redirect_to writing_path(writing)
  end

  def destroy
    writing = Writing.find(params[:writing_id])
    like = current_member.writing_likes.find_by(writing_id: writing.id)
    like.desrtoy!
    redirect_to writing_path(writing)
  end
end
