class MessagesController < ApplicationController

  def create
    @chat = current_user.chats.find(params[:chat_id])

    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"

    # TODO: Allow for multiple categories
    # cat_ids = params[:message][:chat][:category_id].compact_blank
    # unless cat_ids.empty?
    #   cat_ids = cat_ids.map { |id| id.to_i }
    #   categories = Category.where(id: cat_ids)

    #   @chat.category = categories
    #   @chat.save
    # end

    # If only one category can be selected
    unless params[:message][:chat][:category_id].empty?
      cat_id = params[:message][:chat][:category_id].to_i
      category = Category.find(cat_id)
      @chat.category = category
      @chat.save
    end

    if @message.save
      user_message = @message.content
      category_prompt = "[Categories: #{@chat.category.name}]"
      combined_message = [category_prompt, user_message].compact.join("\n\n")
      ruby_llm_chat = RubyLLM.chat
      response = ruby_llm_chat.with_instructions(system_prompt).ask(combined_message)
      Message.create(role: "assistant", content: response.content, chat: @chat)
      redirect_to chat_path(@chat)
    else
      render "chats/show", status: :unprocessable_entity
    end
  end

  private

  def system_prompt
    file_path = Rails.root.join("lib", "tasks", "system_prompt.txt")
    File.read(file_path)
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
