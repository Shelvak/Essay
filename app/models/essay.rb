class Essay < ActiveRecord::Base
  has_paper_trail

  belongs_to :user
  has_many :samples

  accepts_nested_attributes_for :samples

  def to_s
    title
  end
end
