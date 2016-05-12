class Contact < ActiveRecord::Base
  belongs_to :card

  validates :name, length: { minimum: 1 }
  validate :email_or_phone

  private

    def email_or_phone
      if phone.blank? && email.blank?
        errors.add(:base, "Specify atleast a phone number or an e-mail address")
      end
    end
end
