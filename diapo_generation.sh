#!/bin/bash

#we take one argument : the duration of the video. This argument is called by $0 in this script

video_duration=$1
echo "***************************************************************"
echo "STARTING THE GENERATION OF THE FULL VIDEO"
echo "_______________________________________________________________"
echo "The duration of the video is $video_duration seconds "


# FIRST STEP : creating a loop with the template video in order to reach the right duration (given in argument)

let 'template_duration=13'
let 'current_duration=0'

echo "The duration of the template is $template_duration seconds"
echo "_______________________________________________________________"

# 1.1 // loop to get the full duration video

# while [ $current_duration -lt $video_duration ]
# do 
#     echo ""
# done

# 1.2 // Adding the sound file to the video

# SECOND STEP : Adding images to the background on the top right corner of the video

# 2.1 // 
image='image007.jpg'
echo "test converting image size command line"
convert "$image" -resize 200x200> miniatures/$image
# for image in ` /images/*.png /images/*.jpg /images/*.jpeg /images/*.gif 2>/dev/null`
# do
#     convert $image -thumbnail '200x200>' miniatures/$image
#     echo "one more"
# done























