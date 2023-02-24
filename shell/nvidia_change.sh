#/usr/bin/bash
if [[ $1 == "n" ]]
then
	sudo systemctl disable bumblebeed
	echo  | yaourt -Rnsc bumblebee
	echo "Bumblebee was removed"
	sudo cp /etc/X11/xorg.conf.bak /etc/X11/xorg.conf
	echo "xorg.conf was created"
	sudo cp /home/orange/Software/desktop/nvidia-settings-nvidia.desktop /usr/share/applications/nvidia-settings.desktop
	echo "desktop file created"
	sudo sed -i 's/^VDPAU_DRIVER=va_gl/VDPAU_DRIVER=nvidia/' /etc/environment	
	echo "environment VDPAU_DRIVER now is nvidia"
	#sed -i 's/^#hw=vdpau/hw=vdpau/' /home/orange/.config/mpv/mpv.conf
	#sed -i 's/^#profile=gpu-hq/profile=gpu-hq/' /home/orange/.config/mpv/mpv.conf
	#sed -i 's/^#gpu-api=vulkan/gpu-api=vulkan/' /home/orange/.config/mpv/mpv.conf
	#sed -i 's/^#vo=vdpau/vo=vdpau/' /home/orange/.config/mpv/mpv.conf
	#echo "mpv.conf now is nvidia"
	#sed -i 's/dual_screen_bumblebeei\.sh$/dual_screen_nvidia\.sh' /home/orange/.config/i3/config
	#echo "dual screen now is nvidia"
	#sed -i 's/HDMI1/HDMI-1/' /home/orange/.config/i3/config 
	#sed -i 's/eDP1/eDP-1/' /home/orange/.config/i3/config 
	#sed -i 's/eDP1/eDP-1/' /home/orange/.config/i3/config 
	#echo "i3 config now is HDMI-1-1 & eDP-1-1"

elif [[ $1 == "b" ]]
then 
	echo | yaourt -S bumblebee primus lib32-primus
	echo "Bumblebee & primus was installed"
	sudo systemctl enable bumblebeed
	echo "Bumblebee.service was enabled"
	sudo rm /etc/X11/xorg.conf
	echo "xorg.conf was deleted"
	sudo cp /home/orange/Software/desktop/nvidia-settings-bumblebee.desktop /usr/share/applications/nvidia-settings.desktop
	echo "desktop file created"
	sudo sed -i 's/^VDPAU_DRIVER=nvidia/VDPAU_DRIVER=va_gl/g' /etc/environment	
	echo "environment VDPAU_DRIVER now is va_gl"
	#sed -i 's/^hw=vdpau/#hw=vdpau/' /home/orange/.config/mpv/mpv.conf
	#sed -i 's/^profile=gpu-hq/#profile=gpu-hq/' /home/orange/.config/mpv/mpv.conf
	#sed -i 's/^gpu-api=vulkan/#gpu-api=vulkan/' /home/orange/.config/mpv/mpv.conf 
	#sed -i 's/^vo=vdpau/#vo=vdpau/' /home/orange/.config/mpv/mpv.conf
	#echo "mpv.conf now is #"
	#sed -i 's/dual_screen_nvidia\.sh$/dual_screen_bumblebee\.sh' /home/orange/.config/i3/config
	#echo "dual screen now is bumblebe
	sed -i 's/HDMI-1-1/HDMI1/' /home/orange/.config/i3/config 
	sed -i 's/eDP-1-1/eDP1/' /home/orange/.config/i3/config 
	echo "i3 config now is HDMI1 & eDP1"
fi
