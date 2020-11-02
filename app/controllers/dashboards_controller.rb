require 'net/http'
require 'json'

class DashboardsController < ApplicationController

  def show
    # @overdue_todos = current_contact.company.projects.todos.overdue
    @services = current_contact.services.includes(:open_todos, :reports, :service_type)
    @projects = current_contact.projects.includes(:open_todos, :project_status)
    @show_welcome_section = current_contact.show_welcome_section
    @welcome_text = WelcomeSection.last.present? ? WelcomeSection.first.welcome_text.html_safe : ""
    @ads = Advertisement.order("RANDOM()").by_company(current_contact.company).limit(3)
    @blog_articles = get_blog_articles
  end

  def dismiss_welcome
    current_contact.update_attribute(:show_welcome_section, false)
    redirect_to dashboard_path
  end

  private

  def get_blog_articles
    url = "https://rockpapersimple.com/wp-json/wp/v2/posts?per_page=5"
    uri = URI(url)
    response = Rails.cache.fetch('latest_blog_articles', expires_in: 10.minutes) do
      Net::HTTP.get(uri)
    end

    parsed_response = response.present? ? JSON.parse(response) : nil
    
    if(parsed_response.kind_of?(Array))
      parsed_response
    else
      Rails.logger.error("[ERROR] Error getting blog posts from rockpapersimple.com: #{response}")
      []
    end
  end

end
