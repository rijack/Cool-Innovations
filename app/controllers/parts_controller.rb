class PartsController < ApplicationController
  # GET /parts
  # GET /parts.json
  def index
    @parts = Part.order(:part_number).page(params[:page]).per_page(20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @parts }
    end
  end

  # GET /parts/1
  # GET /parts/1.json
  def show
    @part = Part.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @part }
    end
  end

  # GET /parts/new
  # GET /parts/new.json
  def new
    @part = Part.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @part }
    end
  end

  # GET /parts/1/edit
  def edit
    @part = Part.find(params[:id])
  end

  # POST /parts
  # POST /parts.json
  def create
    @part = Part.new(params[:part])

    respond_to do |format|
      if @part.save
        format.html { redirect_to @part, notice: 'Part was successfully created.' }
        format.json { render json: @part, status: :created, location: @part }
      else
        format.html { render action: "new" }
        format.json { render json: @part.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /parts/1
  # PUT /parts/1.json
  def update
    @part = Part.find(params[:id])

    respond_to do |format|
      if @part.update_attributes(params[:part])
        format.html { redirect_to @part, notice: 'Part was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @part.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parts/1
  # DELETE /parts/1.json
  def destroy
    @part = Part.find(params[:id])
    @part.destroy

    respond_to do |format|
      format.html { redirect_to parts_url }
      format.json { head :no_content }
    end
  end

  def update_part
    @part = Part.find(params[:id])
    @part[params[:field]] = params[:new_value]
    @part.save
  end

  def search
    params[:client] ||= {}
    query = "%#{params[:part][:query]}%"
    part = params[:part][:part]

    @parts = Part.where{part_number =~ query}.order(:part_number).page(params[:page]).per_page(20) if query.present?
    @parts = Part.where(:id => part).order(:part_number).page(params[:page]).per_page(20) if part.present?


    respond_to do |format|
      format.html { render :index}
      format.json { render json: @parts }
    end
  end
end
