# 🧅 Tor Relay mit Privoxy (Docker-basiert)

Dieses Repository stellt eine vollständige Docker-Umgebung bereit, um ein **Tor Relay** mit optionalem HTTP-Proxy via **Privoxy** zu betreiben.  
Es handelt sich **nicht um einen Exit Node** – der Traffic verlässt in der aktuellen Konfiguration dein Relay niemals in Richtung Internet.  
Optional kann Privoxy über das Tor-Netzwerk als lokaler HTTP-Proxy verwendet werden.

---

## 📦 Aufbau & Features

- Tor Relay
- Persistentes `DataDirectory`
- Privoxy als lokaler Tor-Proxy
- Nyx zur Überwachung direkt im Container enthalten
- **Optionales Docker-Image verfügbar** über:  
  `repo.techniverse.net/docker-hosted/tor-docker:latest`

---

## 🚀 Schnellstart

---

Das Projektverzeichnis sollte wie folgt aufgebaut sein:

```
tor-proxy/
├── bin/
│   └── start.sh
├── config/
│   ├── privoxy.config
│   └── torrc
├── data/
├── docker-compose.yaml
└── Dockerfile
```

---

## ⚙️ Konfiguration

### `docker-compose.yaml`:

```yaml
services:
  tor-privoxy:
    image: repo.techniverse.net/docker-hosted/tor-docker:latest
    container_name: tor-project
    hostname: tor-project
    ports:
      - "9001:9001"
      - "9030:9030"
      - "8118:8118"
    volumes:
      - ./data:/var/lib/tor
      - ./config/torrc:/etc/tor/torrc:ro
      - ./config/privoxy.config:/etc/privoxy/config:ro
    restart: always
```

---

### `torrc` (Beispielkonfiguration):

```conf
RunAsDaemon 1
ORPort 9001
DirPort 9030
Nickname DEIN-NICKNAME
ContactInfo Admin <mail@domain.com>
ControlPort 9051
CookieAuthentication 1
RelayBandwidthRate 11520 KBytes
RelayBandwidthBurst 19200 KBytes
ExitPolicy reject *:*
Log notice file /var/log/tor/notices.log
Address relay.domain.com
DataDirectory /var/lib/tor
```

---

### `privoxy.config`:

```conf
listen-address  0.0.0.0:8118
forward-socks5t /               127.0.0.1:9050 .
logfile /dev/stdout
```

---

## 🧪 Überwachung mit Nyx

```bash
docker exec -it tor-project nyx
```

> Nyx ist ein terminalbasiertes Tor-Monitoring-Tool für Relay-Status, Traffic und Routing-Daten.

---

## 🌐 Proxy-Nutzung

Privoxy kann als Proxy in Apps oder Browsern genutzt werden:

| Proxy-Typ | Host                         | Port   |
|-----------|------------------------------|--------|
| HTTP      | `relay.domain.com`           | `8118` |

---

## 🔐 Wichtige Hinweise

- Gib **keine persönlichen Daten** in `ContactInfo` oder öffentlich preis.
- Öffne **keinen Exit-Port**, wenn du nicht weißt, was du tust.
- Betreibe Privoxy **nicht ohne Auth oder IP-Restriktion**, wenn öffentlich erreichbar.

---

## 📚 Quellen & weiterführende Links

- [Anleitung: Tor-Server in Docker](https://it-service-commander.de/tutorials/docker/tor-server-in-docker-container-auf-dem-vps-installieren/)
- [Tor-Project](https://git.techniverse.net/scriptos/torproject)

---

🛠 Viel Spaß beim Aufbau deines eigenen Tor-Relays!




<p align="center">
  <img src="https://assets.techniverse.net/f1/git/graphics/gray0-catonline.svg" alt="">
</p>

<p align="center">
<img src="https://assets.techniverse.net/f1/logos/small/license.png" alt="License" width="15" height="15"> <a href="./torproject-docker/src/branch/main/LICENSE">License</a> | <img src="https://assets.techniverse.net/f1/logos/small/matrix2.svg" alt="Matrix" width="15" height="15"> <a href="https://matrix.to/#/#community:techniverse.net">Matrix</a> | <img src="https://assets.techniverse.net/f1/logos/small/mastodon2.svg" alt="Matrix" width="15" height="15"> <a href="https://social.techniverse.net/@donnerwolke">Mastodon</a>
</p>