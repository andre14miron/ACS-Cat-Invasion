
%include "../include/io.mac"

section .text
    global simple
    extern printf

simple:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     ecx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; plain
    mov     edi, [ebp + 16] ; enc_string
    mov     edx, [ebp + 20] ; step

    ;; DO NOT MODIFY

shift:
    mov     al,  byte[esi+ecx-1]   ; copiere litera din plain
    mov     byte[edi+ecx-1], al    ; scrierea literei in enc_string
    add     byte[edi+ecx-1], dl    ; adaugare step
    
    cmp     byte[edi+ecx-1], 'Z'   ; verificare daca litera criptata depaseste 'Z'
    jg      over                   ; daca da, incadram litera criptata in alfabet

    loop    shift
    jmp     exit                   ; au fost criptate toate literele

over:
    sub     byte[edi+ecx-1], 'Z'+1 ; incadrarea literei in alfabet 
    add     byte[edi+ecx-1], 'A'
    loop    shift

exit:
    
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY
