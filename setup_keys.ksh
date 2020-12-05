#!/bin/ksh

###########################################################
#
#    setup_sftp.ksh
#
#    Korn Shell program to automate the distribution of ssh keys
#
#  Author          Date          Description
#############################################################
#  Wes Jones       05-Jan-2008   Initial version developed
#                                modeled after script "setup_ssh.ksh"
#  Anthony Hamilton 02-Nov-2009   added some flexibility for differant ssh version
#					    fixed empty variable	
#					    added some cleanup	
#					    also added checking for local keyfiles and creation if you don't have them
#############################################################

function help
 {
  print -u2
  print -u2 " Usage:"
  print -u2
  print -u2 "  setup_ssh.ksh -u <remote username> -r <remote hostname> -p <password> [-h]"
  print -u2
  print -u2 " Required:"
  print -u2 "   -u : Remote Username"
  print -u2 "   -r : Remote host name"
  print -u2 "   -p : Remote host password"
  print -u2 " Optional:"
  print -u2 "   -h : Displays Help"
  print -u2
  exit 1
 }


while getopts h:r:p:u: c
do
     case $c in
     h)   help;;
     u)   MY_REMOTE_USERNAME=$OPTARG;;
     r)   MY_REMOTE_HOSTNAME=$OPTARG;;
     p)   MY_REMOTE_PASSWORD=$OPTARG;;
     esac
done
shift `expr $OPTIND - 1`

if [[ -z $MY_REMOTE_HOSTNAME ]];then
	help
fi

if [[ -z $MY_REMOTE_USERNAME ]];then
        help
fi

if [[ -z $MY_REMOTE_PASSWORD ]];then
	help
fi

MY_USERNAME=$USER
MY_LOCAL_HOSTNAME="`hostname`"
#MY_REMOTE_PASSWORD="$mypass"

#=====================================================================
### create keyfiles is you don't have them 
#=====================================================================

if [ ! -r ${HOME}/.ssh/id_rsa.pub ]; then
  ssh-keygen -b 2048 -t rsa -f ${HOME}/.ssh/id_rsa.pub -N ""
fi

if [ ! -r ${HOME}/.ssh2/$MY_USERNAME@$MY_LOCAL_HOSTNAME.pub ]; then
  ssh-keygen -e -f ${HOME}/.ssh/id_rsa.pub > ${HOME}/.ssh2/$MY_USERNAME@$MY_LOCAL_HOSTNAME.pub
fi

#=====================================================================
### PUT PUBLIC KEYFILE . . . GET COPY OF authorization FILE FOR UPDATE.
#=====================================================================
expect << EOFF
set timeout 5
spawn  sftp $MY_REMOTE_USERNAME@$MY_REMOTE_HOSTNAME
expect {
         imeout                             { puts stderr "Timeout occured for $MY_REMOTE_HOSTNAME\r"
						return }
         ailed                              { puts stderr "Connect failed for $MY_REMOTE_HOSTNAME\r"
						return }
         #"ogin:"                           { send "$MY_REMOTE_PASSWORD\r" }
         #"name:"                           { send "$MY_REMOTE_PASSWORD\r" }
         "interactive:"                          { send "$MY_REMOTE_PASSWORD\r" }
         "ssword:"                          { send "$MY_REMOTE_PASSWORD\r" }
	 #"Are you sure"			    { send "yes\r" }
        }
#   send  "$MY_REMOTE_PASSWORD\r"
#OPEN ssh part
expect  "sftp>"
   send  "mkdir .ssh\r"
expect  "sftp>"
   send  "cd .ssh\r"
expect  "sftp>"
   send  "touch authorized_keys\r"
expect  "sftp>"
   send  "put ${HOME}/.ssh/id_rsa.pub $MY_USERNAME@$MY_LOCAL_HOSTNAME_openssh.pub\r"
expect  "sftp>"   
   send  "chmod 644 authorized_keys\r"
expect  "sftp>"
   send  "get authorized_keys $MY_REMOTE_HOSTNAME.authorized_keys\r"
