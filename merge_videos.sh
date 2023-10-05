#!/bin/bash


BASEDIR=$(pwd)

find . -type f -not -name '*.mp4'  -delete

mkdir Output ; touch Output/file.txt


for dir in */; do


    if [[ "$dir" == "Output/" ]]; then
      break
    fi

    if [ -d "$dir" ]; then

        cd "$dir"
        
        for filename in *; do
          
            echo ${filename} >> ${BASEDIR}/Output/file.txt 

            cp ${filename} ${BASEDIR}/Output        

        done

        cd .. 

    fi

done


cd ${BASEDIR}/Output ; sed -i '' "s/.*/file '&'/" file.txt ; less file.txt



vared -p "Continue (y/n)?" -c reply 

if [ "$reply" = "y" ]; then
 
ffmpeg -f concat -safe 0 -i file.txt -c copy output.mp4
find . -type f -not -name 'output.mp4'  -delete
cd ..

else

  cd ..
  echo "nothing to be done";

fi


