#include <stdio.h>

int main(){
	
	int N, i=2;
	
	scanf("%d", &N);
	
	if(N<1 || N>32768)
		printf("Entrada invalida.\n");
	else{
		do{
			while(N%i==0){
				N = N/i;
				printf("%d\n", i);
			}
			i++;
		} while(N!=1);
	}
	
	return 0;
}
