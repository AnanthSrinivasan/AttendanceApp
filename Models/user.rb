class User
  include MongoMapper::Document

  key :empname, String
  key :email, String
  key :company, String
  key :manager, String
  key :date, Date
  key :course, String
end
