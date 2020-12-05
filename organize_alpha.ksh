for FIL in A B C D E F G H I J K L M N O P Q R S T U V W X Y Z ; do mkdir $FIL ; mv -v $(ls | grep -i ^${FIL}) $FIL/ ; done 
