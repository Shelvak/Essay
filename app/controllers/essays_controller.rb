class EssaysController < ApplicationController
  before_action :set_essay, only:  [:show, :edit, :update, :destroy]
  before_action :set_user

  # GET /essays
  def index
    @title = t('view.essays.index_title')
    @essays = essays_scope.all.page(params[:page])
  end

  # GET /essays/1
  def show
    @title = t('view.essays.show_title')
    @samples = @essay.samples
  end

  # GET /essays/new
  def new
    @title = t('view.essays.new_title')
    @essay = @user.essays.new
  end

  # GET /essays/1/edit
  def edit
    @title = t('view.essays.edit_title')
  end

  # POST /essays
  def create
    @title = t('view.essays.new_title')
    @essay = @user.essays.new(essay_params)

    respond_to do |format|
      if @essay.save
        format.html { redirect_to @essay, notice: t('view.essays.correctly_created') }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PUT /essays/1
  def update
    @title = t('view.essays.edit_title')

    respond_to do |format|
      if @essay.update(essay_params)
        format.html { redirect_to @essay, notice: t('view.essays.correctly_updated') }
      else
        format.html { render action: 'edit' }
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_essay_url(@essay), alert: t('view.essays.stale_object_error')
  end

  # DELETE /essays/1
  def destroy
    @essay.destroy
    redirect_to essays_url, notice: t('view.essays.correctly_destroyed')
  end

  private

    def set_essay
      @essay = essays_scope.find(params[:id])
    end

    def set_user
      @user = current_user
    end

    def essays_scope
      current_user.admin? ? Essay.all : current_user.essays
    end

    def essay_params
      params.require(:essay).permit(:title, samples_attributes: [:element, :quantity])
    end
end
