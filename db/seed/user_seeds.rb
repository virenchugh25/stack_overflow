module UserSeeds
  def self.seed
    users = [{ name: 'Viren Chugh', email: 'viren.chugh@1mg.com' },
      { name: 'Aamod', email: 'aa@aa.com' },
      { name: 'Asura', email: 'asura@gmail.com' }]

    users.each do |user|
      user[:password] = 'abcd'
    end
    User.create(users)
  end
end
