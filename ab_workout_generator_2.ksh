#!/bin/ksh


function choice {

NUM=$1

echo $RANDOM | cut -c $NUM 

}

function set_decision {

NUM=$(choice 1)

set -A SET_NUMBER NULL 1 2 3 1 2 3 1 2 3

echo ${SET_NUMBER[$NUM]}

}
function rep_decision {

NUM=$(choice 1,2)

while [ $NUM -gt 20 ] || [ $NUM -lt 10 ] ; do 
	
		NUM=$(choice 1,2) 
done

echo $NUM
}

function time_decision {

NUM=$(choice 1,2)

while [ $NUM -gt 60 ] || [ $NUM -lt 20 ] ; do 
	
		NUM=$(choice 1,2) 
done

echo $NUM

}

function set_reps {

EXERCISE="$@"

if echo "$EXERCISE" | grep time > /dev/null  ; then

echo you will use $(set_decision) sets of $(time_decision) seconds

else

echo you will use $(set_decision) sets of $(rep_decision) reps 

fi
echo

}

set -A LINEAR NULL "Medicine Ball Rollout" "Linear vertical Pallof Press" "Swiss Ball Pike" "The Body Saw" "Medicine Ball Rollout" "Linear vertical Pallof Press" "Swiss Ball Pike" "The Body Saw" "Medicine Ball Rollout"

set -A LATERAL NULL "Side Plank on Medicine Ball time" "Single-Arm Front Plank on Swiss Ball time" "Turkish Get-Ups" "Angled Barbell Rainbows" "Lateral Pallof Press" "Side Plank on Medicine Ball time" "Single-Arm Front Plank on Swiss Ball time" "Turkish Get-Ups" "Angled Barbell Rainbows" "Lateral Pallof Press"

set -A DYNAMIC NULL "Tight Rotations time" "The Gladiator Twist time" "Heavy Bag Rotary Strikes time" "Tight Rotations time" "The Gladiator Twist time" "Heavy Bag Rotary Strikes time" "Tight Rotations time" "The Gladiator Twist time" "Heavy Bag Rotary Strikes time" 

#DYNAMIC="Tight_Rotations The_Gladiator_Twist Medicine_Ball_Rotary_Tosses" 


#Print exercises
echo
echo "Linear Abdominal Exercises"

NUMBER=$(choice 1)
echo $(echo ${LINEAR[$NUMBER]} | sed 's#time##g')

set_reps ${LINEAR[$NUMBER]} 

echo "Lateral/ Rotary Stability Abdominal Exercises"

NUMBER=$(choice 1)
echo $(echo ${LATERAL[$NUMBER]} | sed 's#time##g')

set_reps ${LATERAL[$NUMBER]}

echo "Dynamic Rotary Abdominal Exercises"

NUMBER=$(choice 1)
echo $(echo ${DYNAMIC[$NUMBER]} | sed 's#time##g')

set_reps ${DYNAMIC[$NUMBER]}





