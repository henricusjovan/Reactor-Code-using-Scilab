clear;clc
mprintf('RUNNING TUBES KELOMPOK 35\n')

//Neraca Panas Heater (E-312)

//Data-Data dari Excel :
Data    =readxls('D:\Tubes\Data Termodinamika_Kelompok 35.xls')
sheet   =Data(1)
sy      =sheet(:,1)     //baris,kolom

//Data-Data Suhu :
Tin     =63.85+273.15   //K
Tout    =59.2+273.15    //K
Tr      =25+273.15      //K
TCWin   =25+273.15      //K
TCWout  =40+273.15      //K

//Data-Data Cp Gas tiap Komponen :
A   =[sheet(3,3),sheet(4,3),sheet(5,3),sheet(6,3)]  //kJ/mol
B   =[sheet(3,4),sheet(4,4),sheet(5,4),sheet(6,4)]  //kJ/mol
C   =[sheet(3,5),sheet(4,5),sheet(5,5),sheet(6,5)]  //kJ/mol
D   =[sheet(3,6),sheet(4,6),sheet(5,6),sheet(6,6)]  //kJ/mol
E   =[sheet(3,7),sheet(4,7),sheet(5,7),sheet(6,7)]  //kJ/mol

//Menghitung Cp in dan Cp out :
Cpin    =A*(Tin-Tr)+B/2*(Tin^2-Tr^2)+C/3*(Tin^3-Tr^3)+D/4*(Tin^4-Tr^4)+E/5*(Tin^5-Tr^5) //kJ/mol
Cpout   =A*(Tin-Tout)+B/2*(Tin^2-Tout^2)+C/3*(Tin^3-Tout^3)+D/4*(Tin^4-Tout^4)+E/5*(Tin^5-Tout^5)   //kJ/mol

//Mass Flow:
Fin     =[504.8469697,29987.91,0,0] //kg/h
Fout    =Fin                        //kg/h
BM      =[98.97,62.5,36.46,26.04]   //kg/kmol

//Neraca Panas Komponen:
//Ethylene Dichloride (EDC)
nEDC    =Fin(1,1)/BM(1,1)       //mol
QinEDC  =Cpin(1,1)*nEDC         //kJ/h
QoutEDC =Cpout(1,1)*nEDC        //kJ/h
//Vinyl chloride monomer (VCM)
nVCM    =Fin(1,2)/BM(1,2)       //mol
QinVCM  =Cpin(1,2)*nVCM         //kJ/h
QoutVCM =Cpout(1,2)*nVCM        //kJ/h
//Hydrogen Chloride (HCl)
nHCl    =Fin(1,3)/BM(1,3)       //mol
QinHCl  =Cpin(1,3)*nHCl         //kJ/h
QoutHCl =Cpout(1,3)*nHCl        //kJ/h
//Acethylene
nAce    =Fin(1,4)/BM(1,4)       //mol
QinAce  =Cpin(1,4)*nAce         //kJ/h
QoutAce =Cpout(1,4)*nAce        //kJ/h

//Neraca Panas Overall
Qin     =QinEDC+QinVCM+QinHCl+QinAce        //kJ/h
Qout    =QoutEDC+QoutVCM+QoutHCl+QoutAce    //kJ/h

//Kebutuhan Cooling Water pada Cooler :
//Data-Data Cp Water :
A1  =92.053             //kJ/mol
B1  =-3.9953E-02        //kJ/mol
C1  =-2.1103E-04        //kJ/mol    
D1  =5.3469E-07         //kJ/mol
BM_water    =18.015

Cp_water    =A1*(TCWin-TCWout)+B1/2*(TCWin^2-TCWout^2)+C1/3*(TCWin^3-TCWout^3)+D1/4*(TCWin^4-TCWout^4)    //kJ/mol
QCwater     =Qin-Qout                       //kJ/h
mCwater     =QCwater/Cp_water*BM_water      //kg/h

//HASIL dalam tabel
mprintf("\n  --> HEAT FLOW (kJ/h) : \n")
garis   ="\n -----------------------------------------------------------------\n"
mprintf("                Tabel 1. Neraca Panas Overall (E-312)")
mprintf(garis)
mprintf("     Q Input Overall (kJ/h)         Q Output Overall (kJ/h)")
mprintf(garis)
mprintf("         %f                 %f",Qin,Qout)
mprintf(garis)
mprintf(" --> Jumlah cooling water yang dibutuhkan pada cooler sebesar %f kJ/h \n",QCwater)
mprintf(" --> Kebutuhan cooling water pada cooler sebesar %f kg/h \n",-mCwater)

//Tabel Neraca Panas :
mprintf("\n                    Tabel 2. Neraca Panas (E-312)")
mprintf(garis)
mprintf("  Komponen                 Q Input (kJ/h)       Q Output (kJ/h)")
mprintf(garis)
mprintf("  Ethylene Dichloride      %f         %f\n",QinEDC,QoutEDC)
mprintf("  Vinyl Chloride Monomer   %f       %f\n",QinVCM,QoutVCM)
mprintf("  Hydrogen Chloride        %f             %f\n",QinHCl,QoutHCl)
mprintf("  Acethylene               %f             %f\n",QinAce,QoutAce)
mprintf("  Cooling Water            -                    %f",QCwater)
mprintf(garis)
mprintf("  Total                    %f        %f",Qin,Qout+QCwater)
mprintf(garis)

//Pembuktian Neraca Panas
NeracaPanas=Qin-(Qout+QCwater)      //kJ/h
if NeracaPanas<10^-1 then mprintf("\n\n --> NERACA PANAS TERBUKTI \n")
    else mprintf("\n\n --> NERACA PANAS TIDAK TERBUKTI \n")
end

//Persen Error
%Error      =abs((NeracaPanas/Qin)*100)   //%
mprintf("\n Besarnya persen error neraca panas adalah %f  \n",%Error)


