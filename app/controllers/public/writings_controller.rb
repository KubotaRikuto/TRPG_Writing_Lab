class Public::WritingsController < ApplicationController
  # ログイン確認
  before_action :authenticate_member!
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]
  before_action :select_trpg_rules, only: [:new, :edit, :create, :update]


  def index
    @writings = Writing.published.page(params[:page])
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

  def word_search
    @tag_list = Tag.all
    keyword = params[:word]
    @writings = Writing.joins(:member, :trpg_rule).search(keyword)
    if @writings.count > 0 && keyword.present?
      flash.now[:notice] = "#{@writings.count}件の作品が見つかりました。"
    else
      flash[:alert] = "作品が見つかりませんでした。"
      redirect_to writings_path
    end
  end

  def tag_search
  end

  private

  def writing_params
    params.require(:writing).permit(:title, :summary, :writing_type, :max_players, :min_players, :max_play_time, :min_play_time, :difficulty, :trpg_rule_id)
  end

  def select_trpg_rules
    @trpg_rules = TrpgRule.all
  end
end
