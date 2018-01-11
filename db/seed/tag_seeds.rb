module TagSeeds
  def self.seed
    tags = [{ name: 'Node', description: 'This is node' },
      { name: 'C', description: 'This is C' },
      { name: 'C++', description: 'This is C++' }]

    Tag.create(tags)
  end
end
