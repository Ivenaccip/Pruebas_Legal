#!/bin/bash
sudo apt-get install curl -y
sudo apt-get install wget -y
if ! [ -d requisitos ]
	then
		mkdir requisitos
fi

if ! [ -d requisitos/resultados ]
	then
		mkdir requisitos/resultados
fi

if ! [ -d requisitos/cemex ]
	then
		cd requisitos
		sudo git clone https://github.com/hippiiee/osgint.git && cd osgint && pip3 install -r requirements.txt
		cd ..
		cd ..
fi

clear
echo
echo
read -p "[*] Escribe el nombre de usuario del Objetivo (Ej: anonymous23): " username
echo
echo "#################################"
echo "[☢] UserName: $username"
echo "#################################"
echo
wget --wait=40 --limit-rate=40K -U Mozilla -bq https://nitter.net/$username -O requisitos/resultados/Twitter-$username.txt >/dev/null
sleep 6
echo "[*] Usuario + Nombre: " `cat requisitos/resultados/Twitter-$username.txt | awk -F= '/og:title/ {print $3}' | cut -c 2- | rev | cut -c5- | rev`
echo "[*] Descripcion: " `cat requisitos/resultados/Twitter-$username.txt | awk -F= '/og:description/ {print $3}' | cut -c 2- | rev | cut -c5- | rev`
echo "[*] Se unio en: " `cat requisitos/resultados/Twitter-$username.txt | awk -F= '/profile-joindate/ {print $3}' | cut -c 2- | rev | cut -c13- | rev`
echo "[*] Tweets: " `cat requisitos/resultados/Twitter-$username.txt | awk -F= '/profile-stat-num/ {print $2}' | cut -c 20- | rev | cut -c8- | rev | awk 'NR==1{print}'`
echo "[*] Following: " `cat requisitos/resultados/Twitter-$username.txt | awk -F= '/profile-stat-num/ {print $2}' | cut -c 20- | rev | cut -c8- | rev | awk 'NR==2{print}'`
echo "[*] Followers: " `cat requisitos/resultados/Twitter-$username.txt | awk -F= '/profile-stat-num/ {print $2}' | cut -c 20- | rev | cut -c8- | rev | awk 'NR==3{print}'`
echo "[*] Likes: " `cat requisitos/resultados/Twitter-$username.txt | awk -F= '/profile-stat-num/ {print $2}' | cut -c 20- | rev | cut -c8- | rev | awk 'NR==4{print}'`
echo
echo "[*] Foto de Perfil: " `cat requisitos/resultados/Twitter-$username.txt | awk -F= '/twitter:image:src/ {print $3}' | cut -c 2- | rev | cut -c5- | rev`
echo
echo "[*] URL Perfil: https://nitter.net/$username"
while read -r linea; do
	echo "$linea"
done < requisitos/resultados/Twitter-$username.txt | grep "tweet-content media-body" | sed 's/<div class="tweet-content media-body" dir="auto">//g' | sed 's/<\/div>//g' > info.csv
