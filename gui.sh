PROJECTNAME=$1
TOPMOD="${PROJECTNAME}_tmod"

PCF_PATH=main.pcf
BIN_DIR=bin/$PROJECTNAME

[ ! -d "$BIN_DIR" ] && echo "Project $PROJECTNAME Does Not Exist!" && exit 1;

ASC_PATH=$BIN_DIR/$PROJECTNAME.asc
BIN_PATH=$BIN_DIR/$PROJECTNAME.bin
JSON_PATH=$BIN_DIR/$PROJECTNAME.json
TIMINGS_PATH=$BIN_DIR/$PROJECTNAME.timings

SRC_PATH=/src/$PROJECTNAME
SRC=$(find $SRC_PATH -type f | tr '\n' ' ')
LIB=$(find lib -type f | tr '\n' ' ')

mkdir -p "bin"
mkdir -p "bin/$PROJECTNAME"

yosys -q -p "synth_ice40 -top $TOPMOD -json $JSON_PATH" $SRC $LIB || exit 1
nextpnr-ice40 --force --json $JSON_PATH --pcf $PCF_PATH --asc $ASC_PATH --freq 12 --hx1k --package tq144 --gui || exit 1
