class ContactsController < ApplicationController

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact.card, notice: 'Contact was successfully created.' }
      else
        format.html { redirect_to root_path, notice: @contact.errors }
      end
    end
  end

  private
    def contact_params
      params.require(:contact).permit(:name, :email, :phone, :message, :card_id)
    end
end
