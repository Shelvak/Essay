class CustomSessionController < ApplicationController
  def quit
    #cerrar milonga
    if (pending = current_user.shifts.pending).present?
      pending.last.close!
    end

    sign_out current_user

    redirect_to new_user_session_path
  end
end
