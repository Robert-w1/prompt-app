class ChatsController < ApplicationController
  def index
    @chats = Chat.all
  end

  def show

  end
end
