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
      #params[:record][:image].each do |image|
       #post.memories.create(image: image, post_id: post.id)
      #end
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

  def destroy_image
    @record = current_user.records.find(params[:id])
    # recordカラムに保存された画像のURLを使って特定
    image_url = params[:image_url] 
    raise
    if @record.images.include?(image_url) # URLが存在するか確認
      @record.images.delete(image_url) # URLを削除
      @record.save # モデルを保存して変更を反映
    end
    redirect_to destroy_image_record_path(@record)
  end


  # 更新
  def update

    @record = current_user.records.find(params[:id])
    existing_images = @record.images # 既存の画像
    new_images = params[:record][:images] # 新しく追加された画像

    if @record.update(update_params)
      # has_many :record_prefectures, dependent: :destroyの記述があるため:prefecture_idsが自動生成される
      @record.prefecture_ids = params[:record][:prefecture_ids] if params[:record][:prefecture_ids].present?
      # @record.images.attach(params[:record][:images]) if params[:record][:images].present?
      @record.images = existing_images + new_images  # 既存の画像と新しい画像を合体
      @record.save # 画像を保存
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
    params.require(:record).permit(:title, :body, :date, :description, {images: []}, :images_cache, prefecture_ids: [])
  end

  def update_params
    params.require(:record).permit(:title, :body, :date, :description, prefecture_ids: [])
  end
end
