# My Hyprland Dotfiles
  Don't Touch My dot files 🙂
 

## Screenshots
<img width="1920" height="1080" alt="Screenshot_20251013_032210" src="https://github.com/user-attachments/assets/4bb13550-62e4-441a-b04a-523b67eb7814" />
<img width="1920" height="1080" alt="Screenshot_20251013_032442" src="https://github.com/user-attachments/assets/22134d63-51c4-428f-85a9-8e41c661af20" />

## Install ( I use cachy os repo and chaotic-aur repo BTW keep that in mind )
``` ./install-packages dependencies-list ```

# Then simply links the folders by filemager
 
## Changelog Mon Oct 13 03:25:32 AM IST 2025
```
 Configs/KDE/UserFeedback.conf                      |    2 -
 .../KDE/UserFeedback.org.kde.plasma-welcome.conf   |    2 -
 Configs/cava/Wall-Dcol                             |   13 -
 Configs/cava/config                                |   57 -
 Configs/cava/shaders/bar_spectrum.frag             |   79 -
 Configs/cava/shaders/northern_lights.frag          |   34 -
 Configs/cava/shaders/pass_through.vert             |   14 -
 Configs/cava/shaders/spectrogram.frag              |   53 -
 .../cava/shaders/winamp_line_style_spectrum.frag   |  112 -
 Configs/dconf/user                                 |  Bin 3320 -> 0 bytes
 Configs/xyz.chatboxapp.app/.updaterId              |    1 -
 .../Cache/Cache_Data/1676204418d3558b_0            |  Bin 457274 -> 0 bytes
 .../Cache/Cache_Data/1abd0b7f765f1690_0            |  Bin 5726 -> 0 bytes
 .../Cache/Cache_Data/5283edf90cf4ab50_0            |  Bin 5598 -> 0 bytes
 .../Cache/Cache_Data/eebc7986df07ff61_0            |  Bin 143228 -> 0 bytes
 Configs/xyz.chatboxapp.app/Cache/Cache_Data/index  |  Bin 24 -> 0 bytes
 .../Cache/Cache_Data/index-dir/the-real-index      |  Bin 144 -> 0 bytes
 Configs/xyz.chatboxapp.app/Code Cache/js/index     |  Bin 24 -> 0 bytes
 .../Code Cache/js/index-dir/the-real-index         |  Bin 48 -> 0 bytes
 Configs/xyz.chatboxapp.app/Code Cache/wasm/index   |  Bin 24 -> 0 bytes
 .../Code Cache/wasm/index-dir/the-real-index       |  Bin 48 -> 0 bytes
 Configs/xyz.chatboxapp.app/Cookies                 |  Bin 20480 -> 0 bytes
 Configs/xyz.chatboxapp.app/Cookies-journal         |    0
 Configs/xyz.chatboxapp.app/Crashpad/client_id      |    1 -
 Configs/xyz.chatboxapp.app/DawnCache/data_0        |  Bin 8192 -> 0 bytes
 Configs/xyz.chatboxapp.app/DawnCache/data_1        |  Bin 270336 -> 0 bytes
 Configs/xyz.chatboxapp.app/DawnCache/data_2        |  Bin 8192 -> 0 bytes
 Configs/xyz.chatboxapp.app/DawnCache/data_3        |  Bin 8192 -> 0 bytes
 Configs/xyz.chatboxapp.app/DawnCache/index         |  Bin 262512 -> 0 bytes
 .../Dictionaries/en-US-10-1.bdic                   |  Bin 451968 -> 0 bytes
 Configs/xyz.chatboxapp.app/GPUCache/data_0         |  Bin 45056 -> 0 bytes
 Configs/xyz.chatboxapp.app/GPUCache/data_1         |  Bin 270336 -> 0 bytes
 Configs/xyz.chatboxapp.app/GPUCache/data_2         |  Bin 1056768 -> 0 bytes
 Configs/xyz.chatboxapp.app/GPUCache/data_3         |  Bin 4202496 -> 0 bytes
 Configs/xyz.chatboxapp.app/GPUCache/index          |  Bin 262512 -> 0 bytes
 .../IndexedDB/file__0.indexeddb.leveldb/000003.log |  Bin 1816 -> 0 bytes
 .../IndexedDB/file__0.indexeddb.leveldb/CURRENT    |    1 -
 .../IndexedDB/file__0.indexeddb.leveldb/LOCK       |    0
 .../IndexedDB/file__0.indexeddb.leveldb/LOG        |    2 -
 .../file__0.indexeddb.leveldb/MANIFEST-000001      |  Bin 23 -> 0 bytes
 .../Local Storage/leveldb/000003.log               |  Bin 73 -> 0 bytes
 .../Local Storage/leveldb/CURRENT                  |    1 -
 .../xyz.chatboxapp.app/Local Storage/leveldb/LOCK  |    0
 .../xyz.chatboxapp.app/Local Storage/leveldb/LOG   |    2 -
 .../Local Storage/leveldb/MANIFEST-000001          |  Bin 41 -> 0 bytes
 .../xyz.chatboxapp.app/Network Persistent State    |    1 -
 Configs/xyz.chatboxapp.app/Preferences             |    1 -
 .../xyz.chatboxapp.app/Session Storage/000003.log  |  Bin 540 -> 0 bytes
 Configs/xyz.chatboxapp.app/Session Storage/CURRENT |    1 -
 Configs/xyz.chatboxapp.app/Session Storage/LOCK    |    0
 Configs/xyz.chatboxapp.app/Session Storage/LOG     |    2 -
 .../Session Storage/MANIFEST-000001                |  Bin 41 -> 0 bytes
 Configs/xyz.chatboxapp.app/TransportSecurity       |    1 -
 Configs/xyz.chatboxapp.app/WebStorage/QuotaManager |  Bin 40960 -> 0 bytes
 .../WebStorage/QuotaManager-journal                |    0
 Configs/xyz.chatboxapp.app/config.json             |   71 -
 Configs/xyz.chatboxapp.app/databases/Databases.db  |  Bin 28672 -> 0 bytes
 .../databases/Databases.db-journal                 |    0
 Configs/xyz.chatboxapp.app/databases/chatbox_kb.db |  Bin 16384 -> 0 bytes
 Configs/xyz.chatboxapp.app/logs/main.log           |   19 -
 Local/bin/cvim                                     |    7 -
 Local/bin/upload                                   |  139 -
 Local/bin/upload-go                                |   27 -
 Local/bin/waydroid.sh                              |    5 -
 Local/bin/waydroid_padding.sh                      |    3 -
 Local/bin/waydroid_size.sh                         |    7 -
 README.md                                          |   77 +-
 current-packages-dump.txt                          |  445 +--
 info.txt                                           |   15 +-
 packages-with-info.txt                             | 3120 ++++++++------------
 70 files changed, 1296 insertions(+), 3019 deletions(-)
```
 
