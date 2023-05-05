# apcimage

## Installation

```
# You can also use openssl instead: `openssl rand -base64 36`
sudo apt-get install -y pwgen
```

```
echo "SECRET_KEY=$(pwgen -s 40 1)" >> .env
```
