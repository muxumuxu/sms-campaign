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
