class RecordsController < ApplicationController
  def index
    @searchprefecture = params[:search]
    # 都道府県IDでフィルタリング 中間テーブルを介して都道府県のテーブルを結合
    if @searchprefecture.present?
      @records = current_user.records.joins(:prefectures).where(prefectures: { id: @searchprefecture }).includes(:user)
    else
      # 検索条件がない場合は全てのレコードを取得
      @records = current_user.records.includes(:user)
    end
    # 前回選択した都道府県を保持
    # @prefectures = Prefecture.all
  end

  def new
    @record = Record.new
  end

  # 新しい記録をデータベースに保存する処理
  def create
    @record = current_user.records.build(record_params)
    if @record.save
      @record.record_prefectures.create(prefecture_id: params[:record][:prefecture_id])
      redirect_to records_path, success: "成功しました"
    else
      flash.now[:danger] = "作成できませんでした"
      render :new, status: :unprocessable_entity
    end
  end

  # 編集
  def edit
    @record = current_user.records.find(params[:id])
  end

  # 更新
  def update
    @record = current_user.records.find(params[:id])
    if @record.update(record_params)
      #   has_many :record_prefectures, dependent: :destroyの記述があるため:prefecture_idsが自動生成される
      @record.prefecture_ids = params[:record][:prefecture_ids] if params[:record][:prefecture_ids].present?
      # 複数枚@record.images.attach(params[:record][:images]) if params[:record][:images].present?
      redirect_to record_path(@record), success: '更新しました'
    else
      flash.now[:danger] = '更新できませんでした'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    record = current_user.records.find(params[:id])
    record.destroy!
    redirect_to records_path, success: '記録を削除しました', status: :see_other
  end

  # 記録詳細の表示
  def show
    @record = Record.find(params[:id])
  end
  
  private

  def record_params
    params.require(:record).permit(:title, :body, :date, :description, :image_cache, :image, prefecture_ids: [])
  end
end
