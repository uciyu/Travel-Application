class RecordsController < ApplicationController
  def index
    @records = Record.includes(:user)
  end
end
