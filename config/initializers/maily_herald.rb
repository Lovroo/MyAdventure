
MailyHerald.setup do |config|
  config.context :all_users do |context|
    context.scope {User.all}
    context.destination {|user| user.email}
    context.attributes do |user|
      attribute_group(:user) do
        attribute(:email) {user.email}
        attribute(:created_at) {user.created_at}
      end
    end
  end

  config.list :all_users do |list|
    list.context_name = :all_users
  end

  config.periodical_mailing :weekly_newsletter do |mailing|
    mailing.title = "Weekly destination weather update"
    mailing.list = :all_users
    mailing.mailer_name = "UserMailer"
    mailing.start_at = Time.now + 5.minutes
    mailing.period = 1.week
    mailing.enable
  end
end