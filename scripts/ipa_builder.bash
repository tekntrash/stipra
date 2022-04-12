FIRSTPATH=$PWD
cd $PWD
cd ../build/ios/archive
xcodebuild -exportArchive -archivePath Runner.xcarchive -exportOptionsPlist $FIRSTPATH/exportOptions.plist -exportPath $FIRSTPATH/build
rm -fr Runner.xcarchive