These files are used to trigger hourly "autobuild" of the circleci job.

I have a host on Digital Ocean that runs Container Linux.

```
# Put the script in place.
sudo mkdir /opt/sbin
sudo cp trigger /opt/sbin/

# Put the systemd units in place.
sudo cp trigger.* /etc/systemd/system/

# Start/enable the timer unit.
sudo enable trigger.timer
sudo start trigger.timer
```

This is based on instructions at
https://circleci.com/docs/1.0/nightly-builds/
