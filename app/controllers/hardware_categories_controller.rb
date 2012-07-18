class HardwareCategoriesController < ApplicationController
  # GET /hardware_categories
  # GET /hardware_categories.json
  def index
    @hardware_categories = HardwareCategory.order(sort_by_field)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hardware_categories }
    end
  end

  # GET /hardware_categories/1
  # GET /hardware_categories/1.json
  def show
    @hardware_category = HardwareCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hardware_category }
    end
  end

  # GET /hardware_categories/new
  # GET /hardware_categories/new.json
  def new
    @hardware_category = HardwareCategory.new

    respond_to do |format|
      format.html do
        render :layout => false if params[:no_layout]
      end
      format.json { render json: @hardware_category }
    end
  end

  # GET /hardware_categories/1/edit
  def edit
    @hardware_category = HardwareCategory.find(params[:id])

    respond_to do |format|
      format.html do
        render :layout => false if params[:no_layout]
      end
      format.json { render json: @hardware_category }
    end
  end

  # POST /hardware_categories
  # POST /hardware_categories.json
  def create
    @hardware_category = HardwareCategory.new(params[:hardware_category])

    respond_to do |format|
      if @hardware_category.save
        format.html { redirect_to @hardware_category, notice: 'Hardware category was successfully created.' }
        format.js
      else
        format.html { render action: "new" }
        format.js
      end
    end
  end

  # PUT /hardware_categories/1
  # PUT /hardware_categories/1.json
  def update
    @hardware_category = HardwareCategory.find(params[:id])

    respond_to do |format|
      if @hardware_category.update_attributes(params[:hardware_category])
        format.html { redirect_to @hardware_category, notice: 'Hardware category was successfully updated.' }
        format.js
      else
        format.html { render action: "edit" }
        format.js
      end
    end
  end

  # DELETE /hardware_categories/1
  # DELETE /hardware_categories/1.json
  def destroy
    @hardware_category = HardwareCategory.find(params[:id])
    @hardware_category.destroy

    respond_to do |format|
      format.html { redirect_to hardware_categories_url }
      format.json { head :no_content }
    end
  end

  def update_hardware_category
    @hardware_category = HardwareCategory.find(params[:id])
    @hardware_category[params[:field]] = params[:new_value]
    @hardware_category.save
  end
end
