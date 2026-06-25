#!/bin/bash
set -e

flatpak remote-delete fedora 2>/dev/null || true
sleep 2
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sleep 2
flatpak install -y flathub \
be.alexandervanhee.gradia \
ca.desrt.dconf-editor \
com.github.finefindus.eyedropper \
com.github.tchx84.Flatseal \
com.obsproject.Studio \
com.spotify.Client \
fr.handbrake.ghb \
io.github.flattool.Ignition \
io.github.flattool.Warehouse \
io.missioncenter.MissionCenter \
org.gimp.GIMP \
org.gnome.Calculator \
org.gnome.Loupe \
org.gnome.font-viewer \
org.mozilla.firefox \
org.telegram.desktop \
org.videolan.VLC \
com.valvesoftware.Steam \
io.github.kolunmi.Bazaar \
io.github.diegopvlk.Cine \
org.gnome.TextEditor \
com.ranfdev.DistroShelf

touch /var/lib/.post-install-done
