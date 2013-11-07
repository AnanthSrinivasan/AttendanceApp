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

end
