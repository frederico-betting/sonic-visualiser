
Set-StrictMode -Version 2.0
$ErrorActionPreference = "Stop"

$version = (Get-Content build\version.h) -replace '#define SV_VERSION ','' -replace '"','' -replace '-pre.*',''
$wxs = "deploy\win32\sonic-visualiser.wxs"

$in = "$wxs.in"

echo "Generating $wxs..."
echo " ...for SV version $version"
echo " ...from $in"
echo ""

if (!(Test-Path -Path $in -PathType Leaf)) {
    echo "ERROR: Input file $in not found"
    exit 1
}

(Get-Content $in) -replace '@VERSION@', $version -replace '@W@', '<!-- DO NOT EDIT THIS FILE: it is auto-generated -->' | Out-File -encoding ASCII $wxs

echo "Done"
