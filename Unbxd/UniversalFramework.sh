# 1
# Set bash script to exit immediately if any commands fail.
set -e
# 2
# Setup some constants for use later on.
FRAMEWORK_NAME="Unbxd"
OUTPUT_DIR="${SRCROOT}/build"
# 3
# If remnants from a previous build exist, delete them.
if [ -d "${OUTPUT_DIR}" ]; then
rm -rf "${OUTPUT_DIR}"
fi
# 4
# Build the framework for device and for simulator (using
# all needed architectures).
echo "Building for device"
xcodebuild -project "${FRAMEWORK_NAME}.xcodeproj" -scheme "${FRAMEWORK_NAME}" -configuration Release -arch arm64 -arch armv7 -arch armv7s only_active_arch=no defines_module=yes -sdk "iphoneos" -derivedDataPath "${OUTPUT_DIR}"
echo "Building for Simulator"
xcodebuild -project "${FRAMEWORK_NAME}.xcodeproj" -scheme "${FRAMEWORK_NAME}" -configuration Release -arch x86_64 -arch i386 only_active_arch=no defines_module=yes -sdk "iphonesimulator" -derivedDataPath "${OUTPUT_DIR}"

# Remove .framework file if exists from previous run.
if [ -d "${OUTPUT_DIR}/${FRAMEWORK_NAME}.framework" ]; then
rm -rf "${OUTPUT_DIR}/${FRAMEWORK_NAME}.framework"
fi

# Copy the device version of framework.
cp -r "${OUTPUT_DIR}/Build/Products/Release-iphoneos/${FRAMEWORK_NAME}.framework" "${OUTPUT_DIR}/${FRAMEWORK_NAME}.framework"
# Merging the device and simulator frameworks' executables with 
# lipo.
lipo -create -output "${OUTPUT_DIR}/${FRAMEWORK_NAME}.framework/${FRAMEWORK_NAME}" "${OUTPUT_DIR}/Build/Products/Release-iphoneos/${FRAMEWORK_NAME}.framework/${FRAMEWORK_NAME}" "${OUTPUT_DIR}/Build/Products/Release-iphonesimulator/${FRAMEWORK_NAME}.framework/${FRAMEWORK_NAME}"
# Copy Swift module mappings for simulator into the framework. 
cp -r "${OUTPUT_DIR}/Build/Products/Release-iphonesimulator/${FRAMEWORK_NAME}.framework/Modules/${FRAMEWORK_NAME}.swiftmodule/" "${OUTPUT_DIR}/${FRAMEWORK_NAME}.framework/Modules/${FRAMEWORK_NAME}.swiftmodule"
cp -r "${OUTPUT_DIR}/Build/Products/Release-iphoneos/${FRAMEWORK_NAME}.framework/Modules/${FRAMEWORK_NAME}.swiftmodule/" "${OUTPUT_DIR}/${FRAMEWORK_NAME}.framework/Modules/${FRAMEWORK_NAME}.swiftmodule"

# Create new combined simulator and device swift header file.
COMBINED_PATH="${BUILD_DIR}/iOS + iOS Simulator/${PROJECT_NAME}-Swift.h"
mkdir -p "${BUILD_DIR}/iOS + iOS Simulator/"
touch "${COMBINED_PATH}"
echo "#ifndef TARGET_OS_SIMULATOR\n#include <TargetConditionals.h>\n#endif\n#if TARGET_OS_SIMULATOR" >> "${COMBINED_PATH}"
cat "${OUTPUT_DIR}/Build/Products/Release-iphonesimulator/${FRAMEWORK_NAME}.framework/Headers/${FRAMEWORK_NAME}-Swift.h" >> "${COMBINED_PATH}"
echo "#else" >> "${COMBINED_PATH}"
echo "//Start of iphoneos" >> "${COMBINED_PATH}"
cat "${OUTPUT_DIR}/Build/Products/Release-iphoneos/${FRAMEWORK_NAME}.framework/Headers/${FRAMEWORK_NAME}-Swift.h" >> "${COMBINED_PATH}"
echo "#endif" >> "${COMBINED_PATH}"
# Overwrite generated -Swift.h file with combined -Swift.h file 
cat "$COMBINED_PATH" > "${OUTPUT_DIR}/${FRAMEWORK_NAME}.framework/Headers/${FRAMEWORK_NAME}-Swift.h"
#Optional Step to copy the framework to root folder
cp -r "${OUTPUT_DIR}/${FRAMEWORK_NAME}.framework" "${SRCROOT}"