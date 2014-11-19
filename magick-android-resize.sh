#!/bin/bash

DIR=$1

if [ ! -z $2 ]; then
	XX_RESIZE=$2
fi

echo $XX_RESIZE

XXXHDPI="$DIR/drawable-xxxhdpi"
XXHDPI="$DIR/drawable-xxhdpi"
XHDPI="$DIR/drawable-xhdpi"
HDPI="$DIR/drawable-hdpi"
MDPI="$DIR/drawable-mdpi"
LDPI="$DIR/drawable-ldpi"

#CREATE DIR
$(mkdir $XXXHDPI)
$(mkdir $XXHDPI)
$(mkdir $XHDPI)
$(mkdir $HDPI)
$(mkdir $MDPI)
$(mkdir $LDPI)


for i in $(ls $DIR/*.png); do

if [ ! -z $XX_RESIZE ]; then
	echo $XX_RESIZE
	convert $i -resize $XX_RESIZE $i
fi

FILENAME=$(echo $i | tr / , | awk 'BEGIN {FS=","} {print $NF}')
IMAGE_WIDTH=$(identify $i | awk ' {print $3} ' | awk ' BEGIN{FS="x"} {print $2}')

#CREATE MDPI
MDPI_SIZE=$(echo "${IMAGE_WIDTH} / 3 " | bc -l) 
echo $MDPI_SIZE
convert $i -resize x$MDPI_SIZE $MDPI/$FILENAME; 


#CREATE LDPI
LDPI_SIZE=$(echo "${MDPI_SIZE} * 0.7" | bc -l) 
echo $LDPI_SIZE
convert $i -resize x$LDPI_SIZE $LDPI/$FILENAME; 

#CREATE HDPI
HDPI_SIZE=$(echo "${MDPI_SIZE} * 1.5" | bc -l)
convert $i -resize x$HDPI_SIZE $HDPI/$FILENAME; 

#CREATE XHDPI
XHDPI_SIZE=$(echo "${MDPI_SIZE} * 2" | bc -l)
convert $i -resize x$XHDPI_SIZE $XHDPI/$FILENAME; 

#CREATE XXXHDPI
XXXHDPI_SIZE=$(echo "${MDPI_SIZE} * 4" | bc -l)
convert $i -resize x$XXXHDPI_SIZE $XXXHDPI/$FILENAME; 

#CREATE XXHDPI
mv $i $XXHDPI

done
