#!/bin/bash
# Keterangan field
# $1 = Row ID
# $2 = Order ID
# $3 = Order Date
# $4 = Ship Date
# $5 = Ship Mode
# $6 = Customer ID
# $7 = Customer Name
# $8 = Segment
# $9 = Country
# $10 = City
# $11 = State
# $12 = Postal Code
# $13 = Region
# $14 = Product ID
# $15 = Category
# $16 = Sub-Category
# $17 = Product Name
# $18 = Sales
# $19 = Quantity
# $20 = Discount
# $21 = Profit
#field separator yang digunakan adalah '\t'
awk -F '\t' '
#2a
#fungsi untuk menghitung cost price
function cost_price() 
{
    return ($1 - $2);
}
#fungsi untuk menghitung profit ratio
function profit_ratio() 
{
    return ($1 / $2);
}
#fungsi untuk menghitung profit percentage
function profit_percentage() 
{
    return ($1 * 100);
}
BEGIN  {
    #2a
    max_pr = 0;
    max_row_id = 0;
    #2c
    flag_ts = 0;
    min_ts = 0;
    #2d
    flag_p = 0;
    min_p = 0;
}
{
    #mengabaikan header di NR == 1
    if(NR > 1) 
    {
        #2a
        #menghitung cost price
        curr_cost_price = cost_price $18 $21
        #menghindari pembagian dengan 0
        if(curr_cost_price != 0) 
        {
            #mencari profit ratio terbesar
            if(NR == 2) 
            {
                max_pr = profit_ratio($21, curr_cost_price);
                max_row_id = $1;
            }
            else 
            {
                curr_pr = profit_ratio($21, curr_cost_price);
                if(max_pr < curr_pr) 
                {
                    max_pr = curr_pr;
                    max_row_id = $1;
                }
                else if(max_pr == curr_pr && $1 > max_row_id) 
                {
                    max_row_id = $1;
                }
            }
        }
        #2b
        #split tanggal dengan delimiter "-" dan menyimpan hasilnya dalam array "date"
        split($3, date, "-");
        #jika tahun dari tanggal adalah 2017 dan kotanya adalah "Albuquerque"
        if(date[3] == 17 && $10 == "Albuquerque") 
        {
            customers[$7] += 1;
        }
        #2c
        #menghitung jumlah transaksi segment 
        transactions[$8] += 1;
        #2d
        #menghitung total profit region
        profits[$13] += $21;
    }
}
END {
    #2a
    printf("Transaksi terakhir dengan profit percentage terbesar yaitu %d dengan persentase %d%%.\n", 
    max_row_id, profit_percentage(max_pr));
    printf("\n");
    #2b
    print "Daftar nama customer di Albuquerque pada tahun 2017 antara lain:";
    for(customer in customers) 
    {
        print customer;
    }
    printf("\n");
    #2c
    #mencari jumlah transaksi segment yang paling sedikit
    for(i in transactions) 
    {
        if(flag_ts == 0) 
        {
            min_ts = transactions[i];
        }
        else if(min_ts > transactions[i]) 
        {
            min_ts = transactions[i];
            segment = i;
        }
    }
    printf("Tipe segmen customer yang penjualannya paling sedikit adalah %s dengan %d transaksi.\n", segment, min_ts);
    printf("\n");
    #2d
    #mencari total keuntungan wilayah yang paling sedikit
    for(i in profits) 
    {
        if(flag_p == 0) 
        {
            min_p = profits[i];
            region = i;
            flag_p = 1;
        }
        else if(min_p > profits[i]) 
        {
            min_p = profits[i];
            region = i;
        }
    }
    printf("Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah %s dengan total keuntungan %f\n",
    region, min_p);
}' Laporan-TokoShiSop.tsv > hasil.txt
