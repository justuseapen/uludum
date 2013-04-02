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

describe SectionsController do

  before :each do
    @section = create :section
    @student = create :user
  end

  # This should return the minimal set of attributes required to create a valid
  # Section. As you add validations to Section, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { 
      course_id: @course.id,
      title: FactoryGirl.generate(:title)
    }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SectionsController. Be sure to keep this updated too.
  def valid_session
    {
      user_id: @course.teacher_id
    }
  end

  it "sets position on create" do
    @course = create :course
    course = @course
    get :create, {section: valid_attributes}, valid_session
    assigns(:section).course.should_not be(nil)
    assigns(:section).position.should_not be(nil)
    p = assigns(:section).position
    get :create, {section: valid_attributes}, valid_session
    assigns(:section).position.should be(p+1)
  end

  # describe "GET index" do
  #   it "assigns all sections as @sections" do
  #     section = Section.create! valid_attributes
  #     get :index, {}, valid_session
  #     assigns(:sections).should eq([section])
  #   end
  # end

  # describe "GET show" do
  #   it "assigns the requested section as @section" do
  #     section = Section.create! valid_attributes
  #     get :show, {:id => section.to_param}, valid_session
  #     assigns(:section).should eq(section)
  #   end
  # end

  # describe "GET new" do
  #   it "assigns a new section as @section" do
  #     get :new, {}, valid_session
  #     assigns(:section).should be_a_new(Section)
  #   end
  # end

  # describe "GET edit" do
  #   it "assigns the requested section as @section" do
  #     section = Section.create! valid_attributes
  #     get :edit, {:id => section.to_param}, valid_session
  #     assigns(:section).should eq(section)
  #   end
  # end

  # describe "POST create" do
  #   describe "with valid params" do
  #     it "creates a new Section" do
  #       expect {
  #         post :create, {:section => valid_attributes}, valid_session
  #       }.to change(Section, :count).by(1)
  #     end

  #     it "assigns a newly created section as @section" do
  #       post :create, {:section => valid_attributes}, valid_session
  #       assigns(:section).should be_a(Section)
  #       assigns(:section).should be_persisted
  #     end

  #     it "redirects to the created section" do
  #       post :create, {:section => valid_attributes}, valid_session
  #       response.should redirect_to(Section.last)
  #     end
  #   end

  #   describe "with invalid params" do
  #     it "assigns a newly created but unsaved section as @section" do
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Section.any_instance.stub(:save).and_return(false)
  #       post :create, {:section => {  }}, valid_session
  #       assigns(:section).should be_a_new(Section)
  #     end

  #     it "re-renders the 'new' template" do
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Section.any_instance.stub(:save).and_return(false)
  #       post :create, {:section => {  }}, valid_session
  #       response.should render_template("new")
  #     end
  #   end
  # end

  # describe "PUT update" do
  #   describe "with valid params" do
  #     it "updates the requested section" do
  #       section = Section.create! valid_attributes
  #       # Assuming there are no other sections in the database, this
  #       # specifies that the Section created on the previous line
  #       # receives the :update_attributes message with whatever params are
  #       # submitted in the request.
  #       Section.any_instance.should_receive(:update).with({ "these" => "params" })
  #       put :update, {:id => section.to_param, :section => { "these" => "params" }}, valid_session
  #     end

  #     it "assigns the requested section as @section" do
  #       section = Section.create! valid_attributes
  #       put :update, {:id => section.to_param, :section => valid_attributes}, valid_session
  #       assigns(:section).should eq(section)
  #     end

  #     it "redirects to the section" do
  #       section = Section.create! valid_attributes
  #       put :update, {:id => section.to_param, :section => valid_attributes}, valid_session
  #       response.should redirect_to(section)
  #     end
  #   end

  #   describe "with invalid params" do
  #     it "assigns the section as @section" do
  #       section = Section.create! valid_attributes
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Section.any_instance.stub(:save).and_return(false)
  #       put :update, {:id => section.to_param, :section => {  }}, valid_session
  #       assigns(:section).should eq(section)
  #     end

  #     it "re-renders the 'edit' template" do
  #       section = Section.create! valid_attributes
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Section.any_instance.stub(:save).and_return(false)
  #       put :update, {:id => section.to_param, :section => {  }}, valid_session
  #       response.should render_template("edit")
  #     end
  #   end
  # end

  # describe "DELETE destroy" do
  #   it "destroys the requested section" do
  #     section = Section.create! valid_attributes
  #     expect {
  #       delete :destroy, {:id => section.to_param}, valid_session
  #     }.to change(Section, :count).by(-1)
  #   end

  #   it "redirects to the sections list" do
  #     section = Section.create! valid_attributes
  #     delete :destroy, {:id => section.to_param}, valid_session
  #     response.should redirect_to(sections_url)
  #   end
  # end

end
