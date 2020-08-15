# RSA Schlüssel verwalten

## Schlüsselpaar erzeugen
```
ssh-keygen -t rsa -b 4096
```

## öffentlichen Schlüssel einem ssh-Server bekanntgeben
```
ssh-copy-id benutzer@entfernter.rechner
```

## Schlüssel von GitHub beziehen
```
ssh-import-id-gh gh-user
```
