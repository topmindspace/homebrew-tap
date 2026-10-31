cask "topmind" do
  version "4.19.2"
  sha256 "e944fea9b077137d4eb761689db32a12579c5a1bb34b63a895ff80127d9f6c29"

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
