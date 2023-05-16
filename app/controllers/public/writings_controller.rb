class Public::WritingsController < ApplicationController
  # ログイン確認
  before_action :authenticate_member!
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :select_trpg_rules, only: [:new, :edit, :create, :update]


  def index
    @writings = Writing.page(params[:page])
    @tag_list = Tag.all
  end

  def show
    @writing = Writing.find(params[:id])
    @writing_tags = @writing.tags
    @writing_comment = WritingComment.new
  end

  def new
    @writing = Writing.new
    @tag_list = Tag.all
  end

  def edit
    @writing = current_member.writings.find(params[:id])
    @tag_list = Tag.all
    @writing_tags = @writing.tags.pluck(:tag_name).join(',')
  end

  def create
    @writing = Writing.new(writing_params)
    @writing.member_id = current_member.id
    tag_list = params[:writing][:tag_name].delete(' ').delete('　').split(',')
    if @writing.save
      @writing.save_tag(tag_list)
      flash[:notice] = "作品を新しく投稿しました。"
      redirect_to writing_path(@writing.id)
    else
      @writing = Writing.new
      @tag_list = Tag.all
      flash[:notice] = "作品投稿に失敗しました。"
      render :new
    end
  end

  def update
    @writing = current_member.writings.find(params[:id])
    tag_list = params[:writing][:tag_name].delete(' ').delete('　').split(',')
    if @writing.update(writing_params)
      @writing.save_tag(tag_list)
      flash[:notice] = "作品が更新されました。"
      redirect_to writing_path(@writing.id)
    else
      @writing = current_member.writings.find(params[:id])
      flash[:notice] = "作品の更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    @writing = current_member.writings.find(params[:id])
    @writing.destroy
    redirect_to writings_path
  end

  private

  def writing_params
    params.require(:writing).permit(:title, :summary, :writing_type, :max_players, :min_players, :max_play_time, :min_play_time, :difficulty, :trpg_rule_id)
  end

  def is_matching_login_user
    @writing = Writing.find(params[:id])
    user_id = @writing.member.id
    login_user_id = current_member.id
    if (user_id != login_user_id )
      redirect_to writings_path
    end
  end

  def select_trpg_rules
    @trpg_rules = TrpgRule.all
  end
end
