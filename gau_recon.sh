#!/bin/bash
black=`tput setaf 0`
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
magenta=`tput setaf 5`
cyan=`tput setaf 6`
reset=`tput sgr0`
echo "Usage: ./gau_recon.sh -d domain.com -f custom_file.txt -c cookies"
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
if [ -d output/$domain ]; then
	echo "${red}An output folder with the same domain name already exists.${reset}"
	read -p "Would you like to delete that folder and start fresh[y/n]: " delete
	if [[ $delete == 'y' ]]; then
		rm -rf output/$domain
	else 
		exit 2
	fi
fi
mkdir output/$domain
if [[ $file == "" ]]; then
	read -p "Check subdomains? [y/n]: " sub
	echo "${cyan}Fetching URLs : output/$domain/raw_urls.txt)"
	echo -e "\n${green}If you don't want to wait: gau_recon.sh domain.com -f path/to/raw_urls.txt"
	if [[ $sub == 'y' || $sub == 'Y' ]]; then
		trap : SIGINT
		gau_s $domain > output/$domain/raw_urls.txt
	else 
		trap : SIGINT
		gau $domain > output/$domain/raw_urls.txt
	fi

	echo -e "${green}Done${reset}\n"
else 
	cat $file > output/$domain/raw_urls.txt
fi
uniq output/$domain/raw_urls.txt | sort >> output/$domain/all_urls.txt
rm output/$domain/raw_urls.txt

echo "Done"
