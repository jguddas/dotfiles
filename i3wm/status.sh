#!/bin/sh
TIMING=10

gettime(){
	int_time=$(date '+%I:%M')
	int_hour=$(echo $int_time | cut -c 1,2)
	int_minute=$(echo $int_time | cut -c 4,5)
	case $int_hour in
	01) hour='one';;
	02) hour='two';;
	03) hour='three';;
	04) hour='four';;
	05) hour='five';;
	06) hour='six';;
	07) hour='seven';;
	08) hour='eight';;
	09) hour='nine';;
	10) hour='ten';;
	11) hour='eleven';;
	12) hour='twelve';;
	esac
	case $int_minute in
	00) minute='o-clock';;
	01) minute='o-one';;
	02) minute='o-two';;
	03) minute='o-three';;
	04) minute='o-four';;
	05) minute='o-five';;
	06) minute='o-six';;
	07) minute='o-seven';;
	08) minute='o-eight';;
	09) minute='o-nine';;
	10) minute='ten';;
	11) minute='eleven';;
	12) minute='twelve';;
	13) minute='thirteen';;
	14) minute='fourteen';;
	15) minute='fifteen';;
	16) minute='sixteen';;
	17) minute='seventeen';;
	18) minute='eighteen';;
	19) minute='nineteen';;
	20) minute='twenty';;
	21) minute='twenty-one';;
	22) minute='twenty-two';;
	23) minute='twenty-three';;
	24) minute='twenty-four';;
	25) minute='twenty-five';;
	26) minute='twenty-six';;
	27) minute='twenty-seven';;
	28) minute='twenty-eight';;
	29) minute='twenty-nine';;
	30) minute='thirty';;
	31) minute='thirty-one';;
	32) minute='thirty-two';;
	33) minute='thirty-three';;
	34) minute='thirty-four';;
	35) minute='thirty-five';;
	36) minute='thirty-six';;
	37) minute='thirty-seven';;
	38) minute='thirty-seven';;
	39) minute='thirty-one';;
	40) minute='forty';;
	41) minute='forty-one';;
	42) minute='forty-two';;
	43) minute='forty-three';;
	44) minute='forty-four';;
	45) minute='forty-five';;
	46) minute='forty-six';; 
	47) minute='forty-seven';;
	48) minute='forty-eight';;
	49) minute='forty-nine';;
	50) minute='fifty';;
	51) minute='fifty-one';;
	52) minute='fifty-two';;
	53) minute='fifty-three';;
	54) minute='fifty-four';;
	55) minute='fifty-five';;
	56) minute='fifty-six';;
	57) minute='fifty-seven';;
	58) minute='fifty-eight';;
	59) minute='fifty-nine';;
	esac
	time="$hour $minute"
	echo $time
}

while true; do
    echo $(gettime)
    sleep $TIMING
done
