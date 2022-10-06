import os
import time

def main():
    f = open("dunstcaldat.txt", "r")
    f0 = f.read()
    if str(f.read().strip("\n")) == "done":
        f.close()
        f = open("dunstcaldat.txt", "w")
        date = time.strftime("%Y-%m")
        f.write(date)
    else:
        date = f0.strip("\n")
    f.close()
    y = int(date.split("-")[0])
    m = int(date.split("-")[1].split("\n")[0])
    if m <= 0:
        y -= 1
        m = 12
    elif m > 12:
        y += 1
        m = 1
    f = open("dunstcaldat.txt", "a")
    f.write("done")
    f.close()
    execstr = 'dunstify {} {} -A "sed -i s/'+date+'/'+str(y)+'-'+str(m-1)+' dunstcaldat.txt && python ~/polybar-scripts/dunstcal.py",previous -A "sed -i s/'+date+'/'+str(y)+'-'+str(m+1)+' dunstcaldat.txt && python ~/polybar-scripts/dunstcal.py",next | bash' 
    os.system(execstr.format(date,cal(y,m,1)))

def nyKalender(y,m):
    kalender = [
        ["Ma","Ti","On","To","Fr","Lø","Sø"]#første rad i kalenderen
    ]
    #finner ukedagen til en bestemt dag i måneden (søndag = 0, lørdag = 6)
    #(se https://en.wikipedia.org/wiki/Doomsday_rule for flere detaljer)
    #må fungere for alle år
    aarhundre = int("0"+str(y)[0:len(str(y))-2])#henter alle sifre i året unntatt de to siste
    #nullet sikrer at man får ut et tall, uansett lengden av årstallet
    aar = int(str(y)[len(str(y))-2:len(str(y))])#henter de to siste sifre i året
    x = 5*(aarhundre%4)%7+2#århundrefaktoren
    z = ((aar*1.25)//1+x)%7#ukedagen til en bestemt dag i måneden
    skuddarForskyving = 0
    if y%4 == 0 and (y%400 == 0 or y%100 != 0):#avgjør om året er et skuddår
        skuddarForskyving = 1
    ukedagForskyving = [0]#januar = 1, dermed en ubrukt plass i arrayet
    #denne bestemte dagen i måneden, hvis ukedag z angir, sier ingenting om ukedagen til den 1.
    #finner ukedagen til den 1. i måneden
    manedLengder = [0,31,28+skuddarForskyving,31,30,31,30,31,31,30,31,30,31]
    ukedag = (4 + z - skuddarForskyving)%7#i januar er denne bestemte dagen 3. januar
    #gitt z = 0 og at året er ikke et skuddår, må dagene forskyves med 4 for at 3. januar skal falle på en søndag (7 -> 0)
    #0 <= d < 7, derfor brukes modulo 7
    for n in range(12):
        ukedagForskyving.append(ukedag)
        ukedag += manedLengder[n+1]#januar = 1
        ukedag %= 7#0 <= d < 7
    #lager kalenderen
    dager = []
    for i in range(int(ukedagForskyving[m])):
        dager.append("  ")#legger til tomrom for å sette riktig dag under riktig ukedag
    for i in range(manedLengder[m]):
        dager.append(str(i+1).rjust(2))#lagrer hver dag i måneden som totegnsstring
    k = 0
    while k < len(dager):
        kalender.append(dager[k:k+7])
        k+=7#legger hver uke inn i kalenderen
    return kalender

def cal(ar,maned,antManeder):
    outstr = ""
    maneder = ["","Januar","Februar","Mars","April","Mai","Juni","Juli","August","September","Oktober","November","Desember"]#januar = 1
    if antManeder == None:#hvis metoden kalles uten antManeder, sett denne til 1
        antManeder = 1
    for x in range(int(antManeder)):
        arJustert = int(ar)+(int(maned)+x-1)//12#brukeren må kunne få ut kalendere som viser måneder på tvers av år, f. eks. fra september 2019 til februar 2020
        manedJustert = (int(maned)+x-1)%12+1#gir måneden som kalendertabellen må lages for - må være mellom 1 og 12
        outstr += (maneder[manedJustert]+" "+str(arJustert)).center(20)+"\n"#skriver ut navnet på måneden
        for Y in nyKalender(arJustert,manedJustert):
            s = ""#lager en rad
            for z in Y:
                s += z + " "#fyller raden med hver dag og et gap mellom dagene
            outstr += s + "\n"#skriver ut raden
        outstr += "\n"#blank linje
    return outstr

main()
