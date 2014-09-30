#!/bin/bash

DIR=$1

XXHDPI="$DIR/drawable-xxhpdi"
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
MDPI_SIZE=$(echo "${IMAGE_WIDTH} / 3" | bc -l) 
convert $i -resize $MDPI_SIZE $MDPI/$FILENAME; 
echo $MDPI_SIZE


#CREATE HDPI
HDPI_SIZE=$(echo "${MDPI_SIZE} * 1.5" | bc -l)
convert $i -resize $HDPI_SIZE $HDPI/$FILENAME; 
echo $HDPI_SIZE

#CREATE XHDPI
XHDPI_SIZE=$(echo "${MDPI_SIZE} * 2" | bc -l)
convert $i -resize $XHDPI_SIZE $XHDPI/$FILENAME; 
echo $XHDPI_SIZE

#CREATE XXHDPI
mv $i $XXHDPI

done






