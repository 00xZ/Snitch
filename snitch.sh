#!/bin/bash
black=`tput setaf 0`
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
magenta=`tput setaf 5`
cyan=`tput setaf 6`
reset=`tput sgr0`
echo "Usage: ./eye.sh -d domain.com -f custom_file.txt -c cookies"
echo "domain.com        --- The domain for which you want to test"
echo "custom_file.txt   --- Optional argument. You give your own custom URLs instead of using gau"
echo "${cyan} 

	[EYE]
			                                                
${green}- By Eyezik ${reset}
                                  "
server=""
file=""
pwd
while getopts "d:f:" opt
do
	case "${opt}" in 
		d) 
			domain="${OPTARG}"
			;;
		f)
			file="${OPTARG}"
			;;
	esac
done
if [[ ${domain:0:5} == "https" ]]; then
	domain=${domain:8:${#domain}-8}
elif [[ ${domain:0:4} == "http" ]]; then
	domain=${domain:7:${domain}-7}
fi
if [ -d output_snitch/$domain ]; then
	echo "${red}An output_snitch folder with the same domain name already exists.${reset}"
	read -p "Would you like to delete that folder and start fresh[y/n]: " delete
	if [[ $delete == 'y' ]]; then
		rm -rf output_snitch/$domain
	else 
		exit 2
	fi
fi
mkdir output_snitch/$domain
if [[ $file == "" ]]; then
	echo "${cyan}Fetching : output_snitch/$domain/)"
	subfinder -d $domain -o output_snitch/$domain/subfinder_dump.txt
	cat output_snitch/$domain/subfinder_dump.txt | httpx -title -sc -ports 8443,8080,443,80 -o output_snitch/$domain/httpx_dump
	echo -e "${green}Done${reset}\n"
else 
	cat $file > output_snitch/$domain/httpx_dump.txt
fi
cat output_snitch/$domain/httpx_dump | grep "ogin" > output_snitch/$domain/Logins.txt
cat output_snitch/$domain/httpx_dump | grep "200" > output_snitch/$domain/alive.txt

echo "Done"
