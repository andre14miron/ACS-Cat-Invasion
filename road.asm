%include "../include/io.mac"

struc point
    .x: resw 1
    .y: resw 1
endstruc

section .data
    peax DD 0
    pebx DD 0

section .text
    global road
    extern printf
    extern points_distance

road:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]      ; points
    mov ecx, [ebp + 12]     ; len
    mov ebx, [ebp + 16]     ; distances
    ;; DO NOT MODIFY

    mov dword[peax], eax    ; copiere adresa de inceput a vectorului de puncte
    mov dword[pebx], ebx    ; copiere adresa de inceput a vectorului de distante 
    dec ecx                 ; decrementare len

pair:
    
    push ebx                ; punere pe stiva adresa pentru distanta
    push eax                ; punere pe stiva adresa pentru puncte
    call points_distance    ; apelare functie 
    add esp, 8              ; restaurare stiva

    add eax, point_size     ; trecerea la urmatorul element din vectorul de puncte
    add ebx, 4              ; trecerea la urmatorul element din vectorul de distante 

    loop pair

    mov eax, dword[peax]    ; restaurare adresa initiala a vectorului de puncte
    mov ebx, dword[pebx]    ; restaurare adresa initiala a vectorului de distante
 
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
