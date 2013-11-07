class Course
  include MongoMapper::Document

  key :courseid, String
  key :coursedetails, String
  key :courselink, String
  key :date, Date
end
