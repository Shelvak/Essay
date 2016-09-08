class ReportsController < ApplicationController
  before_action :load_date_range

  before_action :authenticate_user!

  #check_authorization
  authorize_resource class: false

  def samples
    @title = t('view.reports.samples')
    @samples = if params[:interval]
                 Sample.between(@from_date, @to_date).to_report
               else
                 []
               end
  end

  def load_date_range
    @from_date, @to_date = *make_datetime_range(params[:interval])
  end
end
