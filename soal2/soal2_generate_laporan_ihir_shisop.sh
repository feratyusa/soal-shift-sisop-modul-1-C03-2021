#!/bin/bash

#2A
awk '
    END
    {
        printf("Transaksi terakhir dengan profit percentage terbesar 
        yaitu %d dengan persentase %d%%.\n", maksID, maks)
    }
' Laporan-TokoShisop.tsv>>hasil.txt

awk '
            printf("%s\n", data)
    }
    }
' Laporan-TokoShisop.tsv>>hasil.txt

#2C
awk '
    }
        printf("\n\nTipe segmen customer yang penjualannya paling sedikit 
        adalah %s dengan %d transaksi.\n\n", nama_segment, transaksi)
    }
' Laporan-TokoShisop.tsv>>hasil.txt

#2D
awk '
    }
        printf("Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit 
        adalah %s dengan total keuntungan %.2f.\n", nama_wilayah, minimal_profit)
    }
' Laporan-TokoShisop.tsv>>hasil.txt 