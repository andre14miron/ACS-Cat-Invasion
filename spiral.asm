
%include "../include/io.mac"

section .text
    global spiral
    extern printf

section .data
    N  DD 0
    Np DD 0
    P  DD 0
    Nc DD 0
    L  DD 0
    D  DD 0

; void spiral(int N, char *plain, int key[N][N], char *enc_string);
spiral:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; N (size of key line)
    mov ebx, [ebp + 12] ; plain (address of first element in string)
    mov ecx, [ebp + 16] ; key (address of first element in matrix)
    mov edx, [ebp + 20] ; enc_string (address of first element in string)
    ;; DO NOT MODIFY

    ;; TODO: Implement spiral encryption
    ;; FREESTYLE STARTS HERE


    mov    dword [N], eax         ; N = numarul de elemente intr-o parcurgere 
    mov    dword [L], eax         ; L = numarul de elemente de pe o linie din key
    mov    esi, edx               ; esi = registru pt enc_string
    
    mul    eax                    ; calculare numarul total de elemente, fiind patrat de N   
    mov    dword [Np], eax        ; Np = numarul total de elemente
    dec    dword [Np]             ; decrementare Np, pt. ca ultimul elemente se afla la pozitia Np-1

    xchg   edx, ecx               ; memoram in edx adresa key, pt a folosi ecx la loop   

    mov     edi, dword[N]         ; Nc = pozitia ultimul element dintr-o parcurgere       
    mov     dword [Nc], edi
    dec     dword [Nc]     
    
    mov     edi, -1               ; edi = pozitia curenta in plain
    mov     ecx, -1               ; ecx = pozitia curenta in key
    jmp     nord                  ; prima parcurgere este pe orizontala de la stanga la dreapta
                                  ; (prima linie)
 
begin:
    dec    dword [N]              ; numarul elementelor dintr-o parcurgere scade cu 1
    mov    dword [P], edx         ; salvare intr-o variabila P valoarea edx
    mov    eax, dword [N]         ; se calculeaza Nc in variabila eax prin formula N*L+Nc 
    mul    dword [L]              ;
    add    eax, dword [Nc]        ;
    mov    dword [Nc], eax        ; copierea noii valori
    mov    edx, dword [P]         ; restabilire valoare

est:                              ; parcurgerea verticala de sus in jos
    inc    edi                    ; incrementare pozitia curenta in plain
    add    ecx, dword [L]         ; incrementare cu o linie la poz curenta in key   
                                  ;
    xor    eax, eax               ; initializare cu 0
    mov    al, byte [ebx+edi]     ; copiere litera curnra din plain
    add    al, byte [edx+4*ecx]   ; adaugare valoarea corespunzatoare din key
    mov    byte [esi+edi], al     ; copiere in enc_string
                                  ;
    cmp    ecx, dword[Nc]         ; comparare poz curenta din key cu Nc
    jne    est                    ; criptare urmatorul elem daca nu a ajuns la ultima poz


    mov    eax, dword [Nc]        ; Nc devine Nc-N
    sub    eax, dword [N]         ; 
    mov    dword [Nc], eax        ;

sud:                              ; parcurgerea orizontala din dreapta la stanga
    inc    edi                    ; incrementare pozitia curenta in plain
    dec    ecx                    ; decrementare cu o pozitie la poz curenta in key
                                  ;
    xor    eax, eax               ; initializare cu 0
    mov    al, byte [ebx+edi]     ; copiere litera curenta din plain
    add    al, byte [edx+4*ecx]   ; adaugare valoarea corespunzatoare din key
    mov    byte [esi+edi], al     ; copiere in enc_string

    cmp    ecx, dword [Nc]        ; comparare poz curenta din key cu Nc
    jne    sud                    ; criptare urmatorul elem daca nu a ajuns la ultima poz
 
    cmp    edi, dword [Np]        ; verificare daca s-au parcurs toate elementele din plain
    je     exit

    dec    dword [N]              ; numarul elementelor dintr-o parcurgere scade cu 1
    mov    dword [P], edx         ; salvare intr-o variabila P valoarea edx
    mov    eax, dword [N]         ; se calculeaza Nc in variabila eax prin formula Nc-L*N
    mul    dword [L]              ;
    mov    dword [D], eax         ; retine produsul L*N
    mov    eax, dword [Nc]        ;
    sub    eax, dword [D]         ;
    mov    dword [Nc], eax        ; copierea noii valori 
    mov    edx, dword [P]         ; restabilire valoare

vest:                             ; parcurgerea verticala de jos in sus
    inc    edi                    ; incrementare pozitia curenta in plain
    sub    ecx, dword [L]         ; decrementare cu o linie la poz curenta in key
                                  ;
    xor    eax, eax               ; initializare cu 0
    mov    al, byte [ebx+edi]     ; copiere litera curenta din plain
    add    al, byte [edx+4*ecx]   ; adaugare valoarea corespunzatoare din key
    mov    byte [esi+edi], al     ; copiere in enc_string
                                  ;
    cmp    ecx, dword [Nc]        ; comparare poz curenta din key cu Nc
    jne    vest                   ; criptare urmatorul elem daca nu a ajuns la ultima poz


    mov    eax, dword [Nc]        ; Nc devine Nc+N
    add    eax, dword [N]
    mov    dword [Nc], eax


nord:                             ; parcurgerea orizontala de la stanga la dreapta
    inc    edi                    ; incrementare pozitia curenta in plain
    inc    ecx                    ; incrementare cu o pozitie la poz curenta in key
                                  ;
    xor    eax, eax               ; initializare cu 0
    mov    al, byte [ebx+edi]     ; copiere litera curenta din plain
    add    al, byte [edx+4*ecx]   ; adaugare valoarea corespunzatoare din key
    mov    byte [esi+edi], al     ; copiere in enc_string
                                  ;
    cmp    ecx, dword [Nc]        ; comparare poz curenta din key cu Nc
    jne    nord                   ; criptare urmatorul elem daca nu a ajuns la ultima poz

    cmp    edi, dword [Np]        ; verificare daca s-au parcurs toate elementele din plain
    jne    begin

exit:

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
