@echo off
title Video Generator
echo Beginning

:: we suppose that there is a txt file that contains the file names of the video / images, in the right order, that we want to merge into one video
SET /A num=1
FOR /F "skip=1 tokens=1,2,3 delims=, " %%i IN (test_auto_actions.txt) DO (
	echo ______________________
	echo %%i %%j %%k
	echo num vaut %num%
	IF /I "%%i"=="i" (
		SET /A num =num+1
		ffmpeg -framerate 1/%%j -i "workspace/%%k" -r 30 "workspace/nom_test.mp4"
	) ELSE (echo false)
	
)
echo ______________________
echo the end