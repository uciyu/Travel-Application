class RecordsController < ApplicationController
  def index
    @records = Record.includes(:user)
  end

  def new
    @record = Record.new
  end

  # 新しい記録をデータベースに保存する処理
  def create
    @record = current_user.records.build(record_params)
    if @record.save
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
    params.require(:record).permit(:title, :body)
  end
end
