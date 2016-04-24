class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
  	@jobs = JobsTest.all
  end

  def find
  	
  end
end
