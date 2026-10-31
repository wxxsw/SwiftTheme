#!/bin/bash
set -euo pipefail

# Run against an already booted iOS 15+ simulator. Requires Xcode and Python 3.
device="${1:-booted}"
repo_root="$(cd "$(dirname "$0")/.." && pwd)"
build_dir="$(mktemp -d "${TMPDIR:-/tmp}/SwiftThemeTests.XXXXXX")"
trap 'rm -rf "$build_dir"' EXIT
app="$build_dir/SwiftThemeTests.app"
mkdir -p "$app"
sdk_path="$(xcrun --sdk iphonesimulator --show-sdk-path)"
arch="$(uname -m)"
xcrun swiftc -swift-version 5 -sdk "$sdk_path" \
    -target "$arch-apple-ios15.0-simulator" \
    "$repo_root"/Sources/*.swift "$repo_root/Tests/RegressionApp/main.swift" \
    -o "$app/SwiftThemeTests"
python3 - "$app/Info.plist" <<'PY'
import plistlib, sys
with open(sys.argv[1], 'wb') as f:
    plistlib.dump({
        'CFBundleIdentifier': 'org.swifttheme.RegressionTests',
        'CFBundleExecutable': 'SwiftThemeTests',
        'CFBundleName': 'SwiftThemeTests',
        'CFBundleVersion': '1',
        'CFBundleShortVersionString': '1.0',
        'CFBundlePackageType': 'APPL',
        'LSRequiresIPhoneOS': True,
        'MinimumOSVersion': '15.0',
        'UIDeviceFamily': [1, 2],
        'UILaunchScreen': {},
        'UISupportedInterfaceOrientations': ['UIInterfaceOrientationPortrait'],
    }, f)
PY
codesign --force --sign - "$app"
xcrun simctl terminate "$device" org.swifttheme.RegressionTests >/dev/null 2>&1 || true
xcrun simctl install "$device" "$app"
container="$(xcrun simctl get_app_container "$device" org.swifttheme.RegressionTests data)"
rm -f "$container/Documents/result.txt"
xcrun simctl launch "$device" org.swifttheme.RegressionTests
for ((attempt = 0; attempt < 60; attempt++)); do
    if [ -f "$container/Documents/result.txt" ]; then
        cat "$container/Documents/result.txt"
        echo
        if grep -q '^FAIL ' "$container/Documents/result.txt"; then
            exit 1
        fi
        exit 0
    fi
    sleep 1
done
echo 'FAIL: regression app did not report a result within 60 seconds.' >&2
exit 1
