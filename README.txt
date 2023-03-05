// Copyright 314CC Miron Andreea Cristiana

Programarea Calculatoarelor si limbaje de programare 2

Tema #2
ACS Cat Invasion

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Task #1 - Simple cipher

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Asocierea dintre registre si importanta lor in cod este urmatoarea:
	-> ecx = dimensiunea textului(len)
        -> esi = string-ul plain
        -> edi = string-ul criptat
        -> edx = step
        -> eax = registru intermediar pentru mutarea literelor

         Vom parcurge label-ul shift de len ori, in cadrul careia vom cripta
fiecare litera. Astfel, se copiaza in registrul al, bitul aflat la pozitia 
ecx-1 in string-ul plain, si se copieaza la pozitia ecx-1 in testul criptat 
registrul al. Se adauga la pozitia actuala(ecx-1) step (edx) si se verifica 
daca noua litera se afla in alfabetul englez. Daca nu, se trece la urmatoarea 
litera daca mai exista sau se sare la label-ul exit, unde se incheie programul. 
Daca da, se trece la label-ul over unde se face incadrarea in alfabet prin 
adaugarea 'A'-'Z'-1 si trece la urmatoarea litera daca mai exista sau continua 
instructiule de incheierea programului.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Task #2 - Simple cipher

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

a) Points distance

	Asocierea dintre registre si importanta lor in cod este urmatoarea:
	-> ebx = adresa de inceput a vectorului de puncte
        -> eax = adresa unde trebuie scrisa distanta
        -> ecx = coordonata x sau y a primului punct
	-> edx = coordonata x sau y al doilea punct

	Se copiaza in registrele cx si dx coordonata x a primul punct, 
respectiv al doilea punct. Daca sunt egale, atunci distanta va fi reprezentata
de modul de diferenta coordonatelor y, altfel de modul de diferenta 
coordonatelor x. 
	Se compara coordonatele x, iar daca nu sunt egale se copiaza in 
registrele cx di dx coordonatele y si urmeaza label-ul compare. Daca da, se
sare direct la label-ul compare.
	In label-ul compare se verifica daca cx este mai mare ca dx, iar daca
cx este mai mic ca dx, atunci se interschimba valorile.
	In label-ul exit, se calculeaza diferenta prin a scada dx din cx si se
copieaza distanta in valoarea lui eax.

b) Road
	Asocierea dintre registre si importanta lor in cod este urmatoarea:
	-> eax = adresa de inceput a vectorului de puncte
        -> ecx = numarul de puncte
        -> ebx = adresa de inceput a vectoului de distante
	
	Copiez adresele de inceput a vectorului de puncte si a vectorului de 
distante in variabilele peax si pebx, deoarece registrele eax si ebx vor fi
modificare pe parcursul programului. 
	Se decrementeaza ecx deoarece lungimea vectorului de distante este cu 1
mai mica decat vectorul de puncte.
	Pentru fiecare pereche de puncte se pune pe stiva adresa pentru 
distanta si adresa de puncte si se apeleaza functia points_distance. Se 
restaureaza stiva. Se trece la urmatoarea adresa din cadrul vectorului de 
puncte si din cadrul vectorului de distante, iar daca mai exista perechi se
repeta procedeul. Altfel, eax si ebx isi restaureaza adresele initiale si se
incheie programul.

c) Is_square
	Asocierea dintre registre si importanta lor in cod este urmatoarea:
        -> ebx = adresa de inceput a vectoului de distante
	-> ecx = lungimea vectorului
	-> eax = adresa de inceput a vectorului rezultat in urma verificarilor
	-> edi = "contor de patrat perfect"

	Deoarece doresc sa folosesc un loop, am copiat in registrul esi ecx, 
iar in ecx am copiat lungimea vectorului de puncte.
	Pentru fiecare distanta se initializeaza cu 0 edi in label-ul begin si
