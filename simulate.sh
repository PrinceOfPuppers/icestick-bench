PROJECTNAME=$1

BIN_DIR=bin/$PROJECTNAME
SRC_PATH=src/$PROJECTNAME

SIM_NAME=$BIN_DIR/${PROJECTNAME}_sim

[ ! -d "$SRC_PATH" ] && echo "Project $PROJECTNAME Does Not Exist!" && exit 1;

SRC=$(find $SRC_PATH -type f | tr '\n' ' ')
LIB=$(find lib -type f | tr '\n' ' ')

mkdir -p "bin"
mkdir -p "bin/$PROJECTNAME"

iverilog -DBENCH -g2005-sv -o $SIM_NAME $SRC $LIB || exit 1;
vvp $SIM_NAME
