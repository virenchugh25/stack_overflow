module SessionSeeds
  def self.seed
    users = User.first(3)
    sessions = []

    users.each do |user| 
      3.times { sessions << { user: user, auth_token: SecureRandom.hex(12) } }
    end

    Session.create(sessions)
  end
end
