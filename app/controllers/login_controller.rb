class LoginController < ApplicationController
  before_action :redirect_logged_user
  def new
    login_form = Login::Form.new
    render locals: { login_form: }
  end

  def create
    login_form = Login::Form.new(login_params)

    login = Login.new(login_form)

    case login.call
    in [:ok, _]
      redirect_to check_inbox_path
    in [:error, _]
      render :new, locals: { login_form: }
    end
  end

  def check_inbox
  end

  def verify_email
    verify_email = Email::Verify.new(signed_url: request.original_url, code: params[:code], email: params[:email])

    case verify_email.call
    in [:ok, user]
      SimpleAuth::Session.create(
        scope: 'user', session:, record: user
      )
      redirect_to return_to(root_path)
    in [:error, _]
      redirect_to login_path
    end
  end

  private

  def login_params
    params.require(:login).permit(:email)
  end
end
