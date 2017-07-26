#!/usr/bin/env bash

set -ex

function main() {
  local INSTALLER=/Applications/Install\ macOS\ Sierra.app/Contents/SharedSupport/InstallESD.dmg
  local ISO=${HOME}/Desktop/macos-sierra.iso
  
  if [[ ! -e ${INSTALLER} ]]; then
    echo "File doesn't exist (${INSTALLER})"
  fi

  /usr/bin/osascript -e 'display notification "Start building MacOS ISO file ..." with title "Create ISO File"' && \
  hdiutil attach ${INSTALLER} -noverify -nobrowse -mountpoint /Volumes/install_app && \
  hdiutil create -o /tmp/macos.cdr -size 7316m -layout SPUD -fs HFS+J && \
  hdiutil attach /tmp/macos.cdr.dmg -noverify -nobrowse -mountpoint /Volumes/install_build && \
  asr restore -source /Volumes/install_app/BaseSystem.dmg -target /Volumes/install_build -noprompt -noverify -erase && \
  rm -f /Volumes/OS\ X\ Base\ System/System/Installation/Packages && \
  cp -rp /Volumes/install_app/Packages /Volumes/OS\ X\ Base\ System/System/Installation/ && \
  cp -rp /Volumes/install_app/BaseSystem.chunklist /Volumes/OS\ X\ Base\ System/BaseSystem.chunklist && \
  cp -rp /Volumes/install_app/BaseSystem.dmg /Volumes/OS\ X\ Base\ System/BaseSystem.dmg && \
  hdiutil detach /Volumes/install_app && \
  hdiutil detach /Volumes/OS\ X\ Base\ System/ && \
  hdiutil convert /tmp/macos.cdr.dmg -format UDTO -o /tmp/macos.iso && \
  mv /tmp/macos.iso.cdr ${ISO} && \
  rm -f /tmp/macos.cdr.dmg && \
  /usr/bin/osascript -e 'display notification "All done!" with title "Successfully build ISO"'
}

main

