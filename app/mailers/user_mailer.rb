class UserMailer < ActionMailer::Base
  include Devise::Mailers::Helpers
  helper :application # gives access to all helpers defined within `application_helper`.
  default from: "ersgamejam2022@gmail.com"

  def confirmation_instructions(record, token, opts = {})
    @token = token
    devise_mail(record, :confirmation_instructions, opts)
  end

  def reset_password_instructions(record, token, opts = {})
    @token = token
    devise_mail(record, :reset_password_instructions, opts)
  end

  def unlock_instructions(record, token, opts = {})
    @token = token
    devise_mail(record, :unlock_instructions, opts)
  end

  def email_changed(record, opts = {})
    devise_mail(record, :email_changed, opts)
  end

  def password_change(record, opts = {})
    devise_mail(record, :password_change, opts)
  end
  def weekly_newsletter
    User.find_each do |user|
    @destinations = FavDestination.where(user_id: user.id).where(visited: false || nil).limit(3)
    mail(to: user.email, subject: "Reminder to visit these destinations!")
    end
    end
end

