% Compte polynomial coefficient  W corresponing to A*R*A  written by DZG
% Author: ZhiGang Dai
% Email:  daizg@cug.edu.cn
% Date: May, 8, 2018
function W=compute_coff(Rs,Index,nx,ny,K)
n=(2*nx-1)*(2*ny-1);
n3=(2*nx-1);
c=zeros(n,1);
for i=1:(2*nx-1)*(2*ny-1)
    c(i)=sum(Rs(Index{i}));
end
W=zeros(K,K);
s=[K-nx+2:K, 1 :nx];
s1=[K-ny+2:K, 1 :ny];
for k=1:(2*ny-1)
W(s,s1(k))=c((k-1)*n3+1:k*n3).';
end
end