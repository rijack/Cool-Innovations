class PartProcessesController < ApplicationController
  # GET /part_processes
  # GET /part_processes.json
  def index
    @part_processes = PartProcess.order(:name).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @part_processes }
    end
  end

  # GET /part_processes/1
  # GET /part_processes/1.json
  def show
    @part_process = PartProcess.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @part_process }
    end
  end

  # GET /part_processes/new
  # GET /part_processes/new.json
  def new
    @part_process = PartProcess.new

    respond_to do |format|
      format.html do
        render :layout => false if params[:no_layout]
      end
      format.json { render json: @part_process }
    end
  end

  # GET /part_processes/1/edit
  def edit
    @part_process = PartProcess.find(params[:id])

    respond_to do |format|
      format.html do
        render :layout => false if params[:no_layout]
      end
      format.json { render json: @part_process }
    end
  end

  # POST /part_processes
  # POST /part_processes.json
  def create
    @part_process = PartProcess.new(params[:part_process])

    respond_to do |format|
      if @part_process.save
        format.html { redirect_to @part_process, notice: 'Part process was successfully created.' }
        format.js
      else
        format.html { render action: "new" }
        format.js
      end
    end
  end

  # PUT /part_processes/1
  # PUT /part_processes/1.json
  def update
    @part_process = PartProcess.find(params[:id])

    respond_to do |format|
      if @part_process.update_attributes(params[:part_process])
        format.html { redirect_to @part_process, notice: 'Part process was successfully updated.' }
        format.js
      else
        format.html { render action: "edit" }
        format.js
      end
    end
  end

  # DELETE /part_processes/1
  # DELETE /part_processes/1.json
  def destroy
    @part_process = PartProcess.find(params[:id])
    @part_process.destroy

    respond_to do |format|
      format.html { redirect_to part_processes_url }
      format.json { head :no_content }
    end
  end

  def update_part_process
    @client = Client.find(params[:id])
    @client[params[:field]] = params[:new_value]
    @client.save
  end
end
