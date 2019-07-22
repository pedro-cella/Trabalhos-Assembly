.data
	linha: .asciiz "\n"
	invalido: .asciiz "Quantidade invalida\n"
	gabarito: .space 1001
	marcado: .space 1001
	
#conteudo dos registradores:
#s0: quantidade de questoes
#s1: endereco do gabarito na memoria
#s2: endereco da resposta do aluno na memoria
#s3: quantidade de acertos

.text
main:
#recebe N, que representa a quantidade de questoes:
	li $v0, 5                     #le o valor digitado
	syscall                       #executa a funcao
	add $s0, $v0, $0              #guarda o valor digitado em s0

#condicoes para dar erro:	
	slt $t0, $s0, $0 			#seta t0 em 1 caso N seja negativo
	beq $t0, 1, erro			#se t0 for 1, pula para erro
	slti $t0, $s0, 201			#seta t0 em 1 caso N seja maior que 200
	beq $t0, 0, erro			#se t0 for 0, pula para erro

Gabarito_prova:
#recebe o gabarito da prova	
	li $v0, 8					#le uma string digitada
	la $a0, gabarito			#define onde serao guardados os caracteres lidos
	addi $a1, $0, 1000			#delimita a quantidade de caracteres a serem lidos
	syscall			          #executa a funcao

#quebra de linha para separar o gabarito das respostas do aluno
	#li $v0, 4                     #funcao para exibir uma mensagem
	#la $a0, linha		 	     #exibe uma quebra de linha
	#syscall                       #executa a funcao

Marcado_aluno:
#recebe as repostas marcadas pelo aluno
	li $v0, 8					#le uma string digitada
	la $a0, marcado			#define onde serao guardados os caracteres lidos
	addi $a1, $0, 1000			#delimita a quantidade de caracteres a serem lidos
	syscall			          #executa a funcao

	#li $v0, 4                     #funcao para exibir uma mensagem
	#la $a0, linha		 	     #exibe uma quebra de linha
	#syscall                       #executa a funcao

	la $s1, gabarito			#guarda o endereco do gabarito em s1
	la $s2, marcado			#guarda o endereco da resposta do aluno em s2

	add $s3, $0, $0			#zera o s3
	add $t4, $s0, $0			#coloca a quantiadde de questoes em t4

comparar:
    lb $t2,($s1)         	     #pega o proximo caractere do gabarito
    lb $t3,($s2)          	     #pega o proximo caractere da resposta
    seq $t0, $t2, $t3    	     #compara os dois e seta t0 em 1 se forem iguais
    add $s3, $s3, $t0			#soma em s3 1 se acertou e 0 se errou
    addi $s1,$s1,1                 #aponta para o proximo caracter
    addi $s2,$s2,1             	#aponta para o proximo caracter
    addi $t4, $t4, -1			#decrementando t4
    bne $t4, $0, comparar		#volta pro loop se ainda tiver resposta pra comparar

fim:	
	li $v0, 1					#funcao para exibir um numero
	add $a0, $s3, $0			#coloca a quatidade de acertos em a0
	syscall					#executa a funcao
	
	li $v0, 4                     #funcao para exibir uma mensagem
	la $a0, linha		 	     #exibe uma quebra de linha
	syscall                       #executa a funcao
	
	li $v0, 10				#funcao para finalizar o programa
	syscall					#executa a funcao
	
erro:
	li $v0, 4                     #funcao para exibir uma mensagem
	la $a0, invalido			#exibe a mensagem de erro
	syscall					#executa a funcao
	
	j main
