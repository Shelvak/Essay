class ShiftsController < ApplicationController
  before_action :set_shift, only:  [:show, :edit, :update, :destroy]

  # GET /shifts
  def index
    @title = t('view.shifts.index_title')
    @shifts = Shift.all.page(params[:page])
  end

  # GET /shifts/1
  def show
    @title = t('view.shifts.show_title')
  end

  # GET /shifts/new
  def new
    @title = t('view.shifts.new_title')
    @shift = Shift.new
  end

  # GET /shifts/1/edit
  def edit
    @title = t('view.shifts.edit_title')
  end

  # POST /shifts
  def create
    @title = t('view.shifts.new_title')
    @shift = Shift.new(shift_params)

    respond_to do |format|
      if @shift.save
        format.html { redirect_to @shift, notice: t('view.shifts.correctly_created') }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PUT /shifts/1
  def update
    @title = t('view.shifts.edit_title')

    respond_to do |format|
      if @shift.update(shift_params)
        format.html { redirect_to @shift, notice: t('view.shifts.correctly_updated') }
      else
        format.html { render action: 'edit' }
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_shift_url(@shift), alert: t('view.shifts.stale_object_error')
  end

  # DELETE /shifts/1
  def destroy
    @shift.destroy
    redirect_to shifts_url, notice: t('view.shifts.correctly_destroyed')
  end

  private

    def set_shift
      @shift = Shift.find(params[:id])
    end

    def shift_params
      params.require(:shift).permit(:start_at, :finish_at, :user)
    end
end
