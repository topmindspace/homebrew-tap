cask "topmind" do
  arch arm: "arm64", intel: "x64"

  version "2.13.0"
  sha256 arm:   "4748ebd13fc1a4a6d5fb78b93d573a7dcfcd72bb44e6fb3aefe45db7bd3c7e02",
         intel: "4748ebd13fc1a4a6d5fb78b93d573a7dcfcd72bb44e6fb3aefe45db7bd3c7e02"

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
