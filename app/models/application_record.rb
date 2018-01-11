class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  include Commentable
  include Revisable
  include SoftDelete
  include Votable
end
