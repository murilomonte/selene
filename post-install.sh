#!/bin/bash
set -e

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install -y flathub io.github.kolunmi.Bazaar org.mozilla.firefox

touch /var/lib/.post-install-done
