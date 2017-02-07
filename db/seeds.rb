# Admin access #

admin = User.new({
  email: "admin@muxumuxu.com",
  password: "secret",
  first_name: "Admin"
})
admin.save

# Mailing lists #

gironde = MailingList.new(
  name: "Gironde"
)
gironde.save

bretagne = MailingList.new(
  name: "Bretagne"
)
bretagne.save

picardie = MailingList.new(
  name: "Picardie"
)
picardie.save

# Contacts #

audrey = Contact.new(
  first_name: "Audrey",
  last_name: "Présidente",
  phone_number: "0987654321",
  zip_code: "33000"
)
audrey.save

luc = Contact.new(
  first_name: "Luc",
  last_name: "Chaissac",
  phone_number: "0987654322",
  zip_code: "33000"
)
luc.save

# Contacts Mailing Lists #

audrey_gironde = ContactsMailingList.new(
  contact_id: 1,
  mailing_list_id: 1
)
audrey_gironde.save

luc_gironde = ContactsMailingList.new(
  contact_id: 2,
  mailing_list_id: 1
)
luc_gironde.save
