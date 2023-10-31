org 0x7C00
bits 16

%define ENDL 0x0D, 0x0A

start:
  jmp main

; Prints a string
; Params
;   - ds:si point to a string
puts:
  ; save register we are going to modify
  push si
  push ax

.loop:
  lodsb       ; load next character in al
  or al, al   ; verify next character
  jz .done

  mov ah, 0x0e   ; call bios interrupt
  mov bh, 0     ; set page number to 0
  int 0x10

  jmp .loop

.done:
  pop ax
  pop si
  ret

main:
  ; set-up data
  mov ax, 0
  mov ds, ax
  mov es, ax

  ; set-up stack
  mov ss, ax
  mov sp, 0x7C00

  mov si, msg_line1
  call puts

  mov si, msg_line2
  call puts

  hlt

.halt:
  jmp .halt

msg_line1:db "Welcome to skynet cyberdyne systems", ENDL, 0
msg_line2:db "Loading: Neural net-based artificial intelligence", ENDL, 0

times 510-($-$$) db 0
dw 0xAA55