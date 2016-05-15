require 'rails_helper'

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

RSpec.describe ContactsController, type: :controller do
  let!(:card) { FactoryGirl.create :card }

  let(:valid_attributes) {{
    name: 'Testname',
    phone: '050-123456789',
    email: 'test@email.com',
    message: 'Testmessage',
    card_id: card.id
  }}

  let(:invalid_attributes) {{
    name: '',
    phone: '',
    email: '',
    message: '',
    card_id: card.id
  }}

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Contact" do
        expect {
          post :create, {:contact => valid_attributes}
        }.to change(Contact, :count).by(1)
      end

      it "redirects to the given card" do
        post :create, {:contact => valid_attributes}
        expect(response).to redirect_to(card)
      end
    end

    context "with invalid params" do
      it "doesn't create a new Contact" do
        expect {
          post :create, {:contact => invalid_attributes}
        }.to change(Contact, :count).by(0)
      end

      it "redirects to the given card" do
        post :create, {:contact => invalid_attributes}
        expect(response).to redirect_to(card)
      end
    end
  end
end
