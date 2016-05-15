class ContactsController < ApplicationController

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact.card, notice: 'Contact message was successfully sent' }
      else
        format.html { redirect_to @contact.card, flash: {:error => @contact.errors[:base][0] }}
      end
    end
  end

  private
    def contact_params
      params.require(:contact).permit(:name, :email, :phone, :message, :card_id)
    end
end
