echo "All installs will be put in /bin/ and will make a /root/tools/ dir."
mkdir /root/tools
cd /root/tools
git clone https://github.com/projectdiscovery/subfinder.git
cd /root/tools/subfinder
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go build
cp subfinder /bin/
cd /root/tools
git clone https://github.com/projectdiscovery/httpx.git
cd /root/tools/httpx/cmd/httpx
go build
cp httpx /bin/
cd /root/tools
git clone https://github.com/lc/gau.git
cd /root/tool/gau
go build
cp gau /bin/
echo "Done! You are all set."
