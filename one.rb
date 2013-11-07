require 'sinatra'
require 'haml'

require './Helper/HelperUtil.rb'
require './Helper/UserModel.rb'
require './Helper/CourseModel.rb'

require 'will_paginate'
require 'will_paginate/array' 
require 'will_paginate-bootstrap'

@courseid = nil

get '/sign' do  
  @courseid = params["courseid"]
  haml :sign  
end  

post '/sign' do  
  @course = params["courseid"]
  name = params["empname"]
  name = "corp\\".to_s + name unless name.include? "corp"
  name = params["empname"].split("\\").last
  @auth = authenticate params["empname"], params["emppass"]
  @validtime = work_hours
  @dname, @company, @mail, @manager = ldap_attributes name
  # For Testing...
  # @auth = true
  # @validtime = true
  # @duplicate = true   
  @duplicate = UserModel.instance.duplicate @mail, params["courseid"]
  puts @duplicate
  haml :reg
end
  
get '/test' do
  erb :test
end

get '/attendance' do
  @all_users = UserModel.instance.users
  @all_users = @all_users.paginate(:page => params[:page], :per_page => 10)
  haml :atn
end

post '/attendance' do
  redirect "/course\?courseid=#{params["srchcourse"]}"
end

get '/course' do
  @courseid = params["courseid"] 
  @all_users = UserModel.instance.find_course @courseid
  @all_users = @all_users.paginate(:page => params[:page], :per_page => 10)
  haml :atn
end

get '/admin' do
  @all_courses = CourseModel.instance.courses
  @all_courses = @all_courses.paginate(:page => params[:page], :per_page => 10)
  haml :admin 
end

post '/admin' do
  @courseid = params["courseid"]
  @coursedet = params["coursedetails"] 
  @courselink = "http://localhost:4567/sign\?courseid=#{@courseid}&dt=#{(Time.now.utc + 19800).strftime("%Y%d%m")}"
  puts @courselink
  insert_course @courseid, @coursedet, @courselink, Date.today.to_s
  haml :link
end 

get '/references' do
  haml :reference
end
