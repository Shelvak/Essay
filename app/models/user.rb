class User < ActiveRecord::Base
  include Users::Roles

  has_paper_trail

  devise :database_authenticatable, :recoverable, :rememberable, :trackable,
    :validatable, :registerable

  # Default order
  default_scope { order("#{table_name}.lastname ASC") }

  scope :with_essays_between, ->(from, to) { includes(:essays).where(
    Essay.table_name => { created_at: from..to }
  ) }

  # Validations
  validates :name, presence: true
  validates :name, :lastname, length: { maximum: 255 }, allow_nil: true,
    allow_blank: true
  validates :email, presence: true, length: { maximum: 255 },
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i },
    allow_nil: true, allow_blank: true, uniqueness: { case_sensitive: false }

  has_many :essays
  has_many :shifts

  def to_s
    [self.name, self.lastname].compact.join(' ')
  end
end
