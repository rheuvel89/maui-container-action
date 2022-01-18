#!/bin/bash

# msbuild /github/workspace/$1 /p:AndroidSdkDirectory=/usr/lib/android-sdk /p:Configuration="Release" /p:Platform="Any CPU" /restore
# msbuild /github/workspace/$2 /p:AndroidSdkDirectory=/usr/lib/android-sdk /p:Configuration="Release" /p:Platform="Any CPU" /t:restore /t:rebuild /t:PackageForAndroid /p:OutputPath="/github/workspace/build/"
# msbuild /github/workspace/$2 /p:AndroidSdkDirectory=/usr/lib/android-sdk /p:Configuration="Release" /p:Platform="Any CPU" /t:SignAndroidPackage /p:OutputPath="/github/workspace/build/"
export SLN_PATH=$1
export CSPROJ_PATH=$2
export CONFIGURATION=$3
export ALIAS=$4
export SIGNING_KEY_PASS=$5
export SIGNING_KEY=$6
export KEY_STORE_PASSWORD=$7

echo  -n "$SIGNING_KEY" | base64 --decode >> /github/workspace/android.keystore

msbuild "$CSPROJ_PATH" /p:AndroidSdkDirectory=/usr/lib/android-sdk /p:Configuration="$CONFIGURATION" /p:Platform="Any CPU" /restore
msbuild "$CSPROJ_PATH" /t:restore /verbosity:normal /t:Rebuild /t:SignAndroidPackage /p:AndroidSdkDirectory=/usr/lib/android-sdk /p:Configuration="$CONFIGURATION" /p:Platform="Any CPU" /p:AndroidKeyStore=true /p:AndroidSigningKeyAlias="$ALIAS" /p:AndroidSigningKeyPass="$SIGNING_KEY_PASS" /p:AndroidSigningKeyStore="/github/workspace/android.keystore" /p:AndroidSigningStorePass="$KEY_STORE_PASSWORD" /p:OutputPath="/github/workspace/build/"
