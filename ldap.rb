require 'rubygems'
require 'net/ldap'
require 'highline/import'

 puts 'enter user'
 user = gets.chomp

 pass = ask("Password :") { |p| p.echo = "*" }
 
 
# 
# ldap = Net::LDAP.new
# ldap.host = '10.254.58.54'
# ldap.port = 389
# ldap.auth user, pass
# if ldap.bind
  # puts 'authentication succeeded'
# else
  # puts 'authentication failed'
# end


@ldap = nil

def authenticate user, pass
  
  @ldap = Net::LDAP.new :host => '10.254.58.54',
                       :port => 389,
                       :auth => { :method => :simple,
                                  :username => user,
                                  :password => pass }
  if @ldap.bind
    return true
  else
    return false
  end
  
end

def ldap_attributes
user = "sijayaraman"
base = "dc=corp, dc=ebay, dc=com"
attrs = ["mail", "displayName", "manager", "department", "company"]
filter = Net::LDAP::Filter.eq("sAMAccountName", user)
displayName = ""
  @ldap.search(:base => base, :filter => filter, :attributes => attrs, :return_result => true) do |entry|
    puts "DN: #{entry.dn}"
    displayName = entry.displayName[0]
    puts "department: #{entry.department[0]}"
    puts "company: #{entry.company[0]}"
    puts "email: #{entry.mail[0]}"
  #  puts "manager: #{entry.manager[0]}"
    m = entry.manager[0].scan(/(.*),OU=S(.*)/)
  
      puts m[0][0].split("\\").first.to_s + m[0][0].split("\\").last.to_s
    
  end
  
  return displayName unless displayName.nil? 

       
end

auth = authenticate user, pass

dname = ldap_attributes

puts dname
# puts title
# puts department
# puts mail

# 
#   
# p ldap.get_operation_result

# result = ldap.search(:base => base, :filter => filter, :attributes => attrs, :return_result => true)
# puts result[1]


#puts ldap.get_operation_result

# ldap = Net::LDAP.new(:host => '10.254.58.54', :port => 389)
# if ldap.bind(:method => :simple, :username => "corp\\amanoharan",
             # :password => pass)
  # puts 'authentication succeeded'
# else
  # puts 'authentication failed'
  # p ldap.get_operation_result
# end

# 
# unless ldap.bind
  # puts "Result: #{ldap.get_operation_result.code}"
  # puts "Message: #{ldap.get_operation_result.message}"
# end