se cauta patratul perfect cel mai apropiat de acel punct. Copiem in eax 
valoarea lui edi, se calzuleaza patratul perfect si se incrementeaza "contorul
de patrat perfect". Daca patratul perfect este mai mic decat distanta, se 
repeta procedeul pornind de la label-ul compare. Daca este egal, atunci se
sare la label-ul make_1, se marcheaza cu 1 in vectorul rezultat in urma 
verificarilor si se trece la urmatoarea distanta daca exista, inapoi la begin. 
Daca patratul perfect este mai mare decat distanta, atunci se marcheaza cu 0 
si se trece la urmatoarea distanta. Altfel se sare direct la label-ul exit, 
unde se restaureaza adresa initiala sq in ecx si se incheie programul.  
        
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Task #3 - Beaufort Encryption

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
	Asocierea dintre registre si importanta lor in cod este urmatoarea:
        -> eax = len_plain, contor_word
        -> ebx = adresa string_plain
        -> ecx = len_key
        -> edx = adresa string_key
	-> edi = tabula recta, contor_key
	-> esi = adresa string_criptat

	Se copiaza valorile len_plain si len_key in variabilele N_word si N_key.
	In acest task am optat pentru utilizarea formulelor, deci tabula recta
nu va fi folosita.
	Initializez cu 0 registrele eax si edi, ce reprezenta contor_word, 
respectiv contor_key.
	La fiecare parcurgere a unei litere din string_plain se verifica intai 
de toate daca a fost parcurs intreg string_key. Daca da, va fi initializat cu 
0, altfel sare direct la criptare la label-ul encryption. 
	Pentru criptarea unei litere ne vom folosi de ecx, in care se vor face
modificarile pentru a obtine litera criptata. Se muta initial in el litera 
curenta din word si se compara cu litera curenta din key. Pentru obtinerea
literei criptate exista doua cazuri:
	- litera word > litera key : unde litera criptata are asociata formula
				      'Z' + 1 - letter_word + letter_key
	- litera word <= litera key : unde litera criptata are asociata formula
				      'A' - letter_word + letter_key
	 Dupa criptarea unei litere se incrementeaza contor_key si contor_word
si se verifica daca a fost parcurs intreg string_plain. Daca da, se trece la 
criptarea urmatoarei litere prin intoarcerea la label-ul letter, altfel se 
incheie programul.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Task #4 - Spiral Encryption

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Asocierea dintre registre si importanta lor in cod este urmatoarea:
        -> eax = dimensiunea unei linii din key
        -> ebx = adresa plain
        -> ecx = adresa key
        -> edx = adresa enc_string
	
	Alte asociere semnificative sau noua atribuinta pentru variabile sau 
registrii sunt:
	-> N   = numarul de elemente intr-o parcurgere
        -> L   = numarul de elemente dintr-o linie din key (constant)
	-> esi = adresa enc_string 
	-> Np  = pozitia ultimul element din key ( L*L-1)
	-> edx = adresa key
	-> Nc  = pozitia ultimului element dintr-o parcurgere
	-> edi = pozitia curenta in plain
	-> ecx = pozitia curenta in key
	

	Au fost implementate 4 mari parcurgeri esentiale:
	- est : parcurgere verticala de sus in jos
	- sud : parcurgere orizontala din dreapta la stanga
	- vest : parcurgere verticala de jos in sus
	- nord : parcurgere orizontala din stanga la dreapta

	Orice matrice va avea o parcurgere de tip nord(prima linie). Daca 
nu s-a terminat de parcurs, atunci urmeaza sigur o parcurgere est-sud. Daca
nici in acest caz nu s-au terminat elementele, exista o parcurgere de tipul
vest-nord. Se vor tot repeta parcurgeri est-sud si vest-nord cat timp exista
litere care n-au fost criptate. 
	Oricare parcurgere respecta urmatoarea schema: 
	- calcularea noii valori Nc
	- parcurgerea efectiva unde:
		a) incrementarea pozitiei curente in plain(edi)
		b) asocierea noii valori ecx in key in functie de parcurgere
		c) in registrul eax se copiaza litera curenta din plain, 
		   adauga valoarea corespunzatoare din key
		d) se adauga in enc_string valoarea eax
		e) verificare daca au fost parcurse toate elementele din 
		   parcurgerea respectiva
