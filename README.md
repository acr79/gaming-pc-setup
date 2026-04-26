# Gaming PC Baseline

Baseline config to rebuild this gaming machine from scratch on a clean Windows 11 install.

## What gets installed

| App | Purpose | Install method |
|-----|---------|----------------|
| Google Chrome | Default browser | winget |
| Steam | Valve game library | winget |
| Epic Games Launcher | Epic game library | winget |
| Battle.net | Blizzard game library | winget |
| Xbox / Game Pass | Microsoft games | built into Win 11 |
| Windows Terminal | Better terminal | winget |
| GitHub CLI | Repo management | winget |
| Node.js | Runtime for npm CLIs | winget |
| Claude (Anthropic) | AI assistant | winget |
| OpenAI Codex CLI | AI coding CLI | winget |
| Google Gemini CLI | AI coding CLI | npm |
| NVIDIA App | Driver updates + overlay | manual (nvidia.com) |

## Bootstrap — fresh Windows 11 install

### Step 1 — Run the setup script

Open **PowerShell as Administrator** and run:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
cd C:\path\to\gaming-pc-setup   # or wherever you cloned this repo
.\setup.ps1
```

The script will:
- Install all apps via winget
- Open the default-browser settings page (set Chrome manually — Windows 11 requires a click)

### Step 2 — Set Chrome as default browser

Windows 11 blocks programmatic default-browser changes. After the script opens Settings:

`Settings > Apps > Default Apps > Google Chrome > Set as default`

### Step 3 — Sign into launchers

Sign in to each launcher to restore your libraries:
- Steam
- Epic Games
- Battle.net
- Xbox app

### Step 4 — Optional gaming tweaks

- **HAGS** (Hardware-Accelerated GPU Scheduling): `Settings > System > Display > Graphics > Change default graphics settings`
- **XMP/EXPO**: Enable in BIOS for full RAM speed
- **Game Mode**: Already on by default in Windows 11

## Files

| File | Purpose |
|------|---------|
| `setup.ps1` | One-command bootstrap script |
| `winget-gaming.json` | Winget package bundle (gaming + core apps) |
| `winget-packages.json` | Full winget export snapshot of this machine |

## Updating the package list

After installing new apps you want to track:

```powershell
winget export -o winget-packages.json --accept-source-agreements
```

Then commit and push.
