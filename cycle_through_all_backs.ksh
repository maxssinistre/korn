#!/bin/ksh



LIST="
/mnt/NASSER/drive2/SHIRT_WOOT/PICS/
/mnt/drive2/PICS/
/mnt/NASSER/drive3/nice/LOWBIRD/PICS/
/mnt/NASSER/drive3/nice/BRANTLEY-KEITH/PICS/
/mnt/NASSER/drive3/nice/IMGUR_SCENERY/PICS/
/mnt/NASSER/drive3/nice/IMGUR_CROSSFIT/PICS/
/mnt/NASSER/drive3/nice/IMGUR_FORMULA1/PICS/
/mnt/NASSER/drive3/nice/IMGUR_WEIGHTLIFTING/PICS/
/mnt/NASSER/drive2/BACKGROUNDS/UNIFIED/
/mnt/NASSER/drive3/nice/RUBADUBDUBB/PICS/
/mnt/NASSER/drive3/nice/BANGSHIFT/PICS/
/mnt/NASSER/drive3/nice/ironmind/PICS/
"

SLEP=$@

SLEEPY=${SLEP:-60}


while true ; do 

	for DIRP in $LIST ; do 

		back_generic_back.ksh -r -d ${DIRP}

		sleep ${SLEEPY}

	done

done


function original {
      ' [exec] (Shirt woot backgrounds)         {xv -maxpect -root -quit -random /mnt/NASSER/drive2/SHIRT_WOOT/PICS/*}
        [exec] (Various backgrounds)            {xv -maxpect -root -quit -random /mnt/drive2/PICS/*}
#       [exec] (Various backgrounds)            {xv -maxpect -root -quit -random /home/PICS/*}
        [exec] (Lowbird backgrounds)            {xv -maxpect -root -quit -random /mnt/NASSER/drive3/nice/LOWBIRD/PICS/* }
        [exec] (Cycle through Lowbird backgrounds)              {back_generic_back.ksh -c -r -t 10 -d /mnt/NASSER/drive3/nice/LOWBIRD/PICS/ }
        [exec] (Brantley-Keith backgrounds)             {xv -maxpect -root -quit -random /mnt/NASSER/drive3/nice/BRANTLEY-KEITH/PICS/* }
        [exec] (Cycle through Brantley-Keith backgrounds)               {back_generic_back.ksh -c -r -t 10 -d /mnt/NASSER/drive3/nice/BRANTLEY-KEITH/PICS/ }
        [exec] (IMGUR scenery backgrounds)              {xv -maxpect -root -quit -random /mnt/NASSER/drive3/nice/IMGUR_SCENERY/PICS/* }
        [exec] (Cycle through  IMGUR scenery backgrounds)               {back_generic_back.ksh -c -r -t 10 -d /mnt/NASSER/drive3/nice/IMGUR_SCENERY/PICS/ }



        [exec] (IMGUR crossfit backgrounds)              {xv -maxpect -root -quit -random /mnt/NASSER/drive3/nice/IMGUR_CROSSFIT/PICS/* }
        [exec] (Cycle through  IMGUR crossfit backgrounds)               {back_generic_back.ksh -c -r -t 10 -d /mnt/NASSER/drive3/nice/IMGUR_CROSSFIT/PICS/ }

        [exec] (IMGUR FORMULA1 backgrounds)              {xv -maxpect -root -quit -random /mnt/NASSER/drive3/nice/IMGUR_FORMULA1/PICS/* }
        [exec] (Cycle through  IMGUR FORMULA1 backgrounds)               {back_generic_back.ksh -c -r -t 10 -d /mnt/NASSER/drive3/nice/IMGUR_FORMULA1/PICS/ }

        [exec] (IMGUR WEIGHTLIFTING backgrounds)              {xv -maxpect -root -quit -random /mnt/NASSER/drive3/nice/IMGUR_WEIGHTLIFTING/PICS/* }
        [exec] (Cycle through  IMGUR WEIGHTLIFTING backgrounds)               {back_generic_back.ksh -c -r -t 10 -d /mnt/NASSER/drive3/nice/IMGUR_WEIGHTLIFTING/PICS/ }






        [exec] (STOP Cycle through backgrounds)         {back_generic_back.ksh -k }
        [exec] (GENERIC backgrounds)            {xv -maxpect -root -quit -random /mnt/NASSER/drive2/BACKGROUNDS/UNIFIED/* }
        [exec] (Cycle through BENERIC backgrounds)              {back_generic_back.ksh -c -r -t 10 -d /mnt/NASSER/drive2/BACKGROUNDS/UNIFIED/ }
        [exec] (STOP Cycle through GENERIC backgrounds)         {back_generic_back.ksh -k }
        [exec] (Latest Shirt woot backgrounds- last 5 randomly)         {latest_shirtwoot.ksh 5}
        [exec] (Latest Shirt woot backgrounds - latest one)             {latest_shirtwoot.ksh 1}
        [exec] (RUBABDUBDUB backgrounds)                {xv -maxpect -root -quit -random /mnt/NASSER/drive3/nice/RUBADUBDUBB/PICS/*}
        [exec] (Bangshift backgrounds)          {xv -maxpect -root -quit -random /mnt/NASSER/drive3/nice/BANGSHIFT/BANGSHIFT_DAILY/*}
        [exec] (Ironmind backgrounds)           {xv -maxpect -root -quit -random /mnt/NASSER/drive3/nice/ironmind/PICS/*}
        [exec] (Goheavy backgrounds)            {xv -maxpect -root -quit -random  /mnt/NASSER/drive3/nice/GOHEAVY/PICS/*}
'
}
