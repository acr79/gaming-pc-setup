# Gaming PC Bootstrap Script
# Run from an elevated PowerShell prompt:
#   Set-ExecutionPolicy Bypass -Scope Process -Force
#   .\setup.ps1

param(
    [switch]$SkipChrome,
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"

function Write-Step($msg) { Write-Host "`n==> $msg" -ForegroundColor Cyan }
function Write-Ok($msg)   { Write-Host "    OK: $msg" -ForegroundColor Green }
function Write-Warn($msg) { Write-Host "    WARN: $msg" -ForegroundColor Yellow }

# --- 1. Ensure winget is available ---
Write-Step "Checking winget"
try {
    $wgVer = winget --version
    Write-Ok "winget $wgVer"
} catch {
    Write-Warn "winget not found. Install App Installer from the Microsoft Store, then re-run."
    exit 1
}

# --- 2. Install all packages from the bundle ---
Write-Step "Installing gaming packages"
$bundle = Join-Path $PSScriptRoot "winget-gaming.json"
if ($DryRun) {
    Write-Warn "DryRun: would run: winget import -i $bundle"
} else {
    winget import -i $bundle --accept-package-agreements --accept-source-agreements
}
Write-Ok "Package install complete"

# --- 3. Xbox app ships with Windows 11 ---
Write-Step "Xbox App"
Write-Ok "Xbox / Game Pass app ships built-in with Windows 11 (no install needed)"

# --- 3b. npm-based CLIs (require Node.js from winget step above) ---
Write-Step "Installing npm-based CLIs"
$npmTools = @(
    @{ Name = "Gemini CLI"; Package = "@google/gemini-cli" }
)
foreach ($tool in $npmTools) {
    Write-Host "  Installing $($tool.Name)..."
    if ($DryRun) {
        Write-Warn "DryRun: would run: npm install -g $($tool.Package)"
    } else {
        npm install -g $tool.Package
    }
}
Write-Ok "npm CLI tools installed"

# --- 3c. NVIDIA App (manual download required) ---
Write-Step "NVIDIA App"
Write-Warn "NVIDIA App is not in winget — download it from nvidia.com/en-us/software/nvidia-app/"
Write-Warn "It replaces GeForce Experience for driver updates and overlay features."

# --- 3d. Cheat Happens Aurora (manual download required) ---
Write-Step "Cheat Happens Aurora"
Write-Warn "Aurora is not in winget — download it from cheathappens.com/aurora (account required)."
Write-Warn "Aurora manages and launches game trainers for single-player titles."

# --- 4. Set Chrome as default browser ---
Write-Step "Chrome default browser"
Write-Warn "Windows 11 requires you to set the default browser manually:"
Write-Warn "  Settings > Apps > Default Apps > search 'Google Chrome' > Set as default"
Write-Warn "Opening Settings now..."
if (-not $DryRun) {
    Start-Process "ms-settings:defaultapps"
}

# --- 5. Windows Gaming tweaks (optional) ---
Write-Step "Optional gaming tweaks"
Write-Ok "Game Mode is on by default in Windows 11"
Write-Warn "Consider: Hardware-Accelerated GPU Scheduling (HAGS) in Display > Graphics settings"
Write-Warn "Consider: Enabling XMP/EXPO in BIOS for RAM performance"

Write-Host "`n==> Setup complete! Sign into Steam, Epic, Battle.net, and Xbox to restore libraries.`n" -ForegroundColor Green
