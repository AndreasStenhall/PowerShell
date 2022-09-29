This script  creates a Scheduled Task that triggers on Event ID 102 from the SmartCard-DeviceEnum/Operational log, the removal/unplugging of a FIDO2 security device.

Note: This works even if the PIV functionality has been disabled on the Yubikey.

Tested and validated with the following security keys:

* Yubikey 5C (USB-C)
* Yubikey 5 NFC (USB-A)

Also validated with

* Yubikey 4 (USB-A) Note: This is not a FIDO2 device. 

