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

  # 記録詳細の表示
  def show
    @record = Record.find(params[:id])
  end
  
  private

  def record_params
    params.require(:record).permit(:title, :body)
  end
end
