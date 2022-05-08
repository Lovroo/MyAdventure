class WeatherMailerJob
  include Sidekiq::Job
  queue_as :default

  def perform(*args)
    User.find_each do |user|
      UserMailer.with(user: user, destinations: FavDestination.where(user_id: user.id).where(visited: false).limit(3)).weekly_newsletter.deliver_now
    end
  end
end
