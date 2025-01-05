clc
clear
clf
mprintf('\n  -----------------------------------HASIL RUN TUGAS BESAR KELOMPOK 35----------------------------------- \n\n  ----------------------PRODUKSI STYRENE MELALUI PROSES DEHIDROGENASI ETHYL BENZENE---------------------- \n')

//Data-Data dari Excel :
Data    =readxls('D:/PRAKTIKUM KOMPROS/TUBES/Data Termodinamika_Kelompok 35.xls')
sheet   =Data(1)
sy      =sheet(:,1)   //baris,kolom

//Data-Data Penunjang Reaksi :
T0   =25+273.15       //K
T    =500+273.15      //K
R    =8.314           //J/mol.K
Ea1  =242672      //J/mol
Ea2  =288696     //J/mol
A1   =0.36*10^14
A2   =0.5*10^14


//Menghitung Nilai K :
k1  =A1*exp(-Ea1/(R*T))   //men^-1
k2  =A2*exp(-Ea2/(R*T))   //men^-1

//Pembacaan Data Excel dan Perhitungan :
JR      =x_mdialog('Reaksi Pembentukan VCM','Jumlah Reaksi','2')
for i   =1:evstr(JR)
JK(i)   =x_mdialog('Reaksi Pembentukan VCM'+string(i)+'.','Jumlah Komponen','3')
p       =1
r       =1
    for a            =1:evstr(JK(i))
        S(i,a)       =x_choose(sy,'Pilih Senyawa')
        Senyawa(i,a) =sheet(S(i,a))         //Senyawa lembar 1, kolom 1
        BM(i,a)      =sheet(S(i,a),2)       //BM lembar 1, kolom 2
        A(i,a)       =sheet(S(i,a),3)       //Cp A lembar 1, kolom 3
        B(i,a)       =sheet(S(i,a),4)       //Cp B lembar 1, kolom 4
        C(i,a)       =sheet(S(i,a),5)       //Cp C lembar 1, kolom 5
        D(i,a)       =sheet(S(i,a),6)       //Cp D lembar 1, kolom 6
        E(i,a)       =sheet(S(i,a),7)       //Cp E lembar 1, kolom 7
        Ah(i,a)      =sheet(S(i,a),8)       //Hf A lembar 1, kolom 8
        Bh(i,a)      =sheet(S(i,a),9)       //Hf B lembar 1, kolom 9
        Ch(i,a)      =sheet(S(i,a),10)      //Hf C lembar 1, kolom 10
        Ag(i,a)      =sheet(S(i,a),11)      //Gf A lembar 1, kolom 11
        Bg(i,a)      =sheet(S(i,a),12)      //Gf B lembar 1, kolom 12
        Cg(i,a)      =sheet(S(i,a),13)      //Gf C lembar 1, kolom 13
        deltaH(i,a)  =sheet(S(i,a),14) //Hf298 lembar 1, kolom 14
        deltaG(i,a)  =sheet(S(i,a),15) //Gf298 lembar 1, kolom 15
        Koef(i,a)    =evstr(x_mdialog('Reaksi Pembentukan VCM'+string(i)+'Senyawa'+string(a)+' ','Koefisien','0'))
        if  Koef(i,a)<0 then                // Untuk reaktan
            SR(i,r)       =sy(S(i,a))
            BMR(i,r)      =BM(i,a)
            AR(i,r)       =A(i,a)
            BR(i,r)       =B(i,a)
            CR(i,r)       =C(i,a)
            DR(i,r)       =D(i,a)
            ER(i,r)       =E(i,a)
            AhR(i,r)      =Ah(i,a)
            BhR(i,r)      =Bh(i,a)
            ChR(i,r)      =Ch(i,a)
            AgR(i,r)      =Ag(i,a)
            BgR(i,r)      =Bg(i,a)
            CgR(i,r)      =Cg(i,a)
            deltaHR(i,r)  =deltaH(i,a)
            deltaGR(i,r)  =deltaG(i,a)
            KoefR(i,r)    =Koef(i,a)
            MolR(i,r)     =evstr(x_mdialog('Reaksi Pembentukan VCM'+string(i)+'Senyawa'+string(a)+' ','Jumlah mol','0'))
            JRt(i)        =r
            r             =r+1
        else                              //Untuk produk
            SP(i,p)       =sheet(S(i,a))
            BMP(i,p)      =BM(i,a)
            AP(i,p)       =A(i,a)
            BP(i,p)       =B(i,a)
            CP(i,p)       =C(i,a)
            DP(i,p)       =D(i,a)
            EP(i,p)       =E(i,a)
            AhP(i,p)      =Ah(i,a)
            BhP(i,p)      =Bh(i,a)
            ChP(i,p)      =Ch(i,a)
            AgP(i,p)      =Ag(i,a)
            BgP(i,p)      =Bg(i,a)
            CgP(i,p)      =Cg(i,a)
            deltaHP(i,p)  =deltaH(i,a)
            deltaGP(i,p)  =deltaG(i,a)
            KoefP(i,p)    =Koef(i,a)
            MolP(i,p)     =evstr(x_mdialog('Reaksi Pembentukan VCM'+string(i)+'Senyawa'+string(a),'Jumlah mol','0'))
            JP(i)         =p
            p             =p+1
         end
    end
