class Campaign < ApplicationRecord
  belongs_to :mailing_list
  belongs_to :user

  def send_campaign
    mailing_list = self.mailing_list
    contacts = mailing_list.contacts

    begin
      twilio_number = ENV['TWILIO_NUMBER']
      client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
      contacts.each do |contact|
        message = build_message_for(contact, self[:message])
        message = client.account.messages.create(
          :from => twilio_number,
          :to => contact.phone_number,
          :body => message
        )
      end
      self[:sent_at] = DateTime.now
      self.save!
    rescue Exception => ex
      ex.errors.each do |error|
        puts "  code        : #{error.code}"
        puts "  description : #{error.description}"
        puts "  parameter   : #{error.parameter}"
        puts
      end
      raise ex.inspect
    end
  end

  private

  def build_message_for(contact, message)
    message
      .gsub(/\{Prénom\}/, contact.first_name)
      .gsub(/\{Nom\}/, contact.last_name)
  end
end
