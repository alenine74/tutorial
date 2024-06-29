# Nmap and Network Scanning Cheat Sheet

## Nmap

### Basic Scan
```
nmap x.x.x.x
```
- Scans the 1000 most common ports using TCP.

### Sample Output
```
PORT      STATE    SERVICE
22/tcp    open     ssh
21/tcp    filtered ftp
```

**Note:** Port 3389 is the default port for Remote Desktop Services, indicating a Windows machine.

### Important Flags
- `-sC` : Enables the most common scripts.
- `-sV` : Detects service versions.
- `-p-` : Scans all 65535 ports.
- `--script` : Allows the use of custom scripts.

## Banner Grabbing

### Using Nmap
```
nmap -sV --script=banner x.x.x.x
```

### Using Netcat
```
nc -nv 10.129.42.253 21
```

## Protocols

### FTP
FTP is used for copying and sharing files between a client and server.

### SMB
SMB (Server Message Block) protocol is used for providing shared access to files, printers, and serial ports.

### SNMP
SNMP (Simple Network Management Protocol) is used for managing devices on a network. It helps administrators gather information about the performance and status of devices like routers, switches, servers, and printers.

- **Community Strings:** Control access in SNMP versions 1 and 2c.
- **Tools:**
  - `snmpwalk`: Queries SNMP-enabled devices.
  - `onesixtyone`: Brute-forces SNMP community strings using a dictionary file.
- **Security:** Always change default community strings and consider using SNMP version 3 for enhanced security.

## Cheat Sheet

### Service Scanning
```
nmap 10.129.42.253
```
- Run Nmap on an IP.

```
nmap -sV -sC -p- 10.129.42.253
```
- Run an Nmap script scan on an IP.

```
locate scripts/citrix
```
- List various available Nmap scripts.

```
nmap --script smb-os-discovery.nse -p445 10.10.10.40
```
- Run an Nmap script on an IP.

### Banner Grabbing
```
netcat 10.10.10.10 22
```
- Grab banner of an open port.

### SMB Scanning
```
smbclient -N -L \\10.129.42.253
```
- List SMB shares.

```
smbclient -U <xxx> \\10.129.42.253\users
```
- Connect to an SMB share.
