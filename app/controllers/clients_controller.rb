class ClientsController < ApplicationController
  # GET /clients
  # GET /clients.json
  def index
    @clients = Client.order(sort_by_field || :name).page(params[:page]).per_page(30)

    #params[:direction] ||= "asc"
    #params[:sort] ||= "due_date"

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clients }
    end
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    @client = Client.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @client }
    end
  end

  # GET /clients/new
  # GET /clients/new.json
  def new
    @client = Client.new

    respond_to do |format|
      format.html do
        render :layout => false if params[:no_layout]
      end
      format.json { render json: @client }
    end
  end

  # GET /clients/1/edit
  def edit
    @client = Client.find(params[:id])

    respond_to do |format|
      format.html do
        render :layout => false if params[:no_layout]
      end
      format.json { render json: @client }
    end
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(params[:client])

    respond_to do |format|
      if @client.save
        format.html { redirect_to @client, notice: 'Client was successfully created.' }
        format.js
      else
        format.html { render action: "new" }
        format.js
      end
    end
  end

  # PUT /clients/1
  # PUT /clients/1.json
  def update
    @client = Client.find(params[:id])

    respond_to do |format|
      if @client.update_attributes(params[:client])
        format.html { redirect_to @client, notice: 'Client was successfully updated.' }
        format.js
      else
        format.html { render action: "edit" }
        format.js
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client = Client.find(params[:id])
    @client.destroy

    respond_to do |format|
      format.html { redirect_to clients_url }
      format.json { head :no_content }
    end
  end

  def search
    params[:client] ||= {}
    query = "%#{params[:client][:query]}%"
    client = params[:client][:client]

    @clients = Client.where{name =~ query}.order(:name).page(params[:page]).per_page(20) if query.present?
    @clients = Client.where(:id => client).order(:name).page(params[:page]).per_page(20) if client.present?

    respond_to do |format|
      format.html { render :index}
      format.json { render json: @clients }
    end
  end

  def update_client
    @client = Client.find(params[:id])
    @client[params[:field]] = params[:new_value]
    @client.save
  end

  def accordion_details
    @client = Client.find(params[:id])
    render :partial => 'clients/accordion_details', :locals => {:client => @client }
  end
end
