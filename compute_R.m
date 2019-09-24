% Compte convariance matrix R 
% Author: ZhiGang Dai
% Email:  daizg@cug.edu.cn
% Date: May, 8, 2018

function R=compute_R(P,nx,ny,k1,k2)
X=k1*k2*ifft2(P);
Z1=[X(end-nx+2:end,1:ny);X(1:nx,1:ny)];
Q1=cell(ny,1);Q2=cell(ny-1,1);
for i=1:ny;
    R1=toeplitz(Z1(nx:end,ny-i+1),Z1(nx:-1:1,ny-i+1));
    Q1{i}=R1;
    if i~=ny 
    Q2{i}=R1';
    end
end
Q=[Q1  ;flipud(Q2)];
t1=ny:-1:1;
t2=ny:1:2*ny-1;
idx=toeplitz(t1,t2);
R= cell2mat(Q(idx));
end