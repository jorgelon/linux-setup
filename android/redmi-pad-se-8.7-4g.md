# Redmi Pad SE 8.7 4G: unlock and install a Google GSI

Goal: replace the stock HyperOS with a Google Generic System Image (GSI)

https://developer.android.com/topic/generic-system-image/releases

## Device

Values read with `adb shell getprop`

| Property | Value |
|---|---|
| Market name | Redmi Pad SE 8.7 4G |
| Model | 24076RP19G |
| Codename | **spark** (product `spark_eea`) |
| SoC | MediaTek Helio G85 (MT6769) |
| Stock OS | HyperOS 3, `OS3.0.303.0.WHYEUXM` (EEA), Android 16 |
| Vendor | Android 15, `ro.board.api_level` 30 |
| Treble | `ro.treble.enabled = true` |
| CPU ABI | arm64-v8a |
| Partitions | dynamic (`super`), A/B, Virtual A/B |

Note: this is **not** the Wi-Fi model `flare` (24075RP89G) used in the XDA guide.
Always use **spark** builds (stock ROM, boot images, etc.)

https://xdaforums.com/t/guide-xiaomi-redmi-pad-se-8-7-codename-flare-24075rp89g-how-to-unlock-root-and-replace-the-stock-os.4724393/

## Linux tools

```shell
sudo pacman -S android-tools
adb devices -l
```

## 1. Prepare the tablet

- Settings > About > tap OS version several times to enable Developer options
- Developer options: enable `OEM unlocking`, `USB debugging` and `USB debugging (Security settings)`
- Log in with a Xiaomi account registered outside mainland China (should be ~30 days old)
- Insert an active SIM card with mobile data. The 4G model refuses to bind the account without it
- Turn Wi-Fi off and use mobile data for the binding step

## 2. Request the unlock (official way)

- Install the **Xiaomi Community** app on the tablet (Google Play / GetApps), version 5.3.31+
- Set region to Global, log in, Me > **Unlock bootloader** > Apply
- If the quota is reached, retry the next day (resets at midnight Beijing time)
- Once approved: Settings > Developer options > **Mi Unlock status** > Add account and device
- Wait the timer (72-168 hours). Keep the SIM inserted, stay logged in, keep Find Device enabled

### The HyperOS bypass script (did not work)

The NekoYuzu "Xiaomi HyperOS BootLoader Bypass" (`bypass.sh`) from the XDA guide is from the
HyperOS 1 era and is probably patched on HyperOS 3. Problems found running it on Linux:

- `libraries/adb` is not executable after unzipping: `chmod +x libraries/adb`
- `adb.php` parses `adb devices -l` by column position and breaks with the `usb:` field of newer adb
  (`adb: invalid transport id`). Needed a patch to parse the fields by name
- The openssl / `session.sid_*` warnings come from the bundled Windows `php.ini` and are harmless
- It requires the SIM card as well

## 3. Unlock the bootloader

When the timer ends:

```shell
adb reboot bootloader
fastboot devices
```

The official Mi Unlock tool is Windows only. Options:

- Open source clone that works on Linux: https://github.com/offici4l/MiUnlockTool (only works after the official approval and timer)
- A Windows VM with USB passthrough (the device reconnects in fastboot, re-attach it)
- Any Windows PC

Unlocking **wipes all the data**.

Alternative (risky, may not work on HyperOS 3): https://github.com/bkerler/mtkclient
using the MediaTek BROM mode. Back up all partitions first.

## 4. Before flashing

- Download the **stock spark fastboot ROM** for the current build to be able to go back
- Download the **ARM64** GSI (AOSP or +GMS) from the Google GSI releases page
- Get a `vbmeta.img` (from the GSI page or from the stock ROM)

## 5. Flash the GSI

```shell
adb reboot bootloader
fastboot --disable-verity --disable-verification flash vbmeta vbmeta.img
fastboot reboot fastboot                       # fastbootd, needed for dynamic partitions
fastboot delete-logical-partition product_a    # frees space in super if needed
fastboot flash system system.img
fastboot -w                                    # wipe data, required
fastboot reboot
```

## Expected problems

- Google GSIs are aimed at app developers. On MediaTek Xiaomi devices things like brightness,
  camera, Bluetooth audio, fingerprint or mobile data / VoLTE may not work
- The vendor is frozen at API 30. If the latest GSI (Android 16) bootloops, try Android 15 or 14
- Better hardware support: TrebleDroid based GSIs (phhusson AOSP, AndyYan LineageOS GSI)
- With an unlocked bootloader Play Integrity fails, some banking / wallet apps will not work
