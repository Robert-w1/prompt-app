class MessagesController < ApplicationController
  def create
    @chat = current_user.chats.find(params[:chat_id])
    category_ids = params[:message][:chat][:category_id]
    if category_ids.size > 1
      category_id = category_ids[1].to_i
      system_prompt = Category.find(category_id).system_prompt
    end

    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"

    if @message.save
      placehoder_response = "Thanks for your question. Yet I'm not able to give a specific answer. Try again tomorrow."
      response = [system_prompt, placehoder_response].compact.join("\n")
      Message.create(role: "assistant", content: response, chat: @chat)
      redirect_to chat_path(@chat)
    else
      render "chats/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
  params.require(:message).permit(:content)
  end
end
