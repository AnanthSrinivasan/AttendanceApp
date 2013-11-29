Components: 
	
	Net/LDAP gem is used for acquiring the LDAP details for the given user. 

	Mongo DB is used to store the attendance and the course specified. 

Operation:

	Trainers/admin can generate the course link from /admin page
	
	Course link will be provided to the trainees/users 
	
	Users can sign-in through their CORP network user name and password to mark the attendance. 

Technical Flow:

	From post of /admin, courseid is redirected to get of /sign.
	
	Courseid is passed as value to uneditable courseid input field 
	
	Courseid will be inserted into db during post of /sign along with user details.  
	
Testing:

	GO to below links
		http://floating-brook-1171.herokuapp.com/sign
		http://atnapp-attendanceapp.rhcloud.com/sign
	
	you can go to /admin from the same root and add a new course and some details. 
	
	Press on Generate link, this will generate you a new link 
	
	You can mark the attendance against the given course id. 
	
	Instead of generating the link, you can also test out the attendance by clicking on 
	
	the existing links provided in the admin page. 
	
