class Client < ActiveRecord::Base
  has_paper_trail

  scope :with_essays_between, ->(from, to) { includes(:essays).where(
    Essay.table_name => { created_at: from..to }
  ) }

  has_many :essays

  def self.search(q: nil, limit: false)
    result = all

    if q.present?
      result = result.where "#{table_name}.name ILIKE ?", "%#{q.strip}%"
    end

    limit ? result.limit(limit) : result
  end

  def to_s
    name
  end
end
