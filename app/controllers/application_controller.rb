class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :find_user, :require_login

  def render_404
    # DPR: supposedly this will actually render a 404 page in production
    raise ActionController::RoutingError.new('Not Found')
  end

  protected
  def require_login
    @user = User.find_by(id: session[:user_id])
    unless @user
      flash[:status] = :failure
      flash[:result_text] = "You must be logged in to do that!"
      redirect_to root_path
    end
  end

  def save_and_flash(model)


    if model
      flash[:status] = :success
      flash[:message] = "Successfully saved #{model.class} #{Model.id}"
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Failed to save #{model.class}"
      flash.now[:deltails] = model.errors.messages
    end
    return model
  end

  private
  def find_user
    if session[:user_id]
      @login_user = User.find_by(id: session[:user_id])
    end
  end
end
