cask "topmind" do
  version "4.14.0"
  sha256 "54a71df87f0041d56b0fe7937228b48340f89ed7f71175df34170dab3586c103"

  url "https://github.com/topmindspace/topmind/releases/download/v#{version}/topmind-#{version}-mac-arm64.dmg"
  name "Topmind Desktop"
  desc "Local-first personal knowledge desktop workspace with stream and AI co-pilot"
  homepage "https://github.com/topmindspace/topmind"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true

  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-rd", "com.apple.quarantine", "{{appdir}}/topmind.app"],
        must_succeed: false
  end

  app "topmind.app"

  caveats <<~EOS
    If brew upgrade fails with "App source '/Applications/topmind.app' is not there",
    the previous app was moved or deleted. Recover with:
      brew uninstall --cask topmind --force
      brew install --cask topmind
    Or reinstall in place:
      brew reinstall --cask topmind
  EOS

  zap trash: [
    "~/topmind/topmind-desktop/logs",
    "~/Library/Application Support/topmind",
    "~/Library/Preferences/com.topmindspace.topmind.plist",
    "~/Library/Saved Application State/com.topmindspace.topmind.savedState",
  ]
end
