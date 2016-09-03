class ApplicationController < ActionController::Base
  include Application::CancanStrongParameters

  Warden::Manager.before_logout do |user,auth,opts|
    if (pending = user.shifts.pending).present?
      pending.last.close!
    end
  end

  protect_from_forgery
  before_action :set_paper_trail_whodunnit, :check_shifts
  after_action -> { expires_now if user_signed_in? }

  def user_for_paper_trail
    current_user.try(:id)
  end

  private

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  def after_sign_in_path_for(resource)
    create_shift
    users_path
  end

  def redirect_to_stale(shift)
    redirect_to edit_shift_path(shift)
  end

  def check_shifts
    return unless current_user
    stale = current_user.shifts.stale
    if session[:stale_shift] && stale.present?
      redirect_to_stale(stale)
    end
  end

  def create_shift
    shifts = current_user.shifts

    if (stale = shifts.stale).present?
      session[:stale_shift] = true
      redirect_to_stale(stale.last)
    end

    unless shifts.pending.present?
      shifts.create!
    end
  end
end
