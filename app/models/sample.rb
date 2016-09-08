class Sample < ActiveRecord::Base
  has_paper_trail

  belongs_to :essay

  scope :between, ->(start, finish) { where(created_at: start..finish) }

  def self.to_report
    all.group_by(&:element).map do |element, _scope|
      OpenStruct.new({element: element, quantity: _scope.sum(&:quantity)})
    end
  end
end
