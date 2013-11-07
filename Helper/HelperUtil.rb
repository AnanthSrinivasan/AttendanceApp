require 'net/ldap'

require 'mongo'
include Mongo

@ldap = nil

def insert_user empname, email, company, manager, course, date
  db = Connection.new.db("user-attendance")
  users = db.collection('users')
  new_user = { :empname => empname, :email => email, :company => company, :manager => manager, :course => course, :date => date.to_s}
  puts new_user 
  users.insert new_user
end

def insert_course courseid, coursedet, courselink, date
  db = Connection.new.db("user-attendance")
  courses = db.collection('courses')
  new_course = { :courseid => courseid, :coursedetails => coursedet, :courselink => courselink, :date => date.to_s}
  puts new_course 
  courses.insert new_course
end

def authenticate user, pass
  @ldap = Net::LDAP.new 
  @ldap.host = '10.254.58.54'
  @ldap.port = 389
  @ldap.auth user, pass
  @ldap.bind ? true : false
end

def ldap_attributes sam_name
  base = "dc=corp, dc=ebay, dc=com"
  attrs = ["mail", "displayName", "manager", "company"]
  filter = Net::LDAP::Filter.eq("sAMAccountName", sam_name)

  displayName = ""
  company = ""
  email = ""
  manager = ""

  @ldap.search(:base => base, :filter => filter, :attributes => attrs, :return_result => true) do |entry|
    displayName = entry.displayName[0]
    company = entry.company[0]
    email = entry.mail[0]
    manager = entry.manager[0].split(",")
    manager = (manager[0].split("=").last + manager[1]).to_s.gsub(/\\/, ',')
    puts manager
  end
  
  return displayName, company, email, manager  
end

def work_hours(t=Time.now.utc + 19800)
  early = Time.new(t.year, t.month, t.day, 9, 0, 0, t.utc_offset)
  late  = Time.new(t.year, t.month, t.day, 17, 0, 0, t.utc_offset)
  t.between?(early, late)
end

def printfn
  @users.find.to_a
end