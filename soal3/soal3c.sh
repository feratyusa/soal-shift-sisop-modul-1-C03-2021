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
				if [[ $i -lt 10 ]]; then
					md5sum < Koleksi_0$i > compPic
				else
					md5sum < Koleksi_$i > compPic				
				fi
				file2=compPic
				if cmp -s file1 file2; then
					$sama=2
					let $nomor=$nomor-1
					break
				fi
				let i=$i+1
			done
			rm testPic
			rm compPic
			if [[ $sama -eq 1 ]]; then
				if [[ $nomor -lt 10 ]]; then
					mv kitten Koleksi_0$nomor
				else
					mv kitten Koleksi_$nomor
				fi
			else
				rm kitten
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
				if [[ $i -lt 10 ]]; then
					md5sum < Koleksi_0$i > compPic
				else
					md5sum < Koleksi_$i > compPic				
				fi
				file2=compPic
				if cmp -s file1 file2; then
					$sama=2
					let $nomor=$nomor-1
					break
				fi
				let i=$i+1
			done
			rm testPic
			rm compPic
			if [[ $sama -eq 1 ]]; then
				if [[ $nomor -lt 10 ]]; then
					mv bunny Koleksi_0$nomor
				else
					mv bunny Koleksi_$nomor
				fi
			else
				rm bunny
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
	kucing
fi