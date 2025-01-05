clear
clc

mprintf('\nKelompok 35\n')

// Data Input
komponen = ["EDC"; "VCM"; "HCl"];
input_A1=[49984.848480; 0; 0];          // kg/h
input_A11=[499.79; 0; 0]                // kg/h
output_A2=[50484.69697; 0; 0; 0];       // kg/h

// Konversi ke kmol/h
molar_mass=[98.97;62.5;34.46]
input_A1_molar = input_A1 / molar_mass;    // kmol/h
input_A11_molar = input_A11 / molar_mass;  // kmol/h
output_A2_molar = output_A2 / molar_mass;  // kmol/h

// Hitung subtotal dan total massflow
subtotal_input_A1 = sum(input_A1);
subtotal_input_A11 = sum(input_A11);
subtotal_output_A2 = sum(output_A2);
total_input = subtotal_input_A1 + subtotal_input_A11;
total_output = subtotal_output_A2;

// Hitung subtotal dan total molarflow
subtotal_input_A1_molar = sum(input_A1_molar);
subtotal_input_A11_molar = sum(input_A11_molar);
subtotal_output_A2_molar = sum(output_A2_molar);
total_input_molar = subtotal_input_A1_molar + subtotal_input_A11_molar
total_output_molar = subtotal_output_A2_molar;

// Hitung error neraca massa
mass_error = abs(total_input - total_output)/total_input*100;
garis="-----------------------------------------------------------------\n"

// Tampilkan Tabel mass flow
clc;
printf("------------------NERACA MASSA MIXER (M-210 A)------------------\n");
printf("\n--> MASS FLOW (kg/h) :\n\n");
printf("Tabel 1. Neraca Massa M-210 A (kg/h)\n");
printf(garis);
printf("                        INPUT (kg/h)             OUTPUT (kg/h)\n");
printf(garis);
printf(" Komponen        A1(kg/h)        A11(kg/h)       A2(kg/h)\n");
printf(garis);

for i = 1:size(komponen, "r")
    printf(" %-15s %-15.6f %-15.6f %-15.6f\n", komponen(i), input_A1(i),input_A11(i), output_A2(i));
end

printf(garis);
printf(" SUBTOTAL        %-15.6f %-15.6f %-15.6f\n", subtotal_input_A1,  subtotal_input_A11,  subtotal_output_A2);
printf(garis);
printf(" TOTAL                  %-15.6f          %-15.6f\n", total_input, total_output);
printf(garis);


//Tabel molar flow
printf("\n--> MOLAR FLOW (kmol/h) :\n\n");
printf("Tabel 2. Neraca Massa M-210 A (kmol/h)\n");
printf(garis);
printf("                        INPUT (kmol/h)           OUTPUT (kmol/h)\n");
printf(garis);
printf(" Komponen        A1(kmol/h)      A11(kmol/h)     A2(kmol/h)\n");
printf(garis);

for i = 1:size(komponen, "r")
    printf(" %-15s %-15.6f %-15.6f %-15.6f\n", komponen(i), input_A1_molar(i),input_A11_molar(i), output_A2_molar(i));
end

printf(garis);
printf(" SUBTOTAL        %-15.6f %-15.6f %-15.6f\n", subtotal_input_A1_molar,  subtotal_input_A11_molar,  subtotal_output_A2_molar);
printf(garis);
printf(" TOTAL                  %-15.6f          %-15.6f\n", total_input_molar, total_output_molar);
printf(garis);

if mass_error<1 then
    printf("\n--------------NERACA MASSA TERBUKTI--------------\n");
else
    printf("\n--------------NERACA MASSA TIDAK TERBUKTI--------------\n");
end 
printf("%%Error neraca massa adalah %.6f%%.\n", mass_error);
