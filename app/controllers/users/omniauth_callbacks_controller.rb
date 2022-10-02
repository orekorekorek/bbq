class Users::OmniauthCallbacksController < ApplicationController
  def github
    @user = User.find_for_gh_oauth(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: 'GitHub')
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:alert] = I18n.t('omniauth.failure')
      redirect_to new_user_registration_path
    end
  end

  def yandex
    @user = User.find_for_ya_oauth(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: 'Yandex')
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:alert] = I18n.t('omniauth.failure')
      redirect_to new_user_registration_path
    end
  end

  def failure
    flash[:alert] = 'не работает(('

    redirect_to root_path
  end
end
