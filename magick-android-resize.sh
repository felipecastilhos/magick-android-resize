#!/bin/bash

DIR=$1

XXHDPI="$DIR/XXHDPI"
XHDPI="$DIR/XHDPI"
HDPI="$DIR/HDPI"
MDPI="$DIR/MDPI"

#CREATE DIR
$(mkdir $XXHDPI)
$(mkdir $XHDPI)
$(mkdir $HDPI)
$(mkdir $MDPI)

for i in $(ls $DIR/*.png); do

FILENAME=$(echo $i | tr / , | awk 'BEGIN {FS=","} {print $NF}')
IMAGE_WIDTH=$(identify $i | awk ' {print $3} ' | awk ' BEGIN{FS="x"} {print $2}')


#CREATE MDPI
MDPI_SIZE=$(echo "${IMAGE_WIDTH} / 3" | bc -l) 
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






