ansible -v -i hosts.yml -u pi -k -K cluster -m shell -a "sudo /sbin/shutdown -h now"
