class ShippingMethodsController < ApplicationController
  # GET /shipping_methods
  # GET /shipping_methods.json
  def index
    @shipping_methods = ShippingMethod.order(:name).page(params[:page]).per_page(20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shipping_methods }
    end
  end

  # GET /shipping_methods/1
  # GET /shipping_methods/1.json
  def show
    @shipping_method = ShippingMethod.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shipping_method }
    end
  end

  # GET /shipping_methods/new
  # GET /shipping_methods/new.json
  def new
    @shipping_method = ShippingMethod.new

    respond_to do |format|
      format.html do
        render :layout => false if params[:no_layout]
      end
      format.json { render json: @shipping_method }
    end
  end

  # GET /shipping_methods/1/edit
  def edit
    @shipping_method = ShippingMethod.find(params[:id])

    respond_to do |format|
      format.html do
        render :layout => false if params[:no_layout]
      end
      format.json { render json: @shipping_method }
    end
  end

  # POST /shipping_methods
  # POST /shipping_methods.json
  def create
    @shipping_method = ShippingMethod.new(params[:shipping_method])

    respond_to do |format|
      if @shipping_method.save
        format.html { redirect_to @shipping_method, notice: 'Shipping method was successfully created.' }
        format.js
      else
        format.html { render action: "new" }
        format.js
      end
    end
  end



  # PUT /shipping_methods/1
  # PUT /shipping_methods/1.json
  def update
    @shipping_method = ShippingMethod.find(params[:id])

    respond_to do |format|
      if @shipping_method.update_attributes(params[:shipping_method])
        format.html { redirect_to @shipping_method, notice: 'Shipping method was successfully updated.' }
        format.js
      else
        format.html { render action: "edit" }
        format.js
      end
    end
  end

  # DELETE /shipping_methods/1
  # DELETE /shipping_methods/1.json
  def destroy
    @shipping_method = ShippingMethod.find(params[:id])
    @shipping_method.destroy

    respond_to do |format|
      format.html { redirect_to shipping_methods_url }
      format.json { head :no_content }
    end
  end

  def search
    params[:shipping_method] ||= {}
    query = "%#{params[:shipping_method][:query]}%"

    @shipping_methods = ShippingMethod.where{name =~ query}.order(:name).page(params[:page]).per_page(20) if query.present?

    respond_to do |format|
      format.html { render :index}
      format.json { render json: @shipping_methods }
    end
  end
end
