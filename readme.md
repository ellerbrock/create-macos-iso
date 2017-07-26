![create-macos-iso](https://github.frapsoft.com/top/open-source-v1.png)

# create-macos-iso

[![Open Source Love](https://badges.frapsoft.com/os/v1/open-source.svg)](https://github.com/ellerbrock/open-source-badges/) [![Gitter Chat](https://badges.gitter.im/frapsoft/frapsoft.svg)](https://gitter.im/frapsoft/frapsoft/) [![MIT Licence](https://badges.frapsoft.com/os/mit/mit.svg?v=103)](https://opensource.org/licenses/mit-license.php)

## How to use

- Download [MacOS Sierra](https://itunes.apple.com/de/app/macos-sierra/id1127487414?mt=12)
- Execute `curl https://github.com/ellerbrock/create-macos-iso/blob/master/create-macos-iso.sh | bash`
- when all went well you should have a `macos.iso` on your Desktop

Thats it :)


## Source 

`create-macos-iso.sh`

```bash
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
```

## Contact

[![Github](https://github.frapsoft.com/social/github.png)](https://github.com/ellerbrock/)[![Docker](https://github.frapsoft.com/social/docker.png)](https://hub.docker.com/u/ellerbrock/)[![npm](https://github.frapsoft.com/social/npm.png)](https://www.npmjs.com/~ellerbrock)[![Twitter](https://github.frapsoft.com/social/twitter.png)](https://twitter.com/frapsoft/)[![Facebook](https://github.frapsoft.com/social/facebook.png)](https://www.facebook.com/frapsoft/)[![Google+](https://github.frapsoft.com/social/google-plus.png)](https://plus.google.com/116540931335841862774)[![Gitter](https://github.frapsoft.com/social/gitter.png)](https://gitter.im/frapsoft/frapsoft/)

## License 

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a> [![MIT license](https://badges.frapsoft.com/os/mit/mit-125x28.png?v=103)](https://opensource.org/licenses/mit-license.php)

This work by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/ellerbrock" property="cc:attributionName" rel="cc:attributionURL">Maik Ellerbrock</a> is licensed under a <a rel="license" href="https://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a> and the underlying source code is licensed under the <a rel="license" href="https://opensource.org/licenses/mit-license.php">MIT license</a>.
