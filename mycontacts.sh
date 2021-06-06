#!/bin/bash

## here we add our data in the file as a database
contact_list=contacts.txt

## confirmation the courses simple yes no options 
confirm(){
until [[ $confirmed =~ [YN] ]] ; do
read -p "Are you sure? Y/N: " confirmed

if [[ $confirmed = "Y" ]] 
then
   echo ""
   echo "---Contact Deleted---"
elif  [[ $confirmed = "N" ]]
	then
	return 1; main_menu
else
  echo "Must choose either Y/N - press crtl+c to exit"
fi

done
confirmed=											## when done keep checking the options 
}
keep_order(){
	sed -i 's/.*) //' $contact_list
	echo "$(awk '{print NR ")", $0}' $contact_list)" > $contact_list		## simply prints the document, without any parameters where printing is the entire record,
	sed -i '/^.\{,3\}$/d' $contact_list
}
search_course(){
    echo "[press q for main menu]"
	read -p "Enter name: " Instrc_name


	if [[ $ISBN =~ [qQ] ]] ; then 
	main_menu
	else
	grep -i "$ISBN" $contact_list || echo "NO matches"  
    fi
}

add_course(){
    echo "[press q for main menu]"
	sed -i '/^$/d' $contact_list
	line_number=($(wc -l $contact_list | awk '{ print $1 }'))
	line_num=$(( line_number + 1 ))
	

	##--------------ADD course-------

	read -p "Enter Course ID : " course_id
	if [[ $course_id =~ [qQ] ]] ; then 
	main_menu
	fi
	read -p "Enter course name: " fullname
	if [[ $fullname =~ [qQ] ]] ; then 
	main_menu
	fi
	read -p "Book ISBN number: " ISBN
	if [[ $ISBN =~ [qQ] ]] ; then 
	main_menu
	fi
    read -p "Enter Instructor name : " instrct
    if [[ $instructor =~ [qQ] ]] ; then 
	main_menu
	fi
	read -p "Enter email address: " email
	if [[ $email =~ [qQ] ]] ; then 
	main_menu
	fi
	# read -p "Enter cell number " phone
	# if [[ $phone =~ [qQ] ]] ; then 
	# main_menu
	# fi
		echo "$line_num) $course_id // $fullname //  $ISBN //  $instructor // $email // " >> $contact_list ## $phone 
		echo "--course Successfully Added---"
		echo ""

}

	##  simply show the all details stored in the file 
show_courses(){
	echo ""
	echo "--COURSES--"
	cat $contact_list
	echo ""
}

## here the delete fucntion delete the record  by the number not ISBN  i had tried stuck in errors
delete_course(){
lines=($(wc -l $contact_list | awk '{ print $1 }'))
echo "[press q for main menu]"
cat $contact_list
echo ""
until (( 1 <= x && x <= $lines )) || [[ $x =~ [qQ] ]] ; do
read -p "Choose valid number to delete COURSES: " x ## HERE DELETE THE COURSE ON THE BASIS OF SERIAL NUMBER 
done
 if [[ $x =~ [qQ] ]] ; then 
	 x= ; main_menu
 fi
confirm && sed -i "/^$x/ d" $contact_list
keep_order
x= ; main_menu

}
edit_course(){
    lines=($(wc -l $contact_list | awk '{ print $1 }'))
    echo "[press q for main menu]"
	cat $contact_list
	echo ""
	until (( 1 <= y && y <= $lines )) || [[ $y =~ [qQ] ]] ; do
	read -p "Choose valid number to edit: " y
	done
	if [[ $y =~ [qQ] ]] ; then 
		y= ; main_menu
    fi
	ph_name=$(head -$y $contact_list | tail -1 | grep -Po '(?<=([ ^])).*(?= [-])')
	ph_phone=$(head -$y $contact_list | tail -1 | grep -oP '(?<=- ).*')
	
	read -e -p  "Edit Name: " -i "$ph_name" name_edit
	read -e -p "Edit Phone: " -i "$ph_phone" phone_edit



		sed -i "/^$y/c$y) ${name_edit} - ${phone_edit}" $contact_list 
		echo "---course Edited---" 
		y= ; main_menu
}

main_menu(){
echo ""
echo "------ APP of Comp311 os linux course-----"
select action in Search Add Edit Delete Show Exit
do
case $action in

	Search) search_course ;;
	Add)    add_course ;;
	Edit)   edit_course ;;
	Delete) delete_course ;;
	Show)   show_courses ;;
	Exit) exit ;;
	*) echo "Must choose 1-6" ;;
esac
done
echo ""
}
main_menu

#place-holder for edit function
#grep -Po '(?<=([ ^])).*(?= [-])' $contact_list