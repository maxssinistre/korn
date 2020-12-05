mount -t auto /dev/scd0 /mnt/scdrom/ ; find /mnt/scdrom/ -type f -exec mplayer -idx {} \; ; eject /mnt/scdrom/
