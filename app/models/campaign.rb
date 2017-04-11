# Campaign model
class Campaign < ApplicationRecord
  acts_as_paranoid

  belongs_to :mailing_list
  belongs_to :user

  scope :by_user, lambda { |user|
    where(sent_at: nil, scheduled_at: nil, user_id: user.id)
    order(created_at: :desc)
    where(sent_at: nil, user_id: user.id)
    where('scheduled_at is not null')
    order(scheduled_at: :desc)
    where(user_id: user.id)
    where('sent_at is not null ')
    order(sent_at: :desc)
  }

  def self.clean
    Campaign.where('name is null').destroy_all
  end

  def send_campaign
    mailing_list.contacts.each do |contact|
      message = build_message_for(contact, self[:message])
      send_sms_to(contact, message)
    end
    self[:sent_at] = DateTime.now
    save!
  end

  private

  @twilio_details = {
    number: ENV['TWILIO_NUMBER'],
    account_id: ENV['TWILIO_ACCOUNT_SID'],
    token: ENV['TWILIO_AUTH_TOKEN']
  }.freeze

  def send_sms_to(contact, message)
    account_id = ENV['TWILIO_ACCOUNT_SID']
    token = ENV['TWILIO_AUTH_TOKEN']
    number = ENV['TWILIO_NUMBER']
    client = Twilio::REST::Client.new(account_id, token).account.messages
    client.create(from: number, to: contact.phone_number, body: message)
  rescue StandardError => e
    Rollbar.error(e)
  end

  def twilio_details
    { number: ENV['TWILIO_NUMBER'],
      account_id: ENV['TWILIO_ACCOUNT_SID'],
      token: ENV['TWILIO_AUTH_TOKEN'] }
  end

  def build_message_for(contact, message)
    first_name = I18n.t('campaign.message.anchor_first_name')
    name = I18n.t('campaign.message.anchor_surname')
    message
      .gsub(/#{first_name}/, contact.first_name)
      .gsub(/#{name}/, contact.last_name)
  end
end
