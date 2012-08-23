class PartProcessesController < ApplicationController
  # GET /part_processes
  # GET /part_processes.json
  def index
    @part_processes = PartProcess.order_by_priority
                                 .joins('LEFT OUTER JOIN required_processes on part_processes.id = required_processes.part_process_id')
                                 .joins('LEFT OUTER JOIN order_lines ON required_processes.part_id = order_lines.part_id')
                                 .group(:id)
                                 .order("order_lines.order_id desc")
                                 .order(:name)
    params[:direction] ||= "asc"
    params[:sort] ||= "due_date"

    @users = User.users_only

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @part_processes }
    end
  end

  # GET /part_processes/1
  # GET /part_processes/1.json
  def show
    @part_process = PartProcess.find(params[:id])

    params[:direction] ||= "asc"
    params[:sort] ||= "due_date"

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
    @part_process = PartProcess.find(params[:id])
    @part_process[params[:field]] = params[:new_value]
    @part_process.save
  end

  def set_order_line_priority
    params[:order_line_ids] ||= []
    @curr_id = params[:id]

    @part_process = PartProcess.find(params[:id])

    params[:order_line_ids].each_with_index do |id, i|
      status = @part_process.order_line_process_statuses.where(:order_line_id => id).first
      status.order_line_priority = i + 1
      status.save
    end
  end

  def reset_order_line_priority
    @curr_id = params[:id]

    @part_process = PartProcess.find(@curr_id)


    @part_process.order_line_process_statuses.each do |order_line_process_status|
      order_line_process_status.order_line_priority = 10000
      order_line_process_status.save
    end
  end

  def accordion_details
    @users = User.users_only
    @part_process = PartProcess.find(params[:id])
    render :partial => 'part_processes/accordion_details', :locals => {:part_process => @part_process }
  end
end
