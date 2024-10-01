```
sudo apt-get install jq
```
Permisos de ejecución <br />
```
chmod +x mint_coins.sh <br />
```
Correr el script <br />
```
./mint_coins.sh
```
Para listar los assets
```
tapcli --tlscertpath ~/.lit/tls.cert --rpcserver=localhost:8443 --network=mainnet assets list
