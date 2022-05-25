class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    if request.post?
      unless params[:email].blank?
        if params[:pass] == params[:pass2]
          user = User.create(name: params[:name], email: params[:email].downcase, password: params[:pass])
          sign_in user
          render json: { url: url_for(controller: "work", action: "vacancy") }
        end
      end
    else render "signup"
    end
  end

  def create
    if request.post?
      unless params[:email].blank?
        begin
          user = User.find_by!(email: params[:email].downcase)
          if user && user.authenticate(params[:pass])
            sign_in user
            render "login"
          else @error = 1
          render "login"
          end
        rescue ActiveRecord::RecordNotFound
          @error = 1
          render "login"
        end
      end
    else render "login"
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

end
  