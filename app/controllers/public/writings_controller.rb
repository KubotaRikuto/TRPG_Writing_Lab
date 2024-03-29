class Public::WritingsController < ApplicationController
  # ログイン確認
  before_action :authenticate_member!
  # ログインユーザー以外の情報編集・削除不可
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]
  # 非公開投稿への画面遷移不可
  before_action :require_public_writing, only: [:show, :edit]

  def index
    @writings = Writing.published.order(created_at: :desc).page(params[:page])
    @tag_list = Tag.left_joins(:writing_tags).group(:id).order('COUNT(writing_tags.tag_id) DESC').limit(10)
  end

  def show
    @writing = Writing.find(params[:id])
    @writing_tags = @writing.tags
    @tag_list = Tag.left_joins(:writing_tags).group(:id).order('COUNT(writing_tags.tag_id) DESC').limit(10)
    @writing_comment = WritingComment.new
    @comment_list = @writing.writing_comments.order(created_at: :desc).page(params[:page])
  end

  def new
    @writing = Writing.new
    @trpg_rules = TrpgRule.all
    @tag_list = Tag.left_joins(:writing_tags).group(:id).order('COUNT(writing_tags.tag_id) DESC').limit(10)
  end

  def edit
    @writing = current_member.writings.find(params[:id])
    @trpg_rules = TrpgRule.all
    @tag_list = Tag.left_joins(:writing_tags).group(:id).order('COUNT(writing_tags.tag_id) DESC').limit(10)
    @writing_tags = @writing.tags.pluck(:tag_name).join(',')
  end

  def create
    @writing = Writing.new(writing_params)
    @writing.member_id = current_member.id
    @trpg_rules = TrpgRule.all
    tag_list = params[:writing][:tag_name].delete(' ').delete('　').split(',')
    if @writing.save
      @writing.save_tag(tag_list)
      flash[:notice] = "作品を新しく投稿しました。"
      redirect_to writing_path(@writing.id)
    else
      @writing = Writing.new
      @tag_list = Tag.all
      flash[:alert] = "作品投稿に失敗しました。"
      render :new
    end
  end

  def update
    @writing = current_member.writings.find(params[:id])
    @trpg_rules = TrpgRule.all
    tag_list = params[:writing][:tag_name].delete(' ').delete('　').split(',')
    if @writing.update(writing_params)
      @writing.save_tag(tag_list)
      flash[:notice] = "作品が更新されました。"
      redirect_to writing_path(@writing.id)
    else
      @writing = current_member.writings.find(params[:id])
      flash[:alert] = "作品の更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    @writing = current_member.writings.find(params[:id])
    @writing.destroy
    redirect_to writings_path
  end

  def word_search
    @tag_list = Tag.left_joins(:writing_tags).group(:id).order('COUNT(writing_tags.tag_id) DESC').limit(10)
    keyword = params[:word]
    @writing_results = Writing.joins(:member, :trpg_rule).published.search(keyword)
    @writings = @writing_results.order(created_at: :desc).page(params[:page])
    if @writings.count > 0 && keyword.present?
      flash.now[:notice] = "「#{keyword}」の検索結果 - #{@writing_results.count}件"
    else
      flash[:alert] = "「#{keyword}」に該当する作品は見つかりませんでした。別の検索ワードをお試しください。"
      redirect_to writings_path
    end
  end

  def tag_search
    @tag_list = Tag.left_joins(:writing_tags).group(:id).order('COUNT(writing_tags.tag_id) DESC').limit(10)
    @tag = Tag.find(params[:tag_id])
    @writing_results = @tag.writings.published.all
    @writings = @writing_results.order(created_at: :desc).page(params[:page])
    if @writings.count > 0
      flash.now[:notice] = "「#{@tag.tag_name}」の検索結果 - #{@writing_results.count}件"
    else
      flash[:alert] = "「#{@tag.tag_name}」に該当する作品は見つかりませんでした。別の検索タグをお試しください。"
      redirect_to writings_path
    end
  end

  private

  def writing_params
    params.require(:writing).permit(:title, :summary, :writing_type, :max_players, :min_players, :max_play_time, :min_play_time, :difficulty, :trpg_rule_id, :writing_image, :writing_zip)
  end

  # 非公開投稿への画面遷移不可
  def require_public_writing
    writing = Writing.find(params[:id])
    unless writing.is_public
      redirect_to writings_path
    end
  end
end
