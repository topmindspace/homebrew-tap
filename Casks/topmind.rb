cask "topmind" do
  arch arm: "arm64", intel: "x64"

  version "4.3.0"
  sha256 arm:   "6bee783d399bd6d6f587682c934f0482b59fadf9e8a1984bcb818799740e430c",
         intel: "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"

  url "https://github.com/topmindspace/topmind/releases/download/v#{version}/topmind-#{version}-mac-#{arch}.dmg"
  name "Topmind Desktop"
  desc "Local-first personal knowledge desktop workspace with stream and AI co-pilot"
  homepage "https://github.com/topmindspace/topmind"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true

  # Remove quarantine attribute automatically on install to solve macOS "damaged" gatekeeper error.
  # Homebrew requires postflight_steps (legacy postflight is deprecated).
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-rd", "com.apple.quarantine", "{{appdir}}/topmind.app"],
        must_succeed: false
  end

  app "topmind.app"

  # Recovery hint when /Applications/topmind.app was moved/deleted and brew
  # upgrade can no longer find the previous install target.
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
