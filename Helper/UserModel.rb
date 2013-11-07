require 'singleton'

require 'mongo'
include Mongo

class UserModel
  include Singleton

  def users
    db = Connection.new.db('user-attendance')
    users = db.collection('users').find().to_a
    users.sort_by{|user| user["date"].to_s}.reverse
  end

  def duplicate mail, course
    puts "mail  = #{mail}"
    puts "course = #{course}"
    db = Connection.new.db('user-attendance')
    users = db.collection('users').find( {email: mail, course: course} ).to_a
    (users.empty?) ? false : true
  end
  
  def find_course course
    puts "course = #{course}"
    db = Connection.new.db('user-attendance')
    users = db.collection('users').find({course: course}).to_a
    users.sort_by{|user| user["date"].to_s}.reverse  
  end

end