expect "sftp>"
   send  "cd ../.ssh2\r"
#f-secure stuff
expect  "sftp>"
   send  "mkdir .ssh2\r"
expect  "sftp>"
   send  "cd .ssh2\r"
expect  "sftp>"
   send  "put ${HOME}/.ssh2/$MY_USERNAME@$MY_LOCAL_HOSTNAME.pub\r"
expect  "sftp>"
   send  "get authorization $MY_REMOTE_HOSTNAME.authorization\r"
expect  "sftp>"
   send  "exit\r"
EOFF


#===========================================================
### WERE WE SUCCESSFUL IN SENDING THE PUB-KEY TO REMOTE HOST ?
#===========================================================
if [ $? -eq 0 ];then
        echo "Public key file $MY_USERNAME@$MY_LOCAL_HOSTNAME.pub pushed to remote machine $MY_REMOTE_HOSTNAME"
fi

#===========================================================
### ADD LOCAL PUB-KEY NAME TO authorization FILE FOR REMOTE
#===========================================================
##  TOUCH/CREATE REMOTE's authorization FILE  (IN CASE THERE WAS NONE TO RETRIEVED) . . .
touch $MY_REMOTE_HOSTNAME.authorization
touch $MY_REMOTE_HOSTNAME.authorized_keys
##  . . . THEN ADD A NEW ENTRY
echo "key $MY_USERNAME@$MY_LOCAL_HOSTNAME.pub" >> $MY_REMOTE_HOSTNAME.authorization
cat ~/.ssh/id_rsa.pub >> $MY_REMOTE_HOSTNAME.authorized_keys
## clear duplicates
cat $MY_REMOTE_HOSTNAME.authorization | awk '! a[$0]++' >> .temp
mv .temp $MY_REMOTE_HOSTNAME.authorization
cat $MY_REMOTE_HOSTNAME.authorized_keys | awk '! a[$0]++' >> .temp
mv .temp $MY_REMOTE_HOSTNAME.authorized_keys
cp $MY_REMOTE_HOSTNAME.authorized_keys $MY_REMOTE_HOSTNAME.authorized_keys2

#===========================================================
### SEND UPDATED authorization FILE BACK TO REMOTE HOST
#===========================================================
expect << EOFF
spawn  sftp $MY_REMOTE_USERNAME@$MY_REMOTE_HOSTNAME
expect  "sword:"
   send  "$MY_REMOTE_PASSWORD\r"
#OPENSSH
expect "sftp>"
   send  "cd .ssh\r"
expect "sftp>"
   send  "put $MY_REMOTE_HOSTNAME.authorized_keys\r"
expect "sftp>"
   send  "put $MY_REMOTE_HOSTNAME.authorized_keys2\r"
expect "sftp>"
   send  "rename authorized_keys authorized_keys.bak\r"
expect "sftp>"
   send  "rename authorized_keys2 authorized_keys2.bak\r"
expect "sftp>"
   send  "rename $MY_REMOTE_HOSTNAME.authorized_keys authorized_keys\r"
expect "sftp>"
   send  "rename $MY_REMOTE_HOSTNAME.authorized_keys2 authorized_keys2\r"
expect "sftp>"
   send  "cd ../.ssh2\r"
#FSECURE
expect "sftp>"
   send  "cd .ssh2\r"
expect "sftp>"
   send  "put $MY_REMOTE_HOSTNAME.authorization\r"
expect "sftp>"
   send  "rename authorization authorization.bak\r"
expect "sftp>"
   send  "rename $MY_REMOTE_HOSTNAME.authorization authorization\r"
expect "sftp>"
   send  "exit\r"
EOFF

#==================
### DECLARE SUCCESS
#==================
echo " "
echo "Key setup completed."
echo " "


#==================
### Cleanup
#==================

mv $MY_REMOTE_HOSTNAME.authorization ${HOME}/.ssh2/
mv $MY_REMOTE_HOSTNAME.authorized_keys ${HOME}/.ssh/
mv $MY_REMOTE_HOSTNAME.authorized_keys2 ${HOME}/.ssh/
