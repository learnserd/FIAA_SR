% Compte Index used in get_E.m efficiecntly  written by DZG
% FIAA for 3-D seismic data reconstruction with randomly missing traces
% Author: ZhiGang Dai
% Email:  daizg@cug.edu.cn
% Date: May, 8, 2018

function Index=get_Index(N1,N2)

a1=1:N2^2;
A1=reshape(a1,[N2,N2]);
r1=1:N1^2;
Rs=reshape(r1,[N1,N1]);
Index1=cell(1,2*N1-1);
Rkkk=R_index_toeplitz(N1*N2,N1,N2);
for i=1:2*N1-1;
    s=diag(Rs,i-N1);
Index1{i}=s;
end

Index2=cell(1,(2*N1-1)*(2*N2-1));
for i=1:2*N2-1
    s1=diag(A1,i-N2);
            for jj=1:2*N1-1;
                Ta=[];
    for j=1:length(s1)
        Rt=Rkkk{s1(j)};
                Tas=Rt(Index1{jj});
                Ta=[Ta;Tas] ; 
    end
   Index2{(i-1)*(2*N1-1)+jj}=Ta;
            end
end
clearvars -except  Index2
Index=Index2;

end