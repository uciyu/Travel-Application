class TopsController < ApplicationController
  before_action :require_login, only: %i[index]
  #skip_before_action :require_login, only: %i[index] ゆくゆくはこのページは誰にでも表示できるようにする
    # 都道府県ごとの集計データを作成
    def index
      # 都道府県ごとの投稿数を計算
      @prefecture_data = current_user.records.joins(:prefectures).group(:prefecture_id).count
    
      # 必要なデータを直接ビューに渡す
      @hokkaido_count = @prefecture_data[3] || 0 # prefecture_id = 3 の数。データがない場合は0を返す。
      @aomori_count = @prefecture_data[4] || 0
      @akita_count = @prefecture_data[5] || 0
      @iwate_count = @prefecture_data[6] || 0
      @yamagata_count = @prefecture_data[7] || 0
      @miyagi_count = @prefecture_data[8] || 0
      @hukushima_count = @prefecture_data[9] || 0
      @gunma_count = @prefecture_data[10] || 0
      @tochigi_count = @prefecture_data[11] || 0
      @ibaragi_count = @prefecture_data[12] || 0
      @saitama_count = @prefecture_data[13] || 0
      @tokyo_count = @prefecture_data[14] || 0
      @kanagawa_count = @prefecture_data[15] || 0
      @chiba_count = @prefecture_data[16] || 0
      @nigata_count = @prefecture_data[17] || 0
      @toyama_count = @prefecture_data[18] || 0
      @ishikawa_count = @prefecture_data[19] || 0
      @hukui_count = @prefecture_data[20] || 0
      @gihu_count = @prefecture_data[21] || 0
      @nagano_count = @prefecture_data[22] || 0
      @yamanashi_count = @prefecture_data[23] || 0
      @aichi_count = @prefecture_data[24] || 0
      @shizuoka_count = @prefecture_data[25] || 0
      @hyogo_count = @prefecture_data[26] || 0
      @kyoto_count = @prefecture_data[27] || 0
      @osaka_count = @prefecture_data[28] || 0
      @nara_count = @prefecture_data[29] || 0
      @wakayama_count = @prefecture_data[30] || 0
      @shiga_count = @prefecture_data[31] || 0
      @mie_count = @prefecture_data[32] || 0
      @yamaguchi_count = @prefecture_data[33] || 0
      @shimane_count = @prefecture_data[34] || 0
      @tottori_count = @prefecture_data[35] || 0
      @hiroshima_count = @prefecture_data[36] || 0
      @okayama_count = @prefecture_data[37] || 0
      @ehime_count = @prefecture_data[38] || 0
      @kagawa_count = @prefecture_data[39] || 0
      @kochi_count = @prefecture_data[40] || 0
      @tokushima_count = @prefecture_data[41] || 0
      @hukuoka_count = @prefecture_data[42] || 0
      @saga_count = @prefecture_data[43] || 0
      @nagasaki_count = @prefecture_data[44] || 0
      @kumamoto_count = @prefecture_data[45] || 0
      @oita_count = @prefecture_data[46] || 0
      @miyazaki_count = @prefecture_data[47] || 0
      @kagoshima_count = @prefecture_data[48] || 0
      @okinawa_count = @prefecture_data[49] || 0
    end

  def create
  end

end
