clear
clc

//------------------NERACA MASSA DISTILASI (D-01)------------------

//Menghitung laju alir
//Aliran dari kondensor
komponen=['EDC'; 'VCM'; 'HCl']
input_A5=[23908.43434; 19128.78788; 7447.474747] //kg/h
//Aliran top product HCl
output_A6=[0; 0; 19991.94] //kg/h
//Aliran Bottom Product menuju Distilasi 2
output_A7=[11363.96909; 19128.78788; 0] //kg/h

//Menghitung subtotal dan total
subtotal_inputA5=sum(input_A5)
subtotal_outputA6=sum(output_A6)
subtotal_outputA7=sum(output_A7)
total_input=subtotal_inputA5
total_output=subtotal_outputA6 + subtotal_outputA7

//Menghitung komposisi komponen
//Aliran 5
EDC_A5=input_A5(1,1)/subtotal_inputA5
VCM_A5=input_A5(2,1)/subtotal_inputA5
HCl_A5=input_A5(3,1)/subtotal_inputA5
komposisi_A5=[EDC_A5; VCM_A5; HCl_A5]
subtotal_komposisiA5=sum(komposisi_A5)
//Aliran 6
EDC_A6=output_A6(1,1)/subtotal_outputA6
VCM_A6=output_A6(2,1)/subtotal_outputA6
HCl_A6=output_A6(3,1)/subtotal_outputA6
komposisi_A6=[EDC_A6; VCM_A6; HCl_A6]
subtotal_komposisiA6=sum(komposisi_A6)
//Aliran 7
EDC_A7=output_A7(1,1)/subtotal_outputA7
VCM_A7=output_A7(2,1)/subtotal_outputA7
HCl_A7=output_A7(3,1)/subtotal_outputA7
komposisi_A7=[EDC_A7; VCM_A7; HCl_A7]
subtotal_komposisiA7=sum(komposisi_A7)

// Tampilkan Tabel mass flow
garis=" -----------------------------------------------------------------\n"
printf(" ------------------NERACA MASSA DISTILASI (D-01)------------------\n")
printf("\n--> MASS FLOW (kg/h) :\n\n")
printf("                   Tabel 1. Neraca Massa D-01 (kg/h)\n")
mprintf(garis)
mprintf("                 INPUT (kg/h)          OUTPUT (kg/h)\n")
mprintf(garis)
mprintf("  Komponen        A5(kg/h)        A6(kg/h)       A7(kg/h)\n")
mprintf(garis)

for i = 1:size(komponen, "r")
    mprintf("  %-15s %-15.6f %-15.6f %-15.6f\n", komponen(i), input_A5(i),output_A6(i), output_A7(i))
end

mprintf(garis)
mprintf("  SUBTOTAL        %-15.6f %-15.6f %-15.6f\n", subtotal_inputA5,  subtotal_outputA6,  subtotal_outputA7)
mprintf(garis)
mprintf("  TOTAL           %-15.6f          %-15.6f\n", total_input, total_output)
mprintf(garis)

// Tampilkan Tabel komposisi
mprintf(" \n--> KOMPOSISI :\n\n")
mprintf("                       Tabel 2. Komposisi D-01 \n")
mprintf(garis)
mprintf("                 INPUT                     OUTPUT \n")
mprintf(garis)
mprintf("  Komponen           A5              A6              A7 \n")
mprintf(garis)

for i = 1:size(komponen, "r")
    mprintf("  %-15s %-15.6f %-15.6f %-15.6f\n", komponen(i), komposisi_A5(i), komposisi_A6(i), komposisi_A7(i))
end
printf(garis)
printf(" SUBTOTAL         %-15.6f %-15.6f %-15.6f \n", subtotal_komposisiA5, subtotal_komposisiA6, subtotal_komposisiA7)
mprintf(garis)

//Hitung error neraca massa
mass_error = abs(total_input - total_output)/total_input*100
garis="-----------------------------------------------------------------\n"
if mass_error<1 then
    printf("\n --------------NERACA MASSA TERBUKTI--------------\n")
else
    printf("\n --------------NERACA MASSA TIDAK TERBUKTI--------------\n")
end 
printf(" Error neraca massa adalah %.6f%%.\n", mass_error)
