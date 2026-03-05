class ChatsController < ApplicationController
  before_action :enable_sidebar

  def index
    @chats = current_user.chats.all
  end

  def show
    @chat = current_user.chats.find(params[:id])
    @message = Message.new
  end

  def create
    @chat = Chat.new(title: "Untitled")
    @chat.user = current_user

    if @chat.save
      redirect_to chat_path(@chat)
    else
      @chats = Chat.where(user: current_user)
      render "chats"
    end
  end

  private

  def enable_sidebar
    @show_sidebar = true
  end
end
