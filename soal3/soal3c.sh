#!/bin/bash

kucing(){
	nomor=1
	iterasi=1
	while [[ $iterasi -lt 24 ]]; do
		wget -o temp.log "https://loremflickr.com/320/240/kitten"
		if [[ $nomor -gt 1 ]]; then
			word=`awk '/Location/{print $2}' temp.log`
			compare=`awk -v w="$word" '$0 ~ w {print 1}' Foto.log`
			# Ada yang sama
			if [[ ${#compare} -gt 1 ]]; then
				rm kitten
				echo "Sama"
				let nomor=$nomor-1
			else
			# Berbeda semua
				echo "Tidak sama"
				mv kitten Koleksi_$(printf %02d "$nomor")
				cat temp.log >> Foto.log
			fi
			rm temp.log
		else
			mv kitten Koleksi_01
			mv temp.log Foto.log
		fi
		let nomor=$nomor+1
		let iterasi=$iterasi+1
	done
	FOLDER="Kucing_$(date +%d%m%Y)"
	if [[ ! -d "$path/$FOLDER" ]]; then
		mkdir $FOLDER
	fi
	mv Koleksi_* $FOLDER
	mv Foto.log $FOLDER
}

kelinci(){
	nomor=1
	iterasi=1
	while [[ $iterasi -lt 24 ]]; do
		wget -o temp.log "https://loremflickr.com/320/240/bunny"
		if [[ $nomor -gt 1 ]]; then
			word=`awk '/Location/{print $2}' temp.log`
			compare=`awk -v w="$word" '$0 ~ w {print 1}' Foto.log`
			# Ada yang sama
			if [[ ${#compare} -gt 1 ]]; then
				rm bunny
				echo "Sama"
				let nomor=$nomor-1
			else
			# Berbeda semua
				echo "Tidak sama"
				mv bunny Koleksi_$(printf %02d "$nomor")
				cat temp.log >> Foto.log
			fi
			rm temp.log
		else
			mv bunny Koleksi_01
			mv temp.log Foto.log
		fi
		let nomor=$nomor+1
		let iterasi=$iterasi+1
	done
	FOLDER="Kelinci_$(date +%d%m%Y)"
	if [[ ! -d "$path/$FOLDER" ]]; then
		mkdir $FOLDER
	fi
	mv Koleksi_* $FOLDER
	mv Foto.log $FOLDER
}

path=`pwd`
prevFOLDER=$(date -d 'yesterday' +%d%m%SY)

if [ -d "$path/Kelinci_$prevFOLDER" ]; then
	kucing
elif [ -d "$path/Kucing_$prevFOLDER" ]; then
	kelinci
else
	kelinci
fi