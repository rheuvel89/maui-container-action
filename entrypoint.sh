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

mkdir /github/home/Library/
mkdir /github/home/Library/Android/
ln -s /root/Library/Android/sdk /github/home/Library/Android/sdk

echo  -n "$SIGNING_KEY" | base64 --decode >> /github/workspace/android.keystore

msbuild "$CSPROJ_PATH" /restore /p:Configuration="$CONFIGURATION"
msbuild "$CSPROJ_PATH" /t:restore /t:clean /t:Rebuild /t:SignAndroidPackage /verbosity:normal /p:Configuration="$CONFIGURATION" /p:AndroidKeyStore=true /p:AndroidSigningKeyAlias="$ALIAS" /p:AndroidSigningKeyPass="$SIGNING_KEY_PASS" /p:AndroidSigningKeyStore="/github/workspace/android.keystore" /p:AndroidSigningStorePass="$KEY_STORE_PASSWORD" /p:OutputPath="/github/workspace/build/"
