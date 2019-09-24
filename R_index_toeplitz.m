%This script is used in script get_Index.m
% Author: ZhiGang Dai
% Email:  daizg@cug.edu.cn
% Date: May, 8, 2018

function r=R_index_toeplitz(n,n1,n2)
m1=n1*ones(n2,1);
m2=m1;
r=1:n^2;
R=reshape(r,[n,n]);
r=mat2cell(R,m1,m2);
end
