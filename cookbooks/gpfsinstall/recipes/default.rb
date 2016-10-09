#Take current user for ownership puposes 
USRTMP = %x["whoami"]
USR = USRTMP.delete("\n")
WORKDIRTMP = `echo $HOME`
WORKDIR = WORKDIRTMP.delete("\n")



#Create the  Directory structure for Vagrant 
directory "#{WORKDIR}/Desktop/work/gpfscluster" do
	owner "#{USR}"
	group "#{USR}"
	mode 755
	recursive true
	action :create
end

%w[ /rhel1 /rhel2].each do |fol|
	directory "#{WORKDIR}/Desktop/work/gpfscluster#{fol}" do
	owner "#{USR}"
	group "#{USR}"
	mode 755
	action :create
	end
end


## Populate the two vagrant VMS with the proper Vagrant files 
