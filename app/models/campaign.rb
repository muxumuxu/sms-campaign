require 'messagebird'

class Campaign < ApplicationRecord
  belongs_to :mailing_list
  belongs_to :user

  def send
    mailing_list = self[:mailing_list]
    contacts = mailing_list.contacts

    begin
      client = MessageBird::Client.new(ENV['MESSAGEBIRD_ACCESS_KEY'])
      contacts.each do |contact|
        contact.messagebird_ref = SecureRandom.base64.to_s
        opts = {
          reference: contact.messagebird_ref
        }
        unless campaign[:scheduled_at].nil?
          opts[:scheduledDatetime] = campaign[:scheduled_at].to_datetime.rfc3339
        end
        message = build_message_for(contact, campaign.message)
        puts ""
        client.message_create("+33649886416", contact.phone_number, message, opts)
        contact.save!
      end
      campaign.sent_at = DateTime.now
      campaign.save!
    rescue Exception => ex
      raise ex.inspect
    end
  end
end
