#!/bin/bash
export dropbox=/home/wxdisplay/Models/OUTPUT
sleep 180
runcount=0
modelFail=0
echo "ERROR LIST" >& $dropbox/system/ERROR.LOG
date -u >> $dropbox/system/ERROR.LOG
cd /home/wxdisplay/Models/DOMAINS

echo "------------ Modeling Schedule -----------"
		echo "   1deg Global WRF-ARW(GFS)"            # Every 8th Model Run
		date -u

while true
do
	# ERROR DETECTION RESET-----------------------
	errorCode=0 #RESET ERROR CODES

	scp $dropbox/system/ERROR.LOG wxdisplay@10.17.157.196:/home/weewx/public_html/WRF_ARW/system
	scp $dropbox/system/SYSTEM_STATUS.log wxdisplay@10.17.157.196:/home/weewx/public_html/WRF_ARW/system
	scp $dropbox/system/WRF_glb.log wxdisplay@10.17.157.196:/home/weewx/public_html/WRF_ARW/system
	scp $dropbox/system/WRF_STATUS.log wxdisplay@10.17.157.196:/home/weewx/public_html/WRF_ARW/system

	if [[ $runCount -eq 0 ]]; then
		loopCount=0
	fi	
	if [[ $runCount -ne 0 ]]; then
		loopCount=$loopCount+1
	fi
	
	#problemNumber=$(( $loopCount % 1 ))	
	
	#if [[ $problemNumber = 0 ]]; then
		consecutiveProblems=0 #RESET CONSECUTIVE PROBLEM COUNTER
	#fi
	
	# TIME PREP--------------------------
	export wtime=$(date -u +"%H")
	




	#echo "TIME VARIABLE:" $wtime #FOR DEBUG

	if [[ $wtime = 5 ]]; then
		shutdown = true
	fi

##############################################################################################################################
#--------------------------------------------- GLOBAL WRF-ARW ------------------------------
###############################################################################################################################
	
	#if [[ $wtime = 0 || $wtime = 6 || $wtime = 12 || $wtime = 18 ]]; then                  # 15hr and 3hr for other runs
	if [[ $wtime = 3 || $wtime = 15 ]]; then
		echo "Proceeding with 1deg WRF-ARW at f"$wtime
		timestart=$(date +"%s") 
      	
		./scriptrunGLB1d.csh

		timeend=$(date +"%s")
		duration=$(($timeend-$timestart))
		
		if [ $duration -lt 30 ]; then
			errorCode=1
			modelFail=$(( $modelFail+1 ))
			badModel=3
			consecutiveProblems=$(( $consecutiveProblems+1 ))
		fi		
				
		if [[ $runcount = 0 ]]; then
			duration_save=0
		fi

		avgruntimecalc=$(( ($duration+$duration_save) / ($runcount + 1) ))
		avgruntime=$(( ($avgruntimecalc/60) ))
				
		duration_save=$(( $duration_save+$duration ))

		# DISPLAY/LOG SOME DIAGNOSTIC INFORMATION -----------------------------------------
		runcount=$(( $runcount+1 ))

		echo "   -- MODELING SYSTEM DIAGNOSTICS --"
		echo "# of Schedule Runs        :"  $runcount
		echo "# of Model Failures       :" $modelFail
		echo "Average Schedule Run-time :" $avgruntime " min"
		echo "Hard Disk Statistics      :"
		df -h
		echo ""
		free
		echo "CPU Usage                 :"
		top -bn 1 | sed -n '3p'
		
		rm $dropbox/system/SYSTEM_STATUS.log
		echo "   -- MODELING SYSTEM DIAGNOSTICS --" >> $dropbox/system/SYSTEM_STATUS.log
		echo "# of Schedule Runs        :" $runcount >> $dropbox/system/SYSTEM_STATUS.log
		echo "# of Model Failures       :" $modelFail >> $dropbox/system/SYSTEM_STATUS.log
		echo "Average Schedule Run-time :" $avgruntime " min" >> $dropbox/system/SYSTEM_STATUS.log
		echo "Hard Disk Statistics      :" >> $dropbox/system/SYSTEM_STATUS.log
		df -h >> $dropbox/system/SYSTEM_STATUS.log
		echo "" >> $dropbox/system/SYSTEM_STATUS.log
		echo "Memory Statistics         :" >> $dropbox/system/SYSTEM_STATUS.log
		free >> $dropbox/system/SYSTEM_STATUS.log
		echo "CPU Usage                 :" >> $dropbox/system/SYSTEM_STATUS.log
		top -bn 1 | sed -n '3p' >> $dropbox/system/SYSTEM_STATUS.log
			
	fi