end

//Menentukan Koefisien Reaktan Pembatas :
Rtp                  =(MolR ./KoefR)
for i                =1:evstr(JR)
    [H(i),idx(i)]    =min(Rtp(i,:))
    Koefrtp(i)       =abs(KoefR(i,idx(i)))
end
    
//Menghitung Nilai delta H Produk (898.15 K) :
for i                =1:evstr(JR)
    for a            =1:evstr(JP(i))
        deltaHp(i,a) =(((integrate('AP(i,a)+BP(i,a)*T+CP(i,a)*(T^2)+DP(i,a)*(T^3)+EP(i,a)*(T^4)','T',T0,T)))+(deltaHP(i,a)))*KoefP(i,a)             //Integral Cp dT dari T0 ke T
    end
end
    
//Menghitung Nilai Delta H Reaktan :
for i                =1:evstr(JR)
    for a            =1:evstr(JRt(i))
        deltaHr(i,a) =(((integrate('AR(i,a)+BR(i,a)*T+CR(i,a)*(T^2)+DR(i,a)*(T^3)+ER(i,a)*(T^4)','T',T0,T)))+(deltaHR(i,a)))*KoefR(i,a)             //Integral Cp dT dari T0 ke T
    end
end
    
//Menghitung Nilai Delta G Produk :
for i                 =1:evstr(JR)
    for a             =1:evstr(JP(i))
        deltagp(i,a)  =deltaGP(i,a)*KoefP(i,a)
    end
end

//Menghitung Nilai Delta G Reaktan :
for i                 =1:evstr(JR)
    for a             =1:evstr(JRt(i))
        deltagr(i,a)  =deltaGR(i,a)*KoefR(i,a)
    end
end

//Menghitung Nilai Delta G Total :
for i           =1:evstr(JR)
    dgrtot(i)   =sum(deltagr(i,:))
    dgptot(i)   =sum(deltagp(i,:))
    dgtot(i)    =dgrtot(i)+dgptot(i)
    dg(i)       =dgtot(i)/Koefrtp(i)
end

//Menghitung Nilai Delta H Total :
for i           =1:evstr(JR)
    dhrtot(i)   =sum(deltaHr(i,:))
    dhptot(i)   =sum(deltaHp(i,:))
    dhtot(i)    =dhrtot(i)+dhptot(i)
    dh(i)       =dhtot(i)/Koefrtp(i)
end

//Menghitung mol FCp Reaktan :
for i               =1:evstr(JR)
    for a           =1:evstr(JRt(i))
        Cpr(i,a)    =(AR(i,a)+BR(i,a)*T+CR(i,a)*(T^2)+DR(i,a)*(T^3)+ER(i,a)*(T^4)*abs(KoefR(i,a)))                  //Permisalan
        FCpr(i,a)   =MolR(i,a)*Cpr(i,a)
    end
end

//Menghitung mol FCp Produk :
for i               =1:evstr(JR)
    for a           =1:evstr(JP(i))
        Cppro(i,a)  =(AP(i,a)+BP(i,a)*T+CP(i,a)*(T^2)+DP(i,a)*(T^3)+EP(i,a)*(T^4)*abs(KoefP(i,a)))                 //Permisalan
        FCppro(i,a) =MolP(i,a)*Cppro(i,a)
    end
end

//Menghitung mol FCp Total :
for i               =1:evstr(JR)
    sigmaFCpr(i)    =sum(FCpr(i,:))
    sigmaFCpp(i)    =sum(FCppro(i,:))
    sigmaFCp(i)     =sigmaFCpr(i)+sigmaFCpp(i)
end

//Menghitung Nilai K pada Treff (298.15 K) :
for i       =1:evstr(JR)
    K298(i) =exp(dg(i)/(-R*T))
end

//Menghitung Nilai K pada Tr (898.15 K) :
for i       =1:evstr(JR)
    K898(i) =K298(i)+(exp((-dh(i)/R)*((1/T)-(1/T0))))
end

//Keterangan Untuk Fungsi Utama :
CEdc  =C(1)     //Konsentrasi Ethylene Dichloride(mol/L)
CVcm  =C(2)     //Konsentrasi VCM(mol/L)
CHcl  =C(3)     //Konsentrasi Asam Klorida(mol/L)
CAct  =C(4)     //Konsentrasi Acetylene (mol/L)
Va    =0.1      //L/men

