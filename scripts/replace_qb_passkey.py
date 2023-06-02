import requests
import json

# qbittorrent Web UI地址和端口号
url = "http://192.168.123.5:8080"

# 登录qbittorrent Web UI
session = requests.Session()
# print(session)
# response = session.post(url + "/api/v2/auth/login",
#                         data=json.dumps({"username": "admin", "password": "adminadmin"}),
#                         headers={"Content-Type": "application/json"})
# if response.status_code != 200:
#     print("Failed to login to qbittorrent Web UI")
#     print(response)
#     exit(1)

# 获取所有种子信息
response = session.get(url + "/api/v2/torrents/info")
if response.status_code != 200:
    print("Failed to get torrent info from qbittorrent Web UI")
    exit(1)
torrents = response.json()

# filter_torrents = [torrent for torrent in torrents if ]
i = 0;
# 遍历所有种子并重置passkey
for torrent in torrents:
    # hash = torrent["hash"]
    # response = session.get(url + f"/api/v2/torrents/reannounce?hash={hash}")
    # if response.status_code != 200:
    #     print(f"Failed to reset passkey of torrent {hash}")
    # if torrent["tracker"] is None or torrent["tracker"] == "":
    #     if "pt.btschool.club" in torrent["magnet_uri"]:
    #         print(torrent)
    #         i += 1
    if "pt.btschool.club" in torrent["magnet_uri"]:
        print(torrent["tracker"])
        i += 1
    # if "pt.btschool.club" in torrent["tracker"]:
    #     print(torrent)
    #     i += 1
    # if "pt.btschool.club" in torrent["tracker"]:
    # print(torrent)
        # print(torrent["tracker"])
print(i)
# 退出qbittorrent Web UI
session.get(url + "/api/v2/auth/logout")
