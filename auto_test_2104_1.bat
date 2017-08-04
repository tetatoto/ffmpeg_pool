@echo off
title Video Generator
echo Beginning

:: we suppose that there is a txt file that contains the file names of the video / images, in the right order, that we want to merge into one video

::only working with jpg images and mp4 videos, with the SAME RESOLUTION !!!
setlocal ENABLEDELAYEDEXPANSION

::STEP 1 : convert the picture into mp4 videos
FOR /F "skip=1 tokens=1,2,3 delims=, " %%i IN (test_auto_actions.txt) DO (
	echo ____________________________________________
	echo CONVERT %%k INTO A MP4 VIDEO OF %%j SECONDS
	echo ____________________________________________
	::if it is a picture, then convert into video else do nothing
	IF /I "%%i"=="i" (
		ffmpeg -framerate 1/%%j -i "workspace/%%k.jpg" -r 30 "workspace/%%k.mp4"
		
	) ELSE (echo false)

)


::we start every video with a picture of orange during a few second initialization.
SET "current_video_name=orange002"

::concatenation 2 à 2 of the videos
FOR /F "skip=1 tokens=3 delims=, " %%i IN (test_auto_actions.txt) DO (
	echo ____________________________________________
	echo CONCATENATION OF
	echo current_video_name !current_video_name! and i %%i
	echo ____________________________________________

	
	
	CALL :concatenate !current_video_name! %%i
	SET "current_video_name=!current_video_name!_%%i"

)

::adding a sound to the video
echo ____________________________________________
echo ADDING A SOUND FILE
echo ____________________________________________
::getting to line 2
SET "audio_file="
FOR /F "skip=1 delims=" %%p IN (test_auto_actions.txt) DO IF NOT DEFINED audio_file SET "audio_file=%%p"

::puting the sound on the video
ffmpeg -i "workspace/!current_video_name!.mp4" -i "workspace/sounds/!audio_file!" -codec copy -shortest "workspace/!current_video_name!_with_sound.mp4"
::update the name of the video
SET "current_video_name=!current_video_name!_with_sound"


::adding a title to the video
echo ____________________________________________
echo ADDING A TITLE
echo ____________________________________________
::getting to line 1
SET "title="
FOR /F %%h IN (test_auto_actions.txt) DO IF NOT DEFINED title SET "title=%%h"
::puting the title on the video
ffmpeg -i "workspace/!current_video_name!.mp4" -vf drawtext="fontfile=workspace/arial.ttf: text='!title!': fontcolor=white: fontsize=50: box=1: boxcolor=black@0.4: boxborderw=5: x=(w-text_w): y=(h-text_h)" -codec:a copy "workspace/!current_video_name!_with_title.mp4"
::update the name of the video
SET "current_video_name=!current_video_name!_with_sound"


echo ____________________________________________
echo THE END

GOTO :EOF


::function to concatenate the videos
:concatenate
SETLOCAL
SET "name_res="
SET "name1=%1"
SET "name2=%2"
SET "name_res=!name1!_!name2!"
echo xxxxxxxxxxxxxxxxxxxxxxxx
echo name_res !name_res!
echo xxxxxxxxxxxxxxxxxxxxxxxx
ffmpeg -i "workspace/!name1!.mp4" -i "workspace/!name2!.mp4" -filter_complex "[0:v:0] [1:v:0] concat=n=2:v=1:a=0 [v] " -map "[v]" "workspace/!name_res!.mp4"
ENDLOCAL & SET result=!name_res!

::the end of file
:EOF