##############################################################################################################################
#--------------------------------------------- 30km WRF-ARW(NAM) -----------------------------------
###############################################################################################################################
	
	if [[ $wtime = 0 || $wtime = 6 || $wtime = 12 || $wtime = 18 ]]; then                  # 15hr and 3hr for other runs
	#if [[ $wtime = 0 || $wtime = 12 ]]; then
		echo "Proceeding with 30km WRF-ARW(NAM) at f"$wtime
		timestart=$(date +"%s") 
      	
		./scriptrun30US.csh

		timeend=$(date +"%s")
		duration=$(($timeend-$timestart))
		
		if [ $duration -lt 30 ]; then
			errorCode=1
			modelFail=$(( $modelFail+1 ))
			badModel=2
			consecutiveProblems=$(( $consecutiveProblems+1 ))
		fi		
				
		if [[ $runcount = 0 ]]; then
			duration_save=0
		fi

		avgruntimecalc=$(( ($duration+$duration_save) / ($runcount + 1) ))
		avgruntime=$(( ($avgruntimecalc/60) ))
				
		duration_save=$(( $duration_save+$duration ))

		# DISPLAY/LOG SOME DIAGNOSTIC INFORMATION -----------------------------------------
		runcount=$(( $runcount+1 ))

		echo "   -- MODELING SYSTEM DIAGNOSTICS --"
		echo "# of Schedule Runs        :"  $runcount
		echo "# of Model Failures       :" $modelFail
		echo "Average Schedule Run-time :" $avgruntime " min"
		echo "Hard Disk Statistics      :"
		df -h
		echo ""
		free
		echo "CPU Usage                 :"
		top -bn 1 | sed -n '3p'
		
		rm $dropbox/system/SYSTEM_STATUS.log
		echo "   -- MODELING SYSTEM DIAGNOSTICS --" >> $dropbox/system/SYSTEM_STATUS.log
		echo "# of Schedule Runs        :" $runcount >> $dropbox/system/SYSTEM_STATUS.log
		echo "# of Model Failures       :" $modelFail >> $dropbox/system/SYSTEM_STATUS.log
		echo "Average Schedule Run-time :" $avgruntime " min" >> $dropbox/system/SYSTEM_STATUS.log
		echo "Hard Disk Statistics      :" >> $dropbox/system/SYSTEM_STATUS.log
		df -h >> $dropbox/system/SYSTEM_STATUS.log
		echo "" >> $dropbox/system/SYSTEM_STATUS.log
		echo "Memory Statistics         :" >> $dropbox/system/SYSTEM_STATUS.log
		free >> $dropbox/system/SYSTEM_STATUS.log
		echo "CPU Usage                 :" >> $dropbox/system/SYSTEM_STATUS.log
		top -bn 1 | sed -n '3p' >> $dropbox/system/SYSTEM_STATUS.log
			
	fi

################################################################################################################################
# ------------------------------------ SYSTEM DIAGNOSTICS -----------------------------------------------------------
################################################################################################################################	

	# ERROR DETECTION ------------------------------------------------------------------------
	#shutdown=true

	if [[ $errorCode -ne 0 ]]; then # simple error logging
	
		echo "Congratulations, you've recieved this error code:" >> $dropbox/system/ERROR.LOG
		echo "Model#: "$badModel >> $dropbox/system/ERROR.LOG
		echo "Error#: "$errorCode >> $dropbox/system/ERROR.LOG
		date -u >> $dropbox/system/ERROR.LOG
		
	fi
	
	if [[ $consecutiveProblems -gt 6 ]]; then # sequential failure detection
		echo "MORE THAN 6 CONSECUTIVE FAILURES" >> $dropbox/system/ERROR.LOG
		echo "CRITICAL ERROR AT TIME" >> $dropbox/system/ERROR.LOG
		date -u >> $dropbox/system/ERROR.LOG
		shutdown=true
	fi

	if [[ $shutdown = true ]]; then # the ultimatim
		
		echo "SYSTEM FAILURE" >> $dropbox/system/ERROR.LOG
		date -u >> $dropbox/system/ERROR.LOG
		echo "            !!!!!!!!!!!!!!!!! SYSTEM FAILURE !!!!!!!!!!!!!!!!!!!!"
		
		scp $dropbox/system/ERROR.LOG wxdisplay@10.17.157.196:/home/weewx/public_html/WRF_ARW/system
		scp $dropbox/system/SYSTEM_STATUS.log wxdisplay@10.17.157.196:/home/weewx/public_html/WRF_ARW/system
		scp $dropbox/system/WRF_glb.log wxdisplay@10.17.157.196:/home/weewx/public_html/WRF_ARW/system
		scp $dropbox/system/WRF_STATUS.log wxdisplay@10.17.157.196:/home/weewx/public_html/WRF_ARW/system
		break
	fi

	#echo "BYPASS"      # for debug
	sleep 60

done
