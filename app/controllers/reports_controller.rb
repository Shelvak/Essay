class ReportsController < ApplicationController
  before_action :load_date_range

  before_action :authenticate_user!

  #check_authorization
  authorize_resource class: false

  def samples
    @title = t('view.reports.samples.title')

    if params[:interval]
      @samples = Sample.between(@from_date, @to_date).to_report
      @samples_by_client = Sample.to_report_by_client(@from_date, @to_date)
      @samples_by_user = Sample.to_report_by_user(@from_date, @to_date)
    end
  end

  def load_date_range
    @from_date, @to_date = *make_datetime_range(params[:interval])
  end
end
