# NixOS System Configuration

## Hosts

| Name | Description |
| ---- | ----------- |
| `deepthought` | NixOS partition of my laptop which I'm using for most things |

Once I finish with setting up my main system I'll add a configuration for a cyber security VM for doing CTFs and stuff like that. Might dabble in some nix-darwin at some point as well.

## Notes

### NixOS on Apple Silicon

If you're considering NixOS on Apple Silicon, overall it's been a great experience so far, would highly recommend it — [the Asahi team](https://github.com/AsahiLinux) and the people who've put together the [support for NixOS](https://github.com/tpwrules/nixos-apple-silicon) have done an incredible job. Follow the [instructions](https://github.com/tpwrules/nixos-apple-silicon/blob/main/docs/uefi-standalone.md) and you'll be fine.

At the time of writing there a couple of things that could be worth mentioning:

- The Asahi GPU drivers aren't enabled by default, so enable those with `hardware.asahi.useExperimentalGPUDriver = true;` (technically they're experimental but I've had no issues at all and it sounds like that's been the case for most people). This will mean that you have to build with the `--impure` flag, so something like `sudo nixos-rebuild switch --flake /etc/nixos --impure`.
- For whatever reason, I needed to make the Hyprland flake input follow the nixpkgs which has the overlay from the NixOS Apple Silicon Support module, otherwise it would crash saying something like `DRI driver not from this Mesa build (<some version> vs <a different version>)`. The Asahi GPU drivers use [their own Mesa implementation](https://gitlab.freedesktop.org/asahi/mesa) which is ahead of the latest version on nixpkgs unstable, which would explain the version mismatch, but my understanding was that Mesa includes DRI drivers, so it's beyond me.
