class SomeDir::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    render text: omniauth
  end

  private 

    def omniauth
      @omniauth ||= request.env["omniauth.auth"].slice(:provider, :uid)
    end

end