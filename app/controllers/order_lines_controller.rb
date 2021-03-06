class OrderLinesController < ApplicationController
  # GET /order_lines
  # GET /order_lines.json
  def index
    @order_lines = OrderLine.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @order_lines }
    end
  end

  # GET /order_lines/1
  # GET /order_lines/1.json
  def show
    @order_line = OrderLine.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order_line }
    end
  end

  # GET /order_lines/new
  # GET /order_lines/new.json
  def new
    @order_line = OrderLine.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order_line }
    end
  end

  # GET /order_lines/1/edit
  def edit
    @order_line = OrderLine.find(params[:id])
  end

  # POST /order_lines
  # POST /order_lines.json
  def create
    @order_line = OrderLine.new(params[:order_line])

    respond_to do |format|
      if @order_line.save
        format.html { redirect_to @order_line, notice: 'Order line was successfully created.' }
        format.json { render json: @order_line, status: :created, location: @order_line }
      else
        format.html { render action: "new" }
        format.json { render json: @order_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /order_lines/1
  # PUT /order_lines/1.json
  def update
    @order_line = OrderLine.find(params[:id])

    respond_to do |format|
      if @order_line.update_attributes(params[:order_line])
        format.html { redirect_to @order_line, notice: 'Order line was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_lines/1
  # DELETE /order_lines/1.json
  def destroy
    @order_line = OrderLine.find(params[:id])
    @order_line.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  def set_process_status
    @order_line_process_status = OrderLineProcessStatus.find(params[:order_line_process_status_id])
    @order_line_process_status.status = params[:status]
    if params[:status] == 'pending'
      @order_line_process_status.user_id = 0
    end
    @order_line_process_status.save
  end

  def update_order_line
    @order_line = OrderLine.find(params[:id])


    if params[:field] == "created_at" or params[:field] == "actual_ship_date" or params[:field] == "due_date" or params[:field] == "ship_date"
      @order_line[params[:field]] = Date.strptime(params[:new_value], "%m/%d/%y") + 1.hour
    else
      @order_line[params[:field]] = params[:new_value]
    end

    @order_line.save
  end

  def update_order_lines
    @changedField = params[:field]
    params[:ids] ||= []
    params[:ids].each do |id|
      @order_line = OrderLine.find(id)
      @order_line[params[:field]] = params[:value]
      if params[:field] == "status" && params[:value] == "shipped"
        @order_line.actual_ship_date = Time.now
      end
      @order_line.save
    end
  end

  def reset_order_line_status
    @order_line = OrderLine.find(params[:id])
    @order_line.status = "completed"
    @order_line.save
  end

  def accordion_details
    @users = User.users_only
    @order_line = OrderLine.find(params[:id])
    render :partial => 'order_lines/accordion_details', :locals => {:order_line => @order_line }
  end

  def assign_user
    @order_line_process_status = OrderLineProcessStatus.find(params[:order_line_process_status_id])
    @order_line_process_status.user_id = params[:user_id]
    current_status = params[:user_id].to_i == 0 ? "pending" : "assigned"
    @order_line_process_status.status = current_status
    @order_line_process_status.save
  end

  def update_order_line_process_status
    @order_line_process_status = OrderLineProcessStatus.find(params[:id])
    @order_line_process_status[params[:field]] = params[:new_value]
    @order_line_process_status.save
  end
end
