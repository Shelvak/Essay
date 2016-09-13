class ClientsController < ApplicationController
  before_action :set_client, only:  [:show, :edit, :update, :destroy]

  respond_to :html, :json

  # GET /clients
  def index
    @title = t('view.clients.index_title')
    @clients = Client.all
                     .search(q: params[:q], limit: request.xhr? && 5)
                     .page(params[:page])

    respond_with @clients
  end

  # GET /clients/1
  def show
    @title = t('view.clients.show_title')

    respond_with @client
  end

  # GET /clients/new
  def new
    @title = t('view.clients.new_title')
    @client = Client.new

    respond_with @client
  end

  # GET /clients/1/edit
  def edit
    @title = t('view.clients.edit_title')

    respond_with @client
  end

  # POST /clients
  def create
    @title = t('view.clients.new_title')
    @client = Client.new(client_params)
    @client.save

    respond_with @client
  end

  # PUT /clients/1
  def update
    @title = t('view.clients.edit_title')
    @client.update client_params

    respond_with @client
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_client_url(@client), alert: t('view.clients.stale_object_error')
  end

  # DELETE /clients/1
  def destroy
    @client.destroy
    respond_with @client
  end

  private

    def set_client
      @client = Client.find(params[:id])
    end

    def client_params
      params.require(:client).permit(:name)
    end
end