//Fungsi Utama :
function dCT =pers(V,CT)
    dCT(1)   =((-k1*CT(1)))/Va                    //mol/L
    dCT(2)   =((k1*CT(1))-(k2*CT(2)))/Va         //mol/L
    dCT(3)   =((k1*CT(1))+(k2*CT(2)))/Va         //mol/L
    dCT(4)   =(k2*CT(2))/Va                             //mol/L
    dCT(5)   =(((dh(1))*((-k1*CT(1))))+((dh(1))*(k1*CT(1)))-((dh(2))*(-k2*CT(2)))+((dh(1))*(k1*CT(1)))+(((dh(2))*(k2*CT(2)))+((dh(2))*(k2*CT(1)))))/sum(sigmaFCp)                              //K
endfunction

//Profil Konsentrasi dan Suhu terhadap Volume Reaktor :
//Konsentrasi Awal tiap Komponen :
CEdc0=1;CVcm0=0;CHcl0=0;CAct0=0               //mol/L
//Penyelesaian :
V0   =0                                                   //L
V    =0:15:300                                            //L
C0   =[CEdc0;CVcm0;CHcl0;CAct0]         //mol/L
T    =T                                                   //K
CT0  =[C0;T]                                              //mol/L
CT   =ode(CT0,V0,V,pers)
CT=CT';V=V'
linebreak   =("  -------------------------------------------------------------------------------------------------------")
mprintf("\n                                           Tabel 1. C & T vs V \n")
mprintf(linebreak)
mprintf('\n   V(L)   CEdc(mol/L) CVcm(mol/L) CHcl(mol/L) CAct(mol/L)    T(K) \n')
mprintf(linebreak)
disp([V,CT])
mprintf(linebreak);mprintf("\n")
//Grafik :
//Konsentrasi vs Volume :
subplot(4,1,1);plot2d([V,V,V,V],[CT(:,1),CT(:,2),CT(:,3),CT(:,4)],[2,3,5,6])
xtitle('Profil Konsentrasi terhadap Volume','Volume Reaktor (L)','Konsentrasi (mol/L)')
legend(['CEdc','CVcm','CHcl','CAct'])
//Suhu vs Volume :
subplot(4,1,2);plot2d(V,CT(:,5),1)
xtitle('Profil Suhu terhadap Volume','Volume Reaktor (L)','Suhu (K)')

//Menghitung Konversi :
XA          =((CEdc0-CT(:,1))/CEdc0)*100  //%
linebreak1  =("  ------------------")
mprintf("\n   Tabel 2. XA vs V \n")
mprintf(linebreak1)
mprintf('\n   V(L)      XA(%%) \n')
mprintf(linebreak1)
disp([V,XA])
mprintf(linebreak1);mprintf("\n")
//Grafik :
subplot(4,1,3);plot2d(V,XA,1)
xtitle('Profil Konversi terhadap Volume','Volume Reaktor (L)','Konversi (%)')

//Profil Suhu terhadap Konversi :
linebreak2  =("  -----------------------")
mprintf("\n     Tabel 3. T vs XA \n")
mprintf(linebreak2)
mprintf('\n      XA(%%)       T(K) \n')
mprintf(linebreak2)
disp([XA,CT(:,5)])
mprintf(linebreak2);mprintf("\n")
subplot(4,1,4);plot2d(XA,CT(:,5),1)
xtitle('Profil Suhu terhadap Konversi','Konversi (%)','Suhu (K)')

//Menghitung Neraca Massa :
MassIn   =(CT(1,1)*Va*BM(1,1))+(CT(1,2)*Va*BM(1,2))+(CT(1,3)*Va*BM(1,3))+(CT(1,4)*Va*BM(2,2))               //g/men
MassOut  =(CT(21,1)*Va*BM(1,1))+(CT(21,2)*Va*BM(1,2))+(CT(21,3)*Va*BM(1,3))+(CT(21,4)*Va*BM(2,2))        //g/men
NerMas   =MassIn-MassOut   //g/men
//Pembuktian Neraca Massa :
mprintf('\n  PEMBUKTIAN NERACA MASSA :')
mprintf('\n  --> Neraca Massa Input  = %f g/men \n  --> Neraca Massa Output = %f g/men \n',MassIn,MassOut)
if NerMas<10^-1 then mprintf('      -->  NERACA MASSA TERBUKTI \n')
    else mprintf('      -->  NERACA MASSA TIDAK TERBUKTI \n')
end
//Menghitung Persen Error :
%ErrorNermas    =(abs(NerMas/MassOut))*100   //%
mprintf('  %%ERROR NERACA MASSA     :')
mprintf('\n  --> %%Error Neraca Massa = %3f%% \n',%ErrorNermas)
