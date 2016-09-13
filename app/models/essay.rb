class Essay < ActiveRecord::Base
  has_paper_trail

  belongs_to :user
  belongs_to :client
  has_many :samples

  validates :title, presence: true
  validates :samples, length: { minimum: 1, message: I18n.t('view.essays.need_at_least_one_sample') }
  before_validation :mark_for_destroy

  accepts_nested_attributes_for :samples, reject_if: -> (attrs) {
      attrs[:element].blank? || attrs[:quantity].to_i.zero?
    }, allow_destroy: true

  def to_s
    title
  end

  def initialize(attributes)
    super(attributes)

    self.samples.build if self.samples.empty?
  end

  def mark_for_destroy
    self.samples.each do |sample|
      if sample.element.blank? || sample.quantity.zero?
        sample.mark_for_destruction
      end
    end
  end
end
