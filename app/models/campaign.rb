require 'messagebird'

class Campaign < ApplicationRecord
  belongs_to :mailing_list
  belongs_to :user

  def send_campaign
    mailing_list = self.mailing_list
    contacts = mailing_list.contacts

    begin
      client = MessageBird::Client.new(ENV['MESSAGEBIRD_ACCESS_KEY'])
      contacts.each do |contact|
        contact.messagebird_ref = SecureRandom.base64.to_s
        opts = {
          reference: contact.messagebird_ref
        }
        unless self[:scheduled_at].nil?
          opts[:scheduledDatetime] = self[:scheduled_at].to_datetime.rfc3339
        end
        message = build_message_for(contact, self[:message])
        client.message_create("+33649886416", contact.phone_number, message, opts)
        contact.save!
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
