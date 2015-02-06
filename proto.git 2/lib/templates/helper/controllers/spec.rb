require 'spec_helper'

describe <%= controller_class_name %> do
  let(:valid_attributes) { FactoryGirl.attributes_for :<%= table_name.singularize %> }

  let(:valid_session) { {} }

<% unless options[:singleton] %>
  describe "GET index" do
    it "assigns all <%= table_name.pluralize %> as @<%= table_name.pluralize %>" do
      <%= file_name %> = <%= model_name %>.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:<%= table_name %>)).to eq([<%= file_name %>])
    end
  end

<% end %>
  describe "GET show" do
    it "assigns the requested <%= ns_file_name %> as @<%= ns_file_name %>" do
      <%= file_name %> = double()
      <%= model_name %>.should_receive(:find).with('10').and_return(<%= file_name %>)
      get :show, {:id => 10}, valid_session
      expect(assigns(:<%= ns_file_name %>)).to eq(<%= file_name %>)
    end
  end

  describe "GET new" do
    it "assigns a new <%= ns_file_name %> as @<%= ns_file_name %>" do
      get :new, {}, valid_session
      expect(assigns(:<%= ns_file_name %>)).to be_a_new(<%= model_name %>)
    end
  end

  describe "GET edit" do
    it "assigns the requested <%= ns_file_name %> as @<%= ns_file_name %>" do
      <%= file_name %> = <%= model_name %>.create! valid_attributes
      get :edit, {:id => <%= file_name %>.to_param}, valid_session
      expect(assigns(:<%= ns_file_name %>)).to eq(<%= file_name %>)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new <%= model_name %>" do
        <%= file_name %> = double()
        <%= model_name %>.should_receive(:create).ordered.with(valid_attributes).and_return(<%= file_name %>)
        <%= file_name %>.should_receive(:save).ordered.and_return(true)
        post :create, {<%= ns_file_name %>: valid_attributes}, valid_session
      end

      it "assigns a newly created <%= ns_file_name %> as @<%= ns_file_name %>" do
        <%= file_name %> = FactoryGirl.build :<%= ns_file_name %>
        <%= file_name %>.stub(:save).and_return(true)
        <%= model_name %>.stub(:create).and_return(<%= file_name %>)
        post :create, {<%= ns_file_name %>: valid_attributes}, valid_session
        expect(assigns(:<%= ns_file_name %>)).to be_a(<%= model_name %>)
        expect(assigns(:<%= ns_file_name %>)).to be_persisted
      end

      it "redirects to the created <%= ns_file_name %>" do
        <%= file_name %> = double()
        <%= file_name %>.stub(:save).and_return(true)
        <%= model_name %>.stub(:create).and_return(<%= file_name %>)
        controller.stub(:<%= table_name.pluralize %>_path).with(<%= file_name %>).and_return('/sample/path')
        post :create, {:<%= ns_file_name %> => valid_attributes}, valid_session
        expect(response).to redirect_to('/sample/path')
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved <%= ns_file_name %> as @<%= ns_file_name %>" do
        allow_any_instance_of(<%= model_name %>).to receive(:save).and_return(false)
        post :create, {:<%= ns_file_name %> => <%= formatted_hash(example_invalid_attributes) %>}, valid_session
        expect(assigns(:<%= ns_file_name %>)).to be_a_new(<%= model_name %>)
      end

      it "re-renders the 'new' template" do
        allow_any_instance_of(<%= model_name %>).to receive(:save).and_return(false)
        post :create, {<%= ns_file_name %>: <%= formatted_hash(example_invalid_attributes) %>}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested <%= ns_file_name %>" do
        <%= file_name %> = <%= model_name %>.create! valid_attributes
        <% if ::Rails::VERSION::STRING >= '4' %>
        expect_any_instance_of(<%= model_name %>).to receive(:update).with(<%= formatted_hash(example_params_for_update) %>)
        <% else %>
        expect_any_instance_of(<%= model_name %>).to receive(:update_attributes).with(<%= formatted_hash(example_params_for_update) %>)
        <% end %>
        put :update, {:id => <%= file_name %>.to_param, :<%= ns_file_name %> => <%= formatted_hash(example_params_for_update) %>}, valid_session
      end

      it "assigns the requested <%= ns_file_name %> as @<%= ns_file_name %>" do
        <%= file_name %> = <%= model_name %>.create! valid_attributes
        put :update, {:id => <%= file_name %>.to_param, :<%= ns_file_name %> => valid_attributes}, valid_session
        expect(assigns(:<%= ns_file_name %>)).to eq(<%= file_name %>)
      end

      it "redirects to the <%= ns_file_name %>" do
        <%= file_name %> = <%= model_name %>.create! valid_attributes
        put :update, {:id => <%= file_name %>.to_param, :<%= ns_file_name %> => valid_attributes}, valid_session
        expect(response).to redirect_to(<%= file_name %>)
      end
    end

    describe "with invalid params" do
      it "assigns the <%= ns_file_name %> as @<%= ns_file_name %>" do
        <%= file_name %> = <%= model_name %>.create! valid_attributes
        allow_any_instance_of(<%= model_name %>).to receive(:save).and_return(false)
        put :update, {:id => <%= file_name %>.to_param, :<%= ns_file_name %> => <%= formatted_hash(example_invalid_attributes) %>}, valid_session
        expect(assigns(:<%= ns_file_name %>)).to eq(<%= file_name %>)
      end

      it "re-renders the 'edit' template" do
        <%= file_name %> = <%= model_name %>.create! valid_attributes
        allow_any_instance_of(<%= model_name %>).to receive(:save).and_return(false)
        put :update, {:id => <%= file_name %>.to_param, :<%= ns_file_name %> => <%= formatted_hash(example_invalid_attributes) %>}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested <%= ns_file_name %>" do
      <%= file_name %> = double()
      <%= file_name %>.should_receive(:find).ordered.with('10').and_return(<%= file_name %>)
      <%= file_name %>.should_receive(:destroy).ordered.and_return(true)
      delete :destroy, {id: 10}, valid_session
    end

    it "redirects to the <%= table_name %> list" do
      <%= file_name %> = double( destroy: true )
      <%= file_name %>.stub(:find).and_return(<%= file_name %>)
      delete :destroy, {id: 10}, valid_session
      expect(response).to redirect_to(<%= index_helper %>_path)
    end
  end

end
