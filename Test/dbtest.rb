require '../Helper/UserModel.rb'

# tesuser = UserModel.instance
# all_users = tesuser.users
# 
# all_users.each do |user|
  # puts user["id"].to_s + user["email"].to_s 
  # puts user["date"]  
# end


def check_duplicate mail, crse
  puts "mail = #{mail}"
  puts "course = #{crse}"
  db = Connection.new.db('user-attendance')
  users = db.collection('users').find( { email: mail, course: crse}).to_a
  (users.empty?) ? false : true
end

puts check_duplicate "alwaysananth@gmail.com", "java002"



