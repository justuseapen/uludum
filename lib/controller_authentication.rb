# This module is included in your application controller which makes
# several methods available to all controllers and views. Here's a
# common example you might add to your application layout file.
#
#   <% if logged_in? %>
#     Welcome <%= current_user.username %>.
#     <%= link_to "Edit profile", edit_current_user_path %> or
#     <%= link_to "Log out", logout_path %>
#   <% else %>
#     <%= link_to "Sign up", signup_path %> or
#     <%= link_to "log in", login_path %>.
#   <% end %>
#
# You can also restrict unregistered users from accessing a controller using
# a before filter. For example.
#
#   before_filter :login_required, :except => [:index, :show]
module ControllerAuthentication
  def self.included(controller)
    controller.send :helper_method, :current_user, :logged_in?, :redirect_to_target_or_default
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  def login_required
    unless logged_in?
      store_target_location
      redirect_to signup_url(return_to: request.fullpath), :alert => "You must first log in or sign up before accessing this page."
    end
  end

  def redirect_to_target_or_default(default, *args)
    redirect_to(session[:return_to] || default, *args)
    session[:return_to] = nil
  end

  def persist_login(user)
    session[:user_id] = user.id
  end

  def stripe_connect_path
    params = {
      stripe_user: {
        email: current_user.email,
        url: user_url(current_user),
        product_type: :education,
      },
    }
    "/auth/stripe_connect?#{params.to_query}"
  end

  def is_admin?
    logged_in? && current_user.is_admin?
  end

  private

  def store_target_location
    session[:return_to] = request.url
  end
end
