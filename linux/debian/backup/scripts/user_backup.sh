#!/bin/bash
echo "what is the name of users home folder?\nExample:\t jack or jill usually will be their username\nDont! Enter /home/jack or /home/jill"
read user_dir
home_dir="/home/$user_dir"
echo "is this correct? $home_dir Answer Y for yes!"
read answer

#check if direcotry exists 
if [ $answer = "Y" ] && [ -d $home_dir ];
then 

        bakup_dir="$home_dir/$user_dir-backup-`date +"%Y-%m-%d%T"`"`

	
	if [ ! -d $bakup_dir]; then
		mkdir $bakup_dir
	else
		echo "directory exists!"
		echo "someone from the future created this directory\nWATCHOUT for time loops"
		exit 1


# need config files for this for now we will use lists 
# list of files to include in backup we will end up using separate variables to keep them separated for individual packaging
	home_files=(.bash_history .bashrc .ssh .profile)
	config_files=(/etc/apt/apt.conf.d/20auto-upgrades /etc/apt/apt.conf.d/50unattended-upgrades /etc/ssh/sshd_config /etc/pam.d/passwd) 
	
# we can probably copy files without loop 
	for file in $home_files; do 
		if [ -f $home_dir/$file ]; then 
			echo "chekcing if file exists if it does it will be backed up else you will be alerted"

			cp -r $home_dir/$file $bakup_dir/$file

		else
			echo "$file does not exist skipping"
			echo "$file did not exist `date +"%Y-%m-%d%T"`" >> error.log
		fi
	done

	for file in $config_files; do
		if [ -f $file ]; then 
			echo "$file exists so backing up"
			cp $file $bakup_dir/$file
		else
			echo " $file doesnt exist skipping"
			echo "$file doesnt exist `date +"%Y-%m-%d%T"`" >> "$user_dir-error.log"

	

else 
        echo "Quiting !!!" 
fi

ls -a $home_dir $bakup_dir

echo "did your files get transfered correctly? Y/n "
read answer

if [ $answer = "Y" ];
then 
        echo "Great then lets proceed\n would you like to move these backup files to an external drive?"
       read answer
       if [ $answer = "Y" ]; 
       then 
               lsblk 
               echo "Please enter the directory your external block storage is mounted to!"
               read mount_directory
               cp -r $bakup_dir $mount_directory
               ls -a $mount_directory
               echo "Your files should be all set!"
       else
               echo "okay then Quitting!!!"
               echo "have a nice day!"
       fi
else
        echo "Im sorry something went wrong!"
        echo "Quitting!!!"
fi

