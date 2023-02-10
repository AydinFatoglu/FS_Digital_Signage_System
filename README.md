# FS Digital Signage

Minimal Digital Signage System work with on a file server (samba share)!

# How It Works

- It pulls image or video content from predefined file server (network share)
- It plays pulled content locally with predefined durations (images) / Videos will play till the end.
- It controls software and content updates in every layout cicyle (changes only) So your file server or client not burns :)


 # Usage Example

[space] [Server FQDN or SHARE NAME] [space] [Layout]

# Parameters

<b>Set in ini file<b>

- ServerRootDir: File Server's root media directory
- LocalDir: Client local directory all content pull to 
- ImageDuration: Default image duration (sec)
- Splash: Default background image on client
- ServerLayoutDirName: Server folder that contains images/videos
