require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe HardwareCategoriesController do

  # This should return the minimal set of attributes required to create a valid
  # HardwareCategory. As you add validations to HardwareCategory, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # HardwareCategoriesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all hardware_categories as @hardware_categories" do
      hardware_category = HardwareCategory.create! valid_attributes
      get :index, {}, valid_session
      assigns(:hardware_categories).should eq([hardware_category])
    end
  end

  describe "GET show" do
    it "assigns the requested hardware_category as @hardware_category" do
      hardware_category = HardwareCategory.create! valid_attributes
      get :show, {:id => hardware_category.to_param}, valid_session
      assigns(:hardware_category).should eq(hardware_category)
    end
  end

  describe "GET new" do
    it "assigns a new hardware_category as @hardware_category" do
      get :new, {}, valid_session
      assigns(:hardware_category).should be_a_new(HardwareCategory)
    end
  end

  describe "GET edit" do
    it "assigns the requested hardware_category as @hardware_category" do
      hardware_category = HardwareCategory.create! valid_attributes
      get :edit, {:id => hardware_category.to_param}, valid_session
      assigns(:hardware_category).should eq(hardware_category)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new HardwareCategory" do
        expect {
          post :create, {:hardware_category => valid_attributes}, valid_session
        }.to change(HardwareCategory, :count).by(1)
      end

      it "assigns a newly created hardware_category as @hardware_category" do
        post :create, {:hardware_category => valid_attributes}, valid_session
        assigns(:hardware_category).should be_a(HardwareCategory)
        assigns(:hardware_category).should be_persisted
      end

      it "redirects to the created hardware_category" do
        post :create, {:hardware_category => valid_attributes}, valid_session
        response.should redirect_to(HardwareCategory.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved hardware_category as @hardware_category" do
        # Trigger the behavior that occurs when invalid params are submitted
        HardwareCategory.any_instance.stub(:save).and_return(false)
        post :create, {:hardware_category => {}}, valid_session
        assigns(:hardware_category).should be_a_new(HardwareCategory)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        HardwareCategory.any_instance.stub(:save).and_return(false)
        post :create, {:hardware_category => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested hardware_category" do
        hardware_category = HardwareCategory.create! valid_attributes
        # Assuming there are no other hardware_categories in the database, this
        # specifies that the HardwareCategory created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        HardwareCategory.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => hardware_category.to_param, :hardware_category => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested hardware_category as @hardware_category" do
        hardware_category = HardwareCategory.create! valid_attributes
        put :update, {:id => hardware_category.to_param, :hardware_category => valid_attributes}, valid_session
        assigns(:hardware_category).should eq(hardware_category)
      end

      it "redirects to the hardware_category" do
        hardware_category = HardwareCategory.create! valid_attributes
        put :update, {:id => hardware_category.to_param, :hardware_category => valid_attributes}, valid_session
        response.should redirect_to(hardware_category)
      end
    end

    describe "with invalid params" do
      it "assigns the hardware_category as @hardware_category" do
        hardware_category = HardwareCategory.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        HardwareCategory.any_instance.stub(:save).and_return(false)
        put :update, {:id => hardware_category.to_param, :hardware_category => {}}, valid_session
        assigns(:hardware_category).should eq(hardware_category)
      end

      it "re-renders the 'edit' template" do
        hardware_category = HardwareCategory.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        HardwareCategory.any_instance.stub(:save).and_return(false)
        put :update, {:id => hardware_category.to_param, :hardware_category => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested hardware_category" do
      hardware_category = HardwareCategory.create! valid_attributes
      expect {
        delete :destroy, {:id => hardware_category.to_param}, valid_session
      }.to change(HardwareCategory, :count).by(-1)
    end

    it "redirects to the hardware_categories list" do
      hardware_category = HardwareCategory.create! valid_attributes
      delete :destroy, {:id => hardware_category.to_param}, valid_session
      response.should redirect_to(hardware_categories_url)
    end
  end

end
