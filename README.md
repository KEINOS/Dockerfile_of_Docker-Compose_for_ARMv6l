# Docker-Compose for ARMv6l

Docker image of `docker-compose` to install as a container. **Only for ARMv6l (arm32v6) architecture** such as RaspberryPi Zero W.

```bash
docker pull keinos/docker-compose:arm32v6
```

```shellsession
$ docker pull keinos/docker-compose:arm32v6
...
$ sudo docker run --rm keinos/docker-compose:arm32v6 version
docker-compose version 1.25.0dev, build unknown
docker-py version: 4.0.1
CPython version: 3.7.4
OpenSSL version: OpenSSL 1.1.1d  10 Sep 2019
```

## Usage

To use this container as a command, run the below 3 lines.

```bash
sudo curl -L --fail https://keinos.github.io/Dockerfile_of_Docker-Compose_for_ARMv6l/run.sh -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

Then run `$ sudo docker-compose version` to see work.

## Worked on

- Docker: v18.06.2-ce
- Raspberry Pi: Zero W, BCM2835/9000c1, ARMv6l
- Raspbian: v9, Stretch Lite

```shellsession
$ uname -a
Linux raspberrypi 4.19.66+ #1253 Thu Aug 15 11:37:30 BST 2019 armv6l GNU/Linux

$ cat /etc/os-release
PRETTY_NAME="Raspbian GNU/Linux 9 (stretch)"
NAME="Raspbian GNU/Linux"
VERSION_ID="9"
VERSION="9 (stretch)"
VERSION_CODENAME=stretch
ID=raspbian
ID_LIKE=debian
HOME_URL="http://www.raspbian.org/"
SUPPORT_URL="http://www.raspbian.org/RaspbianForums"
BUG_REPORT_URL="http://www.raspbian.org/RaspbianBugs"
```

```shellsession
$ docker version
Client:
 Version:           18.06.2-ce
 API version:       1.38
 Go version:        go1.10.3
 Git commit:        6d37f41
 Built:             Sun Feb 10 03:57:32 2019
 OS/Arch:           linux/arm
 Experimental:      false

Server:
 Engine:
  Version:          18.06.2-ce
  API version:      1.38 (minimum version 1.12)
  Go version:       go1.10.3
  Git commit:       6d37f41
  Built:            Sun Feb 10 03:53:01 2019
  OS/Arch:          linux/arm
  Experimental:     false
```

```shellsession
$ cat /proc/cpuinfo
processor	: 0
model name	: ARMv6-compatible processor rev 7 (v6l)
BogoMIPS	: 298.59
Features	: half thumb fastmult vfp edsp java tls
CPU implementer	: 0x41
CPU architecture: 7
CPU variant	: 0x0
CPU part	: 0xb76
CPU revision	: 7

Hardware	: BCM2835
Revision	: 9000c1
Serial		: 00000000XXXXXXXX

$ rev=$(awk '/^Revision/ { print $3 }' /proc/cpuinfo) && curl -L perturb.org/rpi?rev=$rev
Revision : 9000c1
Model    : Zero W
Memory   : 512 MB
Overvolt : No
Released : Q1 2017
Notes    : (Mfg by Sony)

````
