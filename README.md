autounattend.xml

Overview
autounattend.xml is an answer file used during Windows installation to automate setup tasks. This file allows administrators to perform an unattended installation, pre-configuring settings, and bypassing manual input during setup.

Key Features
This configuration includes:

Automatic disk partitioning and formatting.
Pre-configuration of regional settings (fr-CA locale).
Automated software and feature installation.
System tweaks and customizations, including disabling unwanted apps and services.
Joining the system to a domain and running first logon scripts.
Configuration Details
1. General Information
Locale: fr-CA (French-Canadian)
Time Zone: Eastern Standard Time
Keyboard Layout: Canadian Multilingual Standard
2. Disk Partitioning
Uses GPT (GUID Partition Table) format.
Creates:
EFI system partition (300 MB, FAT32).
MSR (16 MB).
Primary partition for Windows (remaining space minus recovery).
Recovery partition (1 GB).
3. Pre-Installation Steps (Windows PE Pass)
Automates disk operations using diskpart.
Adds registry tweaks to bypass Windows hardware requirements checks (TPM, Secure Boot, RAM, etc.).
4. System Specialization
Installs and configures remote desktop settings.
Removes unwanted pre-installed apps and capabilities (e.g., Cortana, Microsoft Teams, Xbox apps, etc.).
Disables unnecessary features, startup sounds, and telemetry.
5. OOBE (Out-Of-Box Experience)
Hides EULA and wireless setup pages.
Configures auto-logon for the Administrator account with a temporary password.
6. First Logon Commands
Includes a series of scripts and commands:

Installs custom software and drivers.
Runs PowerShell scripts for domain joining and configuration.
Disables hibernation and configures power settings.
Automates additional setup tasks (e.g., RSAT tools installation, Windows Update).
Security Considerations
Passwords are stored in plain text for simplicity. Update this for production use to improve security.
Validate scripts and paths for custom tools to ensure they are current and correct.
Customization
Modify the following sections as needed:

Disk Configuration: Adjust partition sizes or layouts.
Regional Settings: Change UILanguage, InputLocale, SystemLocale, and UserLocale.
Applications and Features: Add or remove features, apps, or scripts in the RunSynchronous and FirstLogonCommands sections.
How to Use
Save autounattend.xml to the root of your installation media (USB or network share).
Boot the target machine using the installation media.
Windows Setup will automatically read this file and proceed with the unattended installation.
References
For detailed schema definitions and customization, visit the Microsoft Unattended Installation Documentation.
