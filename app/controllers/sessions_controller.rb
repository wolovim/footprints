class SessionsController < ApplicationController
  def create
    auth_params       = ActionController::Parameters.new({uid: auth_hash.uid,
                                                         provider: auth_hash.provider,
                                                         nickname: auth_hash["info"].nickname,
                                                         name: auth_hash["info"].name,
                                                         image: auth_hash["info"].image
                                                        }).permit(:provider, :uid, :name, :nickname, :image)
    user              = User.from_omniauth(auth_params)
    session[:user_id] = user.id
    redirect_to root_path, notice: "Welcome"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def bounce
    redirect_to "/auth/#{params[:providor]}"
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end