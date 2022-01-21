# Xamarin.Android Signed Build GitHub Container Action

Creates signed `apk` files for Xamarin.Android projects using GitHub Container Actions.

## Usage

Example usage in a worfklow:

```yaml
name: Build

on: workflow_dispatch

jobs:
  Android:
    name: Android
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: rheuvel89/xamarin-container-action@v2
        with:
          SolutionPath: src/sample.Android/sample.Android.csproj
          ProjectPath: src/sample.sln
          SigningKeyStore: ${{ secrets.KEYSTORE }}
          SigningKeystorePassword: ${{ secrets.KEYSTORE_PASS }}
          SigningKeyAlias: ${{ secrets.KEY_ALIAS }}
          SigningKeyPassword: ${{ secrets.KEY_PASS }}
          BuildConfiguration: "Release"
      - uses: actions/upload-artifact@v2
        with:
          name: release
          path: build/**Signed.apk
```

## Inputs

| input                   | value                                                                           | required? |
| ----------------------- | ------------------------------------------------------------------------------- | --------- |
| SolutionPath            | Path to csproj file                                                             | Y         |
| ProjectPath             | Path to csproj file                                                             | Y         |
| SigningKeyStore         | Base64 representation of the keystore                                           | Y         |
| SigningKeystorePassword | Keystore password                                                               | Y         |
| SigningKeyAlias         | Signing key alias                                                               | Y         |
| SigningKeyPassword      | Signing key password                                                            | Y         |
| BuildConfiguration      | Build configuration                                                             | Y         |

## FAQ

**How to create base64 of the keystore file?**

`base64 keys.keystore > keystore.txt`

The contents of the text file is the keystore file in base64 format, which you can store as a GitHub Secret.
