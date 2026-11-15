# bits-wifi-login

Auto-login for the BITS Pilani Wi-Fi firewall portal (`fw.bits-pilani.ac.in:8090`).

The campus FortiGate firewall logs you out every few hours and makes you sign in
again through a browser page. This runs in the background, notices when that
happens, and signs you back in within about 15 seconds.

## Install

Needs Linux with NetworkManager, `curl` and systemd.

```sh
git clone https://github.com/Levixon10/bits-wifi-login
cd bits-wifi-login
./install.sh
bits-wifi-login setup   # enter your BITS username and password once
```

## How it works

- Every 15 seconds, while connected to a `BITS-*` network, it requests a small
  connectivity-check URL.
- If the firewall answers with its login redirect instead, the script fetches
  the login page and submits your credentials.
- Credentials live in `~/.config/bits-wifi-login/credentials` (mode 600) and are
  only ever sent to `fw.bits-pilani.ac.in:8090` over verified HTTPS.
- If the portal rejects the password, it waits 10 minutes before trying again,
  so a wrong password will not lock your account.

## Commands

| Command | What it does |
| --- | --- |
| `bits-wifi-login setup` | Save username and password |
| `bits-wifi-login once` | Check once and log in if needed |
| `bits-wifi-login logout` | End the current firewall session |
| `bits-wifi-login` | Run forever (what the service runs) |

Logs: `journalctl --user -u bits-wifi-login -f`

## Uninstall

```sh
systemctl --user disable --now bits-wifi-login.service
rm ~/.local/bin/bits-wifi-login ~/.config/systemd/user/bits-wifi-login.service
rm -r ~/.config/bits-wifi-login ~/.local/state/bits-wifi-login
```
