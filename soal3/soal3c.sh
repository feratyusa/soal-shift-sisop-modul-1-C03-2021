#!/bin/bash

kucing(){
	nomor=1
	iterasi=1
	while [[ $iterasi -lt 24 ]]; do
		wget -a Foto.log "https://loremflickr.com/320/240/kitten"
		if [[ $nomor -ne 1 ]]; then
			md5sum < kitten > testPic
			file1=testPic
			i=1
			sama=1
			while [[ $i -lt $nomor ]]; do
				banding="Koleksi_`printf %02d ${i}`"
				md5sum < $banding > compPic
				file2=compPic
				if cmp -s $file1 $file2; then
					let sama=2
					echo "Sama dengan $banding"
					# let nomor=$nomor-1
					break
				fi
				let i=$i+1
			done
			rm testPic
			rm compPic
			if [[ $sama -eq 1 ]]; then
				echo "Tidak sama $nomor"
				mv kitten Koleksi_`printf %02d ${nomor}`
			else
				rm kitten
				let nomor=$nomor-1
			fi
		else
			mv kitten Koleksi_01
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
		wget -a Foto.log "https://loremflickr.com/320/240/bunny"
		if [[ $nomor -ne 1 ]]; then
			md5sum < bunny > testPic
			file1=testPic
			i=1
			sama=1
			while [[ $i -lt $nomor ]]; do
				banding="Koleksi_`printf %02d ${i}`"
				md5sum < $banding > compPic
				file2=compPic
				if cmp -s $file1 $file2; then
					let sama=2
					echo "Sama dengan $banding"
					# let nomor=$nomor-1
					break
				fi
				let i=$i+1
			done
			rm testPic
			rm compPic
			if [[ $sama -eq 1 ]]; then
				echo "Tidak sama $nomor"
				mv bunny Koleksi_`printf %02d ${nomor}`
			else
				rm bunny
				let nomor=$nomor-1
			fi
		else
			mv bunny Koleksi_01
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

path=/home/prabu/Desktop/sisop/modul1/praktikum/soal3
prevFOLDER=$(date -d 'yesterday' +%d%m%Y)

if [ -d "$path/Kelinci_$prevFOLDER" ]; then
	kucing
elif [ -d "$path/Kucing_$prevFOLDER" ]; then
	kelinci
else
	kelinci
fi