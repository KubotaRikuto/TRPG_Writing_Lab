class Public::WorksController < ApplicationController
  # ログイン確認
  before_action :authenticate_member!

  def indx
    @works = Work.active.page(params[:page])
  end

  def show
    @work = current_member.works.find(params[:id])
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

  def work_paramas
    params.require(:work).permit(:title, :summary, :work_type, :max_players, :min_players, :max_play_time, :min_play_time, :dificulty)
  end

end
