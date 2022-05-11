#!/usr/bin/bash

TARGET_SITE="https://cafefac.gitlab.io/cv"
TARGET_DOMAIN="gitlab.io"
TOOLS_DIR=~/tools
mkdir -p ${TOOLS_DIR}

# ============= STAGE 0 Clone site =============
cd ~
mkdir sites
cd sites

echo -e "  --> httrack: clone ${TARGET_SITE}"
mkdir httrack
cd httrack
httrack --ext-depth=1 ${TARGET_SITE}
cd ..

echo -e "  --> wget: clone ${TARGET_SITE}"
mkdir wget
cd wget
wget --page-requisites  --adjust-extension --mirror --convert-links --html-extension --wait=2 -o download.log $TARGET_SITE


# ============= STAGE 1 Get DNS info =============

cd ~
host ${TARGET_DOMAIN}
nslookup ${TARGET_DOMAIN}
nslookup -type=mx ${TARGET_DOMAIN}
dig -t axfr ${TARGET_DOMAIN}

# ============= STAGE 2 Get DOMAIN info =============
###################################################
#                   #    domain1    #     domain2
# owner             #               #
# contact address   #               #
# contact emails    #               #
# ip addresses      #               #
# phone numbers     #               #
# dns servers       #               #
# DNSSEC            #               #
######################################################

whois ${TARGET_DOMAIN}

# ============= STAGE 3 Get Search engines info =============
# Use below:
# -http://2ip.ru
# -https://domainbigdata.com
# -http://searchdns.netcraft.com/;
# -https://www.shodan.io/host/;
# -https://censys.io/
# -https://crt.sh
# -https://community.riskiq.com/
# -http://whois.webhosting.info/x.x.x.x
# -http://google.com (inurl, site, filetype, cache, etc...)
# -https://www.censys.io/ipv4?q=mospolytech.ru
# -https://bgp.he.net/dns/mospolytech.ru

# to get:

# -ip address and domain info
# -IPs addresses
# -CMS used
# -hosting provider
# -website info
# -sites on the same ip
# -all domains of the owner
#DNS параметры домена
#Поиск доменного имени
#Определение IP адреса по Е-mail
#Информация об AS (автономных системах) принадлежащих искомой цели и адреса блоков, которые им соответствуют.

# ============= STAGE 4 Get subdomains info =============
#recon-ng
#help
#options list

#marketplace search
#marketplace info google
#marketplace install recon/domains-hosts/google_site_web
#modules reload
#modules load google_site_web
#info
#options set SOURCE vulnweb.com
#run

# ============= STAGE 5 Get dns info for domain =============

dig -t ns ${TARGET_DOMAIN}
dig -t ns ns-1116.awsdns-11.org
dig -t ns a1-195.akam.net
dig @ns-1116.awsdns-11.org. hostname.bind. txt chaos
dig @a1-195.akam.net. hostname.bind. txt chaos

# the same and consolidated
dnsrecon -d ${TARGET_DOMAIN}
#fast
dnsenum --noreverse ${TARGET_DOMAIN}
#long
dnsenum --noreverse ${TARGET_DOMAIN}

# get subdomains
git clone https://github.com/rbsec/dnscan.git /usr/share/wordlists/dnscan
dnsrecon -d ${TARGET_DOMAIN} -t brt -D /usr/share/wordlists/dnscan/subdomains-10000.txt
dnsmap ${TARGET_DOMAIN} -w /usr/share/wordlists/dnscan/subdomains-10000.txt


git clone https://github.com/guelfoweb/knock.git ${TOOLS_DIR}/knock
cd ${TOOLS_DIR}/knock
pip3 install -r requirements.txt
python3 knockpy.py ${TARGET_DOMAIN}


# ============= STAGE 6 Additional resources =============
# Amass (Very fast brute)
# subfinder (Brute and finding)
# Aquatone (Using public services like: shodan, censys, riskiq...)

# ============= STAGE 7 DNS history =============
http://viewdns.info/iphistory/?domain=mospolytech.ru

# ============= STAGE 8 Additional resources =============
https://crt.sh/?q=%25.mospolytech.ru


# ============= STAGE 9 Get emails by domain =============
#theHarvester -d ${TARGET_DOMAIN} -l 500 -b google

# ============= STAGE 10 Additional resources =============
dmitry ${TARGET_DOMAIN}


Maltego


#https://osintframework.com/
#https://securitytrails.com/blog/osint-tools