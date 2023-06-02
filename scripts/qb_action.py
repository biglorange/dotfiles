import qbittorrentapi

# instantiate a Client using the appropriate WebUI configuration
conn_info = dict(
    host="192.168.123.5",
    port=8080,
)
qbt_client = qbittorrentapi.Client(**conn_info)

# the Client will automatically acquire/maintain a logged-in state
# in line with any request. therefore, this is not strictly necessary;
# however, you may want to test the provided login credentials.
# try:
#     qbt_client.auth_log_in()
# except qbittorrentapi.LoginFailed as e:
#     print(e)

# if the Client will not be long-lived or many Clients may be created
# in a relatively short amount of time, be sure to log out:
# qbt_client.auth_log_out()

# or use a context manager:
# with qbittorrentapi.Client(**conn_info) as qbt_client:
#     if qbt_client.torrents_add(urls="...") != "Ok.":
#         raise Exception("Failed to add torrent.")

# display qBittorrent info
# print(f"qBittorrent: {qbt_client.app.version}")
# print(f"qBittorrent Web API: {qbt_client.app.web_api_version}")
# for k, v in qbt_client.app.build_info.items():
#     print(f"{k}: {v}")

old_urls="https://pt.btschool.club/announce.php?passkey=c987c63ccb6fb8b6d18e3b5a6250ca22"
new_urls="https://pt.btschool.club/announce.php?passkey=b11a963a0c5c55015b4f1f2d4c20f068"

i = 0
# retrieve and show all torrents
for torrent in qbt_client.torrents_info():
    # if "pt.btschool.club" in torrent.magnet_uri and torrent.tracker == "":
    if "pt.btschool.club" in torrent.magnet_uri and torrent.tracker == "":
        qbt_client.torrents_add_trackers(torrent_hash=torrent.hash, urls=new_urls)
        print(torrent)
        i += 1
    if "pt.btschool.club" in torrent.magnet_uri and torrent.tracker != "":
        if torrent.tracker == new_urls:
            continue
        qbt_client.torrents_edit_tracker(torrent_hash=torrent.hash, original_url=old_urls, new_url=new_urls)
        print(torrent)
        i += 1
    # print(f"{torrent.hash[-6:]}: {torrent.name} ({torrent.state})")
print(i)
# pause all torrents
# qbt_client.torrents.start.all()
