require 'singleton'

require 'mongo'
include Mongo

class CourseModel
  include Singleton

  def courses
    db = Connection.new.db('user-attendance')
    courses = db.collection('courses').find().to_a
    courses.sort_by{|course| course["date"].to_s}.reverse
  end

db = get_connection

end

def get_connection
  return @db_connection if @db_connection
  db = URI.parse(ENV['MONGOHQ_URL'])
  db_name = db.path.gsub(/^\//, '')
  @db_connection = Mongo::Connection.new(db.host, db.port).db(db_name)
  @db_connection.authenticate(db.user, db.password) unless (db.user.nil? || db.user.nil?)
  @db_connection
end

