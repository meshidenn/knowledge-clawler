#!/bin/bash

# systemdやlaunchdから起動してもローカルのCLIを見つけやすくする。
export PATH="$HOME/.nix-profile/bin:$HOME/.nvm/versions/node/v22.22.2/bin:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.rye/shims:$HOME/.mise/shims:/opt/homebrew/bin:/usr/local/bin:$PATH"
