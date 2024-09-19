org 0x7c00
bits 16

VIDEO_MEM: equ 0xb8000

code_seg: equ GDT_code - GDT_start

start:

  mov bp, 0x9000
  mov sp, bp

  cli
  
  lgdt [info]
  
  mov eax, cr0
  or al, 1
  mov cr0, eax

  jmp code_seg:startp


info:
  dw end - GDT_start
  dd GDT_start

GDT_start:                          ; must be at the end of real mode code
    GDT_null:
        dd 0x0
        dd 0x0

    GDT_code:
        dw 0xffff
        dw 0x0
        db 0x0
        db 0b10011010
        db 0b11001111
        db 0x0

    GDT_data:
        dw 0xffff
        dw 0x0
        db 0x0
        db 0b10010010
        db 0b11001111
        db 0x0

end:




bits 32

startp:
  mov ebp, 0x90000
  mov esp, ebp
  mov esi, string
  mov edx, VIDEO_MEM
  jmp prints

prints:
  mov al, [esi]
  mov ah, 0x0f

  cmp al, 0
  je done
  mov [edx], ax
  add esi, 1
  add edx, 2

  jmp prints

done:
  jmp $          


string: db "###########      ETHOS     ##############", 0

times 510-($-$$) db 0
dw 0AA55h
