%include "../include/io.mac"

section .data
    N_key   DD 0	
    N_word  DD 0

section .text
    global beaufort
    extern printf

; void beaufort(int len_plain, char *plain, int len_key, char *key, char tabula_recta[26][26], char *enc) ;
beaufort:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; len_plain
    mov ebx, [ebp + 12] ; plain (address of first element in string)
    mov ecx, [ebp + 16] ; len_key
    mov edx, [ebp + 20] ; key (address of first element in matrix)
    mov edi, [ebp + 24] ; tabula_recta
    mov esi, [ebp + 28] ; enc
    ;; DO NOT MODIFY
    ;; TODO: Implement spiral encryption
    ;; FREESTYLE STARTS HERE
     
    mov dword[N_word], eax       ; salvare len_plain in N_word           
    mov dword[N_key],  ecx       ; salvare len_key in N_key
    
    xor eax, eax                 ; contor key
    xor edi, edi                 ; contor word 

letter:

    cmp eax, [N_key]             ; verificare daca s-a parcurs intreg key_ul
    jne encryption               ; continuare la criptare
    xor eax, eax                 ; initializare contor_key cu 0
        
encryption:
    xor ecx, ecx                 ; initializare ecx - litera criptata
    mov cl,  byte [ebx+edi]      ; mutare litera curenta din textul plain
    
    cmp cl,  byte [edx+eax]      ; comparare litera din plain cu litera din key 
    jle less_or_egal             ; daca <=, atunci este cazul less_or_egal
                                 ; altfel, se aplica alta formula
    mov cl,  'Z'+1               ; criptarea literei
    sub cl,  byte[ebx+edi]       ;
    add cl,  byte[edx+eax]       ;
    mov byte[esi+edi], cl        ; mutarea in enc

    jmp back

less_or_egal:
     mov cl,  byte[edx+eax]      ; criptarea literei
     sub cl,  byte[ebx+edi]      ;
     add cl,  'A'                ;
     mov byte[esi+edi], cl       ; mutarea in enc

back:     
     inc eax                     ; incrementare contor_key
     inc edi                     ; incrementare contor_word
     cmp edi, [N_word]           ; verificare daca a fost parcurs textul plain
     jne letter

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
