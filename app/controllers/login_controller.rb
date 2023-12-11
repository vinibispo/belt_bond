class LoginController < ApplicationController
  def new
    login_form = Login::Form.new
    render locals: { login_form: }
  end

  def create
    login_form = Login::Form.new(login_params)

    login = Login.new(login_form.attributes)

    case login.call
    in [:error, _]
      render :new, locals: { login_form: }
    end
  end

  private

  def login_params
    params.require(:login_form).permit(:email)
  end
end
