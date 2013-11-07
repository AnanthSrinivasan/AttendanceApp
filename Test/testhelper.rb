require 'date'
require 'net/ldap'

def check_time(t=Time.now.utc + 19800)
  early = Time.new(t.year, t.month, t.day, 9, 0, 0, t.utc_offset)
  late  = Time.new(t.year, t.month, t.day, 17, 0, 0, t.utc_offset)
  t.between?(early, late)
end

between = check_time
puts between

puts "Date is #{(Time.now.utc + 19800).strftime("%Y%d%m")}"

#puts DateTime.now.strftime("%Y%d%m")

def ldap_attributes sam_name
  base = "dc=corp, dc=ebay, dc=com"
  attrs = ["mail", "displayName", "manager", "company"]
  filter = Net::LDAP::Filter.eq("sAMAccountName", sam_name)

  displayName = ""
  company = ""
  email = ""
  manager = ""
  user = "corp\\".to_s + sam_name
  puts user

  ldap = Net::LDAP.new :host => '10.254.58.54',
                       :port => 389,
                       :auth => { :method => :simple,
                                  :username => user,
                                  :password => "Dell123$" }

  ldap.search(:base => base, :filter => filter, :attributes => attrs, :return_result => true) do |entry|
    displayName = entry.displayName[0]
    company = entry.company[0]
    email = entry.mail[0]
    manager = entry.manager[0]
    # manager = entry.manager[0].scan(/(.*),OU=S(.*)/)
    # manager = manager[0][0].split("\\").first.to_s + manager[0][0].split("\\").last.to_s
  end
  
  return manager  
end

# manager = ldap_attributes "sijayaraman"
# man = manager.split(",")
 
#puts (man[0].split("=").last + man[1]).to_s.gsub(/\\/, ',')

link = "http://localhost:4567/sign?courseid=mac001&dt=20131710"

link = link.scan(/sign?.*/)[0]

puts link

name = "corp\amanoharan"

if name.include? "corp"
  puts name
else
  puts 'hello'
end



