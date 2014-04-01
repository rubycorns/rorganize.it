class DevelopmentMailInterceptor
  def self.delivering_email(message)
    message.subject = "[#{message.to}] #{message.subject}"
    # sends msg to YOU! (as a github user)
    message.to = [`git config --get user.email`.strip]
    # or else to tam in worse case scenario
    message.to = "tam.eastley@gmail.com" if message.to.empty?
  end
end