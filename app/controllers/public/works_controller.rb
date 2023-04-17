class Public::WorksController < ApplicationController
  # ログイン確認
  before_action :authenticate_member!
  before_action :is_matching_login_user, only: [:edit, :update]


  def index
    @works = Work.page(params[:page])
  end

  def show
    @work = Member.works.find(params[:id])
  end

  def new
    @work = Work.new
  end

  def edit
    @work = current_member.works.find(params[:id])
  end

  def create
    @work = Work.new(work_paramas)
    if @work.save
      flash[:notice] = "作品を新しく投稿しました。"
      redirect_to work_path(@work.id)
    else
      @work = Work.new
      flash[:notice] = "作品投稿に失敗しました。"
      render :new
    end
  end

  def update
    @work = current_member.works.find(params[:id])
    if @work.update(params[:id])
      flash[:notice] = "作品が更新されました。"
    else
      @work = current_member.works.find(params[:id])
      flash[:notice] = "作品の更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    @work = current_member.works.find(params[:id])
    @work.destroy
    redirect_to works_path
  end

  private

  def work_paramas
    params.require(:work).permit(:title, :summary, :work_type, :max_players, :min_players, :max_play_time, :min_play_time, :difficulty)
  end

  def is_matching_login_user
    @work = Work.find(params[:id])
    user_id = @work.member.id
    login_user_id = current_member.id
    if (user_id != login_user_id )
      redirect_to works_path
    end
  end
end
