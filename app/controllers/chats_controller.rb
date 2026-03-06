class ChatsController < ApplicationController
  before_action :enable_sidebar

  def index
    # Order chats newest first for the index view
    @chats = current_user.chats.order(created_at: :desc)
  end

  def show
    @chat = current_user.chats.find(params[:id])
    @message = Message.new
  end

  def create
    @chat = Chat.new(title: Chat::DEFAULT_TITLE)
    @chat.user = current_user

    if @chat.save
      redirect_to chat_path(@chat)
    else
      @chats = Chat.where(user: current_user)
      render "chats"
    end
  end

  def destroy
    # Find the chat belonging to current user and delete it
    @chat = current_user.chats.find(params[:id])
    @chat.destroy
    redirect_to chats_path, notice: "Chat deleted"
  end

  private

  def enable_sidebar
    @show_sidebar = true
  end
end
