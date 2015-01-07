class Tweet 
  include Neo4j::ActiveNode
  property :message, type: String
  property :updated_at
  property :created_at

  has_one :in, :user, type: :tweeted

  validates :message, presence: true

end
