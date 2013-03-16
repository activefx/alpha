class Role
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name,        :type => String
  field :position,    :type => Integer, :default => 0

  has_and_belongs_to_many :users
  belongs_to :resource, :polymorphic => true

  validates_uniqueness_of :position

  default_scope asc(:position)

  index({ :name => 1 }, { :unique => true })

  index(
    {
      :name => 1,
      :resource_type => 1,
      :resource_id => 1
    },
    {
      :unique => true
    }
  )

  scopify
end
