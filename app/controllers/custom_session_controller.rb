class CustomSessionController < ApplicationController
  def quit
    #cerrar milonga
    if (pending = current_user.shifts.pending).present?
      pending.last.close!
    end
    redirect_to sign_in_path
  end
end
