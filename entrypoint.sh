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

dotnet publish -c "$CONFIGURATION" "$CSPROJ_PATH" --output "/github/workspace/build/" -p:DebugSymbols=false -p:AndroidKeyStore=true -p:AndroidSigningKeyAlias="$ALIAS" /p:AndroidSigningKeyPass="$SIGNING_KEY_PASS" -p:AndroidSigningKeyStore="/github/workspace/android.keystore" -p:AndroidSigningStorePass="$KEY_STORE_PASSWORD"
