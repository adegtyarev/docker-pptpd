# Point-to-Point Tunneling & Docker

The Point-to-Point Tunneling Protocol (PPTP) is an *obsolete* method for
implementing virtual private networking.


## Software specficiation

* Base image: Alpine Linux
* pptpd version: 1.4.0
* [![](https://images.microbadger.com/badges/image/adegtyarev/pptpd.svg)](https://microbadger.com/images/adegtyarev/pptpd "the download size and the number of layers")


## Usage

PPTP uses a control channel over 1732/TCP and a GRE tunnel to encapsulate PPP
packets.  An example command to allow GRE (for everyone) with `iptables`:

    iptables -A INPUT -p gre -j ACCEPT 

You also need the following modules loaded into the kernel:

    modprobe nf_conntrack_pptp nf_nat_pptp

To run a private VPN server with simple username/password auth, create file
`chap-secrets` based on the one from the examples:

    $ git clone https://github.com/adegtyarev/docker-pptpd.git
    $ cp config/chap-secrets.example chap-secrets
    $ vim chap-secrets      # make your changes, dont use the defaults

Start a new container:

    docker-compose up -d

The VPN server should be up and ready to serve.

Access the logs with:

    $ docker-compose logs -f pptpd


## Notes

PPTP is [known to be a faulty](http://poptop.sourceforge.net/dox/protocol-security.phtml) protocol.
Nowadays it is strongly recommend not to use it due to the inherent risks. Lots
of people use PPTP anyway due to many cheap hardware routers only allows that
kind of tunneling.  Whenever it possible you should use OpenVPN (SSL based) or
IPSec instead.


## Author

Alexey Degtyarev @adegtyarev
