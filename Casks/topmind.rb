cask "topmind" do
  arch arm: "arm64", intel: "x64"

  version "3.5.0"
  sha256 arm:   "4bd24b261b46e8d38994bf57adb65c1348f303398fb5a011139f9794cc85adc1",
         intel: "4bd24b261b46e8d38994bf57adb65c1348f303398fb5a011139f9794cc85adc1"

  url "https://github.com/topmindspace/topmind/releases/download/v#{version}/topmind-#{version}-mac-#{arch}.dmg"
  name "Topmind Desktop"
  desc "Local-first personal knowledge desktop workspace with stream and AI co-pilot"
  homepage "https://github.com/topmindspace/topmind"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true

  # Remove quarantine attribute automatically on install to solve macOS "damaged" gatekeeper error
  postflight do
    system_command "xattr",
         args: ["-rd", "com.apple.quarantine", "#{appdir}/Topmind.app"],
         sudo: false
  end

  app "Topmind.app"

  zap trash: [
    "~/topmind/topmind-desktop/logs",
    "~/Library/Application Support/topmind",
    "~/Library/Preferences/com.topmindspace.topmind.plist",
    "~/Library/Saved Application State/com.topmindspace.topmind.savedState",
  ]
end
