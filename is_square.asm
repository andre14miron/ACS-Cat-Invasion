%include "../include/io.mac"

section .text
    global is_square
    extern printf

is_square:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov ebx, [ebp + 8]      ; dist
    mov eax, [ebp + 12]     ; nr
    mov ecx, [ebp + 16]     ; sq
    ;; DO NOT MODIFY
   
    mov esi, ecx              ; copiere in esi adresa de inceput sq
    mov ecx, eax              ; copiere in ecx nr

begin:

    mov edi, 0                ; initializare contor de patrat
    
compare:
    mov eax, edi
    mul edi                   ; calculare patrat
    inc edi                   ; incrementare contor de patrat

    cmp eax, [ebx+4*ecx-4]    ; comparare patrat cu distanta 
    jl compare                ; se trece la urmatorul patrat perfect
    je make_1                 ; daca este patrat perfect, atunci marcare cu 1

    mov dword[esi+4*ecx-4], 0 ; marcare cu 0

    loop begin 
    jmp exit    

make_1:
    mov dword[esi+4*ecx-4], 1 ; marcare cu 1
    loop begin 
     
exit:
    mov ecx, esi              ; restaurare adresa initiala sq
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
