class RecordsController < ApplicationController
  def index
    @records = Record.includes(:user)
  end

  def new
    @record = Record.new
  end

  # 新しい掲示板をデータベースに保存する処理
  def create
    @record = current_user.records.build(record_params)
    if @record.save
      redirect_to records_path, success: "成功しました"
    else
      flash.now[:danger] = "作成できませんでした"
      render :new, status: :unprocessable_entity
    end
  end
  
  private

  def record_params
    params.require(:record).permit(:title, :body)
  end
end
