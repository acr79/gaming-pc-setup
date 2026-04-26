# Gaming PC Baseline

Baseline config to rebuild this gaming machine from scratch on a clean Windows 11 install.

## Machine Specs (baseline hardware)

| Component | Details |
|-----------|---------|
| Motherboard | Gigabyte X870I AORUS PRO ICE (Mini-ITX, AM5) |
| CPU | AMD Ryzen 9000 series (Zen 5 / Granite Ridge) |
| RAM | 32 GB |
| Storage | 3.8 TB |
| GPU | NVIDIA (driver 576.88) |
| WiFi | Realtek Wi-Fi 7 |
| OS | Windows 11 Pro, Build 26100 |
| BIOS | AMI FA2 (3/12/2025) |

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
| Cheat Happens Aurora | Game trainer manager | manual (cheathappens.com) |

## Bootstrap — fresh Windows 11 install

### Step 1 — Clone this repo

```powershell
git clone https://github.com/acr79/gaming-pc-setup.git
cd gaming-pc-setup
```

### Step 2 — Run the setup script

Open **PowerShell as Administrator**:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
.\setup.ps1
```

The script installs all apps via winget, installs Gemini CLI via npm, and opens the default-browser Settings page.

### Step 3 — Set Chrome as default browser

Windows 11 blocks programmatic default-browser changes. After the script opens Settings:

`Settings > Apps > Default Apps > Google Chrome > Set as default`

### Step 4 — Sign into launchers

- Steam
- Epic Games
- Battle.net
- Xbox app

### Step 5 — NVIDIA App

Not available in winget. Download and install manually from nvidia.com, then sign in to enable driver auto-updates and the in-game overlay.

### Step 6 — Cheat Happens Aurora

Not available in winget. Download and install from cheathappens.com/aurora (requires a Cheat Happens account). Aurora manages and launches game trainers for single-player titles.

### Step 7 — Optional gaming tweaks

| Tweak | Where |
|-------|-------|
| XMP/EXPO (full RAM speed) | BIOS |
| HAGS (GPU scheduling) | Settings > System > Display > Graphics > Change default graphics settings |
| Game Mode | On by default in Windows 11 |
| Xbox Game Bar overlay | Win + G |

## Files

| File | Purpose |
|------|---------|
| `setup.ps1` | One-command bootstrap script |
| `winget-gaming.json` | Winget package bundle (gaming + core apps only) |
| `winget-packages.json` | Full winget snapshot of this machine at baseline |

## Updating the snapshot

After installing new apps you want to track:

```powershell
winget export -o winget-packages.json --accept-source-agreements
git add winget-packages.json
git commit -m "update winget snapshot"
git push
```
