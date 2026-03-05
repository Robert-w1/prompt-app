class ChatsController < ApplicationController
  before_action :enable_sidebar

  def index
    @chats = Chat.all
  end

  def show
    @chat = current_user.chats.find(params[:id])
    @message = Message.new
  end

  private

  def enable_sidebar
    @show_sidebar = true
  end
end
