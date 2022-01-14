#!/bin/bash

msbuild /github/workspace/$1 /p:AndroidSdkDirectory=/usr/lib/android-sdk /p:Configuration="Release" /p:Platform="Any CPU" /restore
msbuild /github/workspace/$2 /p:AndroidSdkDirectory=/usr/lib/android-sdk /p:Configuration="Release" /p:Platform="Any CPU" /t:restore /t:rebuild /t:PackageForAndroid /p:OutputPath="/github/workspace/build/"
msbuild /github/workspace/$2 /p:AndroidSdkDirectory=/usr/lib/android-sdk /p:Configuration="Release" /p:Platform="Any CPU" /t:SignAndroidPackage /p:OutputPath="/github/workspace/build/"
