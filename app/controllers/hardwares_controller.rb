class HardwaresController < ApplicationController
  # GET /hardwares
  # GET /hardwares.json
  def index
    @hardwares = Hardware.order(:name).page(params[:page]).per_page(20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hardwares }
    end
  end

  # GET /hardwares/1
  # GET /hardwares/1.json
  def show
    @hardware = Hardware.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hardware }
    end
  end

  # GET /hardwares/new
  # GET /hardwares/new.json
  def new
    @hardware = Hardware.new

    respond_to do |format|
      format.html do
        render :layout => false if params[:no_layout]
      end
      format.json { render json: @hardware }
    end
  end

  # GET /hardwares/1/edit
  def edit
    @hardware = Hardware.find(params[:id])

    respond_to do |format|
      format.html do
        render :layout => false if params[:no_layout]
      end
      format.json { render json: @hardware }
    end
  end

  # POST /hardwares
  # POST /hardwares.json
  def create
    @hardware = Hardware.new(params[:hardware])

    respond_to do |format|
      if @hardware.save
        format.html { redirect_to @hardware, notice: 'Hardware was successfully created.' }
        format.js
      else
        format.html { render action: "new" }
        format.js
      end
    end
  end

  # PUT /hardwares/1
  # PUT /hardwares/1.json
  def update
    @hardware = Hardware.find(params[:id])

    respond_to do |format|
      if @hardware.update_attributes(params[:@hardware])
        format.html { redirect_to @hardware, notice: 'Hardware was successfully updated.' }
        format.js
      else
        format.html { render action: "edit" }
        format.js
      end
    end
  end

  # DELETE /hardwares/1
  # DELETE /hardwares/1.json
  def destroy
    @hardware = Hardware.find(params[:id])
    @hardware.destroy

    respond_to do |format|
      format.html { redirect_to hardwares_url }
      format.json { head :no_content }
    end
  end

  def search
    params[:hardware] ||= {}
    query = "%#{params[:hardware][:query]}%"
    hardware = params[:hardware][:hardware]

    @hardwares = Hardware.where("name like ?",query).order(:name).page(params[:page]).per_page(20) if query.present?
    @hardwares = Hardware.where("id like ?",client).order(:name).page(params[:page]).per_page(20) if hardware.present?


    respond_to do |format|
      format.html { render :index}
      format.json { render json: @hardwares }
    end
  end

end
