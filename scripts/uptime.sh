curl -f https://rorganize.it > /dev/null 2>&1 || echo "ALERT ALERT" | mailx -s 'Rorganize is down' roar@rorganize.it
