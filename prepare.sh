#!/bin/sh
CURRENT_PWD=$(pwd)
TOP=$HOME
INFOS_REPO=https://github.com/tspink/infos.git
INFOS_COMMIT=9416552cb225fb2be1be6adcdb034f246d7c44b7
INFOS_USERSPACE_REPO=https://github.com/tspink/infos-user.git
INFOS_USERSPACE_COMMIT=7c9d37bd296fe3601d5e9c2cb10293be4b62eb59
COURSEWORK_SUBMISSION_DIR="$CURRENT_PWD"/coursework-submission/
COURSEWORK_SKELETON_DIR="$CURRENT_PWD"/coursework-skeleton/
COURSEWORK_UTILITY_DIR="$CURRENT_PWD"/utility-scripts/
echo "Preparing coursework directory for OS..."

if [ ! -d $TOP ]; then
	echo "ERROR: Home directory does not exist!"
	exit 1
fi

TARGET=$TOP/os-coursework

if [ -d $TARGET ]; then
	echo "ERROR: Target directory $TARGET already exists... ABORTING!"
	exit 1
fi

echo "Creating target directory $TARGET..."
mkdir $TARGET 

echo "Checking out infos repository..."
git clone $INFOS_REPO $TARGET/infos
cd $TARGET/infos && git checkout $INFOS_COMMIT

echo "Checking out infos-user repository..."
git clone $INFOS_USERSPACE_REPO $TARGET/infos-user
cd $TARGET/infos-user && git checkout $INFOS_USERSPACE_COMMIT



echo "Copying coursework skeleton files..."
cp -r $COURSEWORK_SKELETON_DIR/ $TARGET/coursework-skeletons
chmod -R a-w $TARGET/coursework-skeletons
cp -r $COURSEWORK_SKELETON_DIR/ $TARGET/coursework
mkdir -p $COURSEWORK_SUBMISSION_DIR/
cp -r $COURSEWORK_SUBMISSION_DIR/* $TARGET/coursework/

echo "Connecting coursework directory to master source..."
ln -s $TARGET/coursework $TARGET/infos/oot

echo "Copying utility scripts..."
cp $COURSEWORK_UTILITY_DIR/* $TARGET/

echo
echo "**********"
echo "   DONE   "
echo "**********"
echo

echo "  The infos coursework development environment has been created in:"
echo
echo "    $TARGET"

echo
echo "  From that directory, the following script can be used to build"
echo "  and run infos:"
echo
echo "    ./build-and-run.sh"
echo
echo "  Your coursework solutions (in the coursework directory) will be"
echo "  AUTOMATICALLY compiled in."
echo
echo "  In order for infos to use your implementations, you MUST specify"
echo "  your modules on the command-line, e.g.:"
echo
echo "    ./build-and-run.sh pgalloc.algorithm=buddy"
echo
echo "  See the coursework specification document for further information,"
echo "  and what command-line options are available for debugging."
echo
