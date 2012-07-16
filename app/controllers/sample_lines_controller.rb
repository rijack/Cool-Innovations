class SampleLinesController < ApplicationController
  # GET /sample_lines
  # GET /sample_lines.json
  def index
    @sample_lines = SampleLine.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sample_lines }
    end
  end

  # GET /sample_lines/1
  # GET /sample_lines/1.json
  def show
    @sample_line = SampleLine.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sample_line }
    end
  end

  # GET /sample_lines/new
  # GET /sample_lines/new.json
  def new
    @sample_line = SampleLine.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sample_line }
    end
  end

  # GET /sample_lines/1/edit
  def edit
    @sample_line = SampleLine.find(params[:id])
  end

  # POST /sample_lines
  # POST /sample_lines.json
  def create
    @sample_line = SampleLine.new(params[:sample_line])

    respond_to do |format|
      if @sample_line.save
        format.html { redirect_to @sample_line, notice: 'Sample line was successfully created.' }
        format.json { render json: @sample_line, status: :created, location: @sample_line }
      else
        format.html { render action: "new" }
        format.json { render json: @sample_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sample_lines/1
  # PUT /sample_lines/1.json
  def update
    @sample_line = SampleLine.find(params[:id])

    respond_to do |format|
      if @sample_line.update_attributes(params[:sample_line])
        format.html { redirect_to @sample_line, notice: 'Sample line was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sample_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sample_lines/1
  # DELETE /sample_lines/1.json
  def destroy
    @sample_line = SampleLine.find(params[:id])
    @sample_line.destroy

    respond_to do |format|
      format.html { redirect_to sample_lines_url }
      format.json { head :no_content }
    end
  end
end
