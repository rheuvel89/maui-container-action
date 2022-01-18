#!/bin/bash

# msbuild /github/workspace/$1 /p:AndroidSdkDirectory=/usr/lib/android-sdk /p:Configuration="Release" /p:Platform="Any CPU" /restore
# msbuild /github/workspace/$2 /p:AndroidSdkDirectory=/usr/lib/android-sdk /p:Configuration="Release" /p:Platform="Any CPU" /t:restore /t:rebuild /t:PackageForAndroid /p:OutputPath="/github/workspace/build/"
# msbuild /github/workspace/$2 /p:AndroidSdkDirectory=/usr/lib/android-sdk /p:Configuration="Release" /p:Platform="Any CPU" /t:SignAndroidPackage /p:OutputPath="/github/workspace/build/"
export SLN_PATH=$1
export CSPROJ_PATH=$2
export CONFIGURATION=$3
export PLATFORM=$3
export ALIAS=$5
export SIGNING_KEY_PASS=$6
export SIGNING_KEY=$7
export KEY_STORE_PASSWORD=$8

echo  -n "$SIGNING_KEY" | base64 --decode >> /github/workspace/android.keystore

msbuild "$CSPROJ_PATH" /p:AndroidSdkDirectory=/usr/lib/android-sdk /p:Configuration="$CONFIGURATION" /p:Platform="$PLATFORM" /restore
msbuild "$CSPROJ_PATH" /t:restore /verbosity:normal /t:Rebuild /t:SignAndroidPackage /p:AndroidSdkDirectory=/usr/lib/android-sdk /p:Configuration="$CONFIGURATION" /p:Platform="$PLATFORM" /p:AndroidKeyStore=true /p:AndroidSigningKeyAlias="$ALIAS" /p:AndroidSigningKeyPass="$SIGNING_KEY_PASS" /p:AndroidSigningKeyStore="/github/workspace/android.keystore" /p:AndroidSigningStorePass="$KEY_STORE_PASSWORD" /p:OutputPath="/github/workspace/build/"
