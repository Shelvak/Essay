class Shift < ActiveRecord::Base
  SHIFT_MAX_RANGE = 8.hours

  has_paper_trail

  # Scopes
  scope :pending,     -> { where(finish_at: nil) }
  scope :finished,    -> { where.not(finish_at: nil) }
  scope :stale, -> {
    pending.where("#{table_name}.start_at < :time_ago", time_ago: 8.hours.ago)
  }
  scope :between, -> (start, finish) { where(start_at: start..finish) }

  # Restricciones
  validates :start_at, :user_id, presence: true
  validates_datetime :start_at, allow_nil: true, allow_blank: true
  validates_datetime :start_at,
    after: :start_limit, before: :finish_at,
    allow_nil: true, allow_blank: true,
    if: -> { finish_at.present? }
  validates_datetime :finish_at, after: :start_at, before: :finish_limit,
                              allow_nil: true, allow_blank: true
  # Relaciones
  belongs_to :user

  def initialize(attributes = nil)
    super(attributes)

    self.start_at ||= Time.zone.now
  end

  def pending?
    finish_at.blank?
  end

  def close!
    update_column(:finish_at, Time.zone.now)
  end

  def start_limit
    (finish_at - SHIFT_MAX_RANGE) if finish_at
  end

  def finish_limit
    self.start_at + SHIFT_MAX_RANGE
  end

  def self.worked_hours
    (
      all.to_a.sum { |s| s.finish_at - s.start_at } / 3600.0
    ).round(2)
  end
end
