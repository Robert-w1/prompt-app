class SearchController < ApplicationController
  # Sets @show_sidebar = true before any action runs, same pattern as ChatsController
  before_action :enable_sidebar

  def index
    # Grab the search query from the URL params (e.g. /search?q=hello) and remove whitespace
    query = params[:q].to_s.strip

    # Only run the query if the user typed at least 2 characters
    if query.length >= 2

      # Search chats belonging to the current user where the title matches the query
      # ILIKE is case-insensitive LIKE in PostgreSQL
      # % means "anything before or after the query"
      @chats = current_user.chats
        .where("title ILIKE ?", "%#{query}%")
        .limit(5) # max 5 results per category

      # Search messages where the chat belongs to the current user
      # searching both content and name fields on the message
      # joins(chat: :user) lets us filter by the user through the chat association
      @messages = Message.joins(chat: :user)
      .where(users: { id: current_user.id })
      .where("messages.content ILIKE ? OR messages.name ILIKE ?", "%#{query}%", "%#{query}%")
      .limit(5)

      # Search projects belonging to the current user by name or description
      @projects = current_user.projects
        .where("name ILIKE ? OR description ILIKE ?", "%#{query}%", "%#{query}%")
        .limit(5)
    end

    # Only respond to JSON requests (called by our Stimulus controller via fetch)
    respond_to do |format|
      format.json {
        render json: {
          # Map each chat to a plain hash with only the fields the frontend needs
          chats: @chats&.map { |c| { id: c.id, title: c.title, type: "chat", url: chat_path(c) } },

          # truncate(80) cuts the message content to 80 characters so it fits in the dropdown
          # we show name if it exists, otherwise fall back to content
          messages: @messages&.map { |m| { id: m.id, content: m.content.truncate(80), name: m.name, type: "message", url: chat_path(m.chat) } },

          projects: @projects&.map { |p| { id: p.id, name: p.name, type: "project", url: project_path(p) } }
        }
      }
    end
  end

  private

  # Sets @show_sidebar = true so application.html.erb renders the sidebar for this page
  def enable_sidebar
    @show_sidebar = true
  end
end
