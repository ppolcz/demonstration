SetNonCommutative[ia,inva];
ClearMonomialOrder[];
SetMonomialOrder[{a,b,c,d,e,f,g,h,i,j,k,l,m,n,ia,inva},1];
Iterations=10;

rels={
	a**ia - 1, 
	ia**a - 1, 
	ia - inva, 
	m**m**m**a - n
     };
