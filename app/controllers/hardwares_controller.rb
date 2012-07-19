class HardwaresController < ApplicationController
  # GET /hardwares
  # GET /hardwares.json
  def index

    @hardwares = Hardware.joins('LEFT OUTER JOIN required_hardwares on hardwares.id = required_hardwares.hardware_id')
                         .joins('LEFT OUTER JOIN order_lines ON required_hardwares.part_id = order_lines.part_id')
                         .group(:id)
                         .includes(:hardware_category)
                         .order("hardware_categories.sort_priority")
                         .order("order_lines.order_id desc")
                         .page(params[:page]).per_page(20)
                         .order(:name)

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
    @order_lines = []

    respond_to do |format|
      format.html do
        render :layout => false if params[:no_layout]
      end
      format.json { render json: @hardware }
    end
  end

  # GET /hardwares/1/edit
  def edit
    params[:search] ||= {}
      
    @hardware = Hardware.find(params[:id])
    @order_lines = @hardware.order_lines.search(
      :shipped => params[:display] == "shipped",
      :client_id => params[:search][:client],
      :order_id => params[:search][:po_number],
      :search => params[:search].slice(*OrderLine.column_names).select{|k, v| v.present?},
      :sort => (sort_by_field || "created_at desc"),
      :page => params[:page],
      :per_page =>  20
    )

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
      if @hardware.update_attributes(params[:hardware])
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

    @hardwares = Hardware.where{name =~ query}.order(:name).page(params[:page]).per_page(20) if query.present?
    @hardwares = Hardware.where(:id => hardware).order(:name).page(params[:page]).per_page(20) if hardware.present?


    respond_to do |format|
      format.html { render :index}
      format.json { render json: @hardwares }
    end
  end

  def update_hardware
    @hardware = Hardware.find(params[:id])
    @hardware[params[:field]] = params[:new_value]
    @hardware.save
  end

end
