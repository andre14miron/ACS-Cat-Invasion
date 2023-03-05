%include "../include/io.mac"

struc point
    .x: resw 1
    .y: resw 1
endstruc

section .text
    global points_distance
    extern printf

points_distance:
    ;; DO NOT MODIFY
    
    push ebp
    mov ebp, esp
    pusha

    mov ebx, [ebp + 8]      ; points
    mov eax, [ebp + 12]     ; distance
    ;; DO NOT MODIFY

    xor   ecx, ecx
    xor   edx, edx
    mov   dword [eax], 0

    mov   cx,  word [ebx + point.x]              ; coord. x a primului punct
    mov   dx,  word [ebx + point_size + point.x] ; coord. x al doilea punct
   
    cmp   cx,  dx                                ; compararea celor 2 coordonate x
    jne   compare                                ; cele doua coordonate nu sunt egale

    mov   cx,  word [ebx + point.y]              ; coord. y a primului punct
    mov   dx,  word [ebx + point_size + point.y] ; coord. y al doilea punct
    
compare:    
    cmp   cx,  dx                                ; verificare daca cx e mai mare ca dx
    jge   exit                                   ; 
    xchg  ecx, edx                               ; interschimba

exit:
    sub cx, dx                                   ; calcularea distnatei in cx
    mov dword [eax], ecx                         ; asocierea distantei


    ;; DO NOT MODIFY
    popa
    leave
    ret

    ;; DO NOT MODIFY
