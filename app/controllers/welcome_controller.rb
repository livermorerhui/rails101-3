class WelcomeController < ApplicationController
  def index
    flash[:notice] = "你好！早安绿！"
    flash[:alert] = "该睡了！晚安红！"
    flash[:warning] = "警示⚠️黄！"
  end
end
