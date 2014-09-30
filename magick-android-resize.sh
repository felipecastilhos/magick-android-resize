#!/bin/bash

DIR=$1


#BASE_RESIZE is set as 3, because android guidelines set MDPI as XXHDPI/3
if [  -z $2 ]; then
	BASE_RESIZE=3
else  
	BASE_RESIZE=$2
fi

XXHDPI="$DIR/drawable-xxhdpi"
XHDPI="$DIR/drawable-xhdpi"
HDPI="$DIR/drawable-hdpi"
MDPI="$DIR/drawable-mdpi"

#CREATE DIR
$(mkdir $XXHDPI)
$(mkdir $XHDPI)
$(mkdir $HDPI)
$(mkdir $MDPI)

for i in $(ls $DIR/*.png); do

FILENAME=$(echo $i | tr / , | awk 'BEGIN {FS=","} {print $NF}')
IMAGE_WIDTH=$(identify $i | awk ' {print $3} ' | awk ' BEGIN{FS="x"} {print $2}')

#CREATE MDPI
MDPI_SIZE=$(echo "${IMAGE_WIDTH} / ${BASE_RESIZE} " | bc -l) 
convert $i -resize $MDPI_SIZE $MDPI/$FILENAME; 


#CREATE HDPI
HDPI_SIZE=$(echo "${MDPI_SIZE} * 1.5" | bc -l)
convert $i -resize $HDPI_SIZE $HDPI/$FILENAME; 

#CREATE XHDPI
XHDPI_SIZE=$(echo "${MDPI_SIZE} * 2" | bc -l)
convert $i -resize $XHDPI_SIZE $XHDPI/$FILENAME; 

#CREATE XXHDPI
mv $i $XXHDPI

done






