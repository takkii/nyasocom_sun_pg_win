class TwoStepVerificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :strong_auth_check, :only => [ :new ]

  def new
    @otp_secret = ROTP::Base32.random
    totp = ROTP::TOTP.new(
      @otp_secret, issuer: 'nyasocom sun'
    )
    @qr_code = RQRCode::QRCode
      .new(totp.provisioning_uri(current_user.email))
      .as_png(resize_exactly_to: 200)
      .to_data_url
  end

  def create
    @otp_secret = params[:otp_secret]
    totp = ROTP::TOTP.new(
      @otp_secret, issuer: 'nyasocom sun'
    )

    last_otp_at = totp.verify(
      params[:otp_attempt], drift_behind: 15
    )

    if last_otp_at
      current_user.update(
        otp_secret: @otp_secret, last_otp_at: last_otp_at
      )
      redirect_to(
        root_path,
        notice: 'Successfully configured OTP protection for your account'
      )
    else
      @qr_code = RQRCode::QRCode
        .new(totp.provisioning_uri(current_user.email))
        .as_png(resize_exactly_to: 200)
        .to_data_url
      flash.now[:alert] = 'The code you provided was invalid!'
      render :new
    end
  end

  private
  def strong_auth_check
    @user = User.find_by(params[:id])
    if current_user.id != @user.id
      raise_not_found!
    end
  end
end
