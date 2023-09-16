#!/bin/bash
echo "Enter the home directory of user"
read home_dir
echo $home_dir
echo "is this correct? Answer Y for yes!"
read answer

if [ $answer = "Y" ];
then 
        bakup_dir=$home_dir/bak
        mkdir $bakup_dir

        cp -r $home_dir/.bash_history $home_dir/.bashrc $home_dir/.ssh $home_dir/.profile $bakup_dir

#	configs 
        cp  /etc/apt/apt.conf.d/20auto-upgrades /etc/apt/apt.conf.d/50unattended-upgrades /etc/ssh/sshd_config /etc/pam.d/passwd $bakup_dir

else 
        echo "Quiting !!!" 
fi

ls -a $home_dir $bakup_dir
echo "Any other files or directories you would like to backup ?"
read answer

if [ $answer = "Y" ];
then 
        echo " enter the paths of the other files and directories:"
        read other_directories

        cd $home_dir
        cp -r $other_directories $bakup_dir
        ls -a $home_dir $bakup_dir

else
        echo "something went awry!"
fi

echo "did your files get transfered correctly?"
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

