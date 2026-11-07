.data
ano1: .asciiz "\nDigite o primerio ano: "
ano2: .asciiz "\nDigite o segundo ano: "
erro: .asciiz "\nOs anos devem ter intervalo de 1000 anos no máximo."
n_bi: .asciiz "\nAno não bissexto: "

.text
.globl main

main:
    li $t0, 1000
loop:
    li $v0, 4
    la $a0, ano1
    syscall
    
    li $v0, 5
    syscall
    move $t1, $v0
    
    li $v0, 4
    la $a0, ano2
    syscall
    
    li $v0, 5
    syscall
    move $t2, $v0
    
    bge $t1, $t2, maior_igual
    sub $t3, $t2, $t1
    j end
    
maior_igual:
    sub $t3, $t1, $t2
    
end:
    bgt $t3, $t0, maior1000
    j fim
maior1000:
    li $v0, 4
    la $a0, erro
    syscall
    
    j loop
    
fim:

    #Quero que o ano menor esteja sempre no $t1
    bgt $t1, $t2, maior
    j verificado
maior:
    move $t3, $t1
    move $t1, $t2
    move $t2, $t3
verificado:

    #Verificar os não bissextos
    li $t0, 1
    
volta:
    bgt $t1, $t2, maiooor
    li $t3, 4
    div $t1, $t3
    mfhi $t3
    
    bne $t3, $zero, não-bissexto
    li $t3, 100
    div $t1, $t3
    mfhi $t3
    beq $t3, $zero, não-bissexto

    li $t3, 400
    div $t1, $t3
    mfhi $t3
    bne $t3, $zero, não-bissexto
    
    j final
    
nâo-bissexto:
    li $v0, 4
    la $a0, n_bi
    syscall
    
    move $a0, $t1
    li $v0, 1
    syscall
    
final:
    addi $t1, $t1, 1
    j volta
    
maiooor:
    li $v0, 10
    syscall
