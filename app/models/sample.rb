class Sample < ActiveRecord::Base
  has_paper_trail

  belongs_to :essay

  scope :between, ->(start, finish) { where(created_at: start..finish) }
  scope :for_client, ->(client_id) { includes(:essay).where(
    Essay.table_name => { client_id: client_id }
  ) }
  scope :for_user, ->(user_id) { includes(:essay).where(
    Essay.table_name => { user_id: user_id }
  ) }

  class << self
    def to_report
      all.group_by(&:element).map do |element, _scope|
        OpenStruct.new({element: element, quantity: _scope.sum(&:quantity)})
      end
    end

    def to_report_by_client(from, to)
      Client.with_essays_between(from, to).map do |client|
        [client, self.for_client(client.id).between(from, to).to_report]
      end
    end

    def to_report_by_user(from, to)
      User.with_essays_between(from, to).map do |user|
        [user, self.for_user(user.id).between(from, to).to_report]
      end
    end
  end
end
