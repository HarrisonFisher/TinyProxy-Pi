# TinyProxy-Pi
TinyProxy setup script for Raspberry Pi.

## Features

- Installs TinyProxy automatically
- Configures username/password authentication
- Customizable port, server limits, timeout, and logging
- Easy to run on any Raspberry Pi
- Displays local proxy URL after installation
- Enables TinyProxy to start automatically on boot

## Install
```bash
curl -sSL https://raw.githubusercontent.com/HarrisonFisher/TinyProxy-Pi/refs/heads/main/TinyProxy-Pi.sh | bash -s -- --username myuser --password mypass
````
> **⚠️ Important:** Be sure to replace `myuser` and `mypass` with your own secure username and password.


### Available Options

**--username** `<name>` &nbsp;&nbsp;&nbsp; Proxy username (default: proxyuser)  
**--password** `<pass>` &nbsp;&nbsp;&nbsp; Proxy password (default: proxypass)  
**--port** `<port>` &nbsp;&nbsp;&nbsp; Listening port (default: 8888)  
**--maxclients** `<num>` &nbsp;&nbsp;&nbsp; Max clients (default: 100)  
**--minspare** `<num>` &nbsp;&nbsp;&nbsp; Min spare servers (default: 5)  
**--maxspare** `<num>` &nbsp;&nbsp;&nbsp; Max spare servers (default: 20)  
**--startservers** `<num>` &nbsp;&nbsp;&nbsp; Start servers (default: 10)  
**--maxreqperchild** `<num>` &nbsp;&nbsp;&nbsp; Max requests per child (default: 0 = unlimited)  
**--timeout** `<seconds>` &nbsp;&nbsp;&nbsp; Timeout (default: 600)  
**--loglevel** `<level>` &nbsp;&nbsp;&nbsp; Log level (default: Info)  
**--help** &nbsp;&nbsp;&nbsp; Show help message

## License

MIT License – See the LICENSE file for details.

