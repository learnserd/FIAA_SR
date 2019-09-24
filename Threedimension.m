
function  Threedimension(XZT,x1,y1,z1,num)
X_3D=permute(XZT,[x1 y1 z1]);
[nx,ny,nz]=size(X_3D);
N=[nx,ny,nz];
if nargin==5
figure(num);
end
caxis=[0 1];
value=ones(nx,ny,nz);
for k=1:nz
    for j=1:ny
        for i=1:nx
            value(i,j,k)=X_3D(i,j,k);
        end
    end
end
x=1:nx;
y=1:ny;
z=1:nz;
% close all;

%x=1  yz
[Y,Z]=meshgrid(1:ny,1:nz);
X=ones(nz,ny);
C=X;
for k=1:nz
    for j=1:ny
        C(k,j)=value(1,j,k);
    end
end
surf(X,Y,Z,C);
% grid off;
box on;
shading interp;
hold on;
%x=nx yz
X=zeros(nz,ny)+nx;
C=X;
for k=1:nz
    for i=1:ny
        C(k,i)=value(nx-1,i,k);
    end
end
surf(X,Y,Z,C);

hold on;

%y=1  xz
[X,Z]=meshgrid(1:nx,1:nz);
Y=ones(nz,nx);
C=Y;
for k=1:nz
    for i=1:nx
        C(k,i)=value(i,1,k);
    end
end
surf(X,Y,Z,C);
% grid off;
box on;
shading interp;
hold on;
%y=ny xz
Y=zeros(nz,nx)+ny;
C=Y;
for k=1:nz
    for i=1:nx
        C(k,i)=value(i,ny-1,k);
    end
end
surf(X,Y,Z,C);
box on
hold on;

%z=1 xy
[X,Y]=meshgrid(1:nx,1:ny);
Z=ones(ny,nx);
C=Z;
for j=1:ny
    for i=1:nx
        C(j,i)=value(i,j,1);
    end
end
surf(X,Y,Z,C);
% grid off;

hold on;
%z=nz xy
Z=zeros(ny,nx)+nz;
C=Z;
for j=1:ny
    for i=1:nx
        C(j,i)=value(i,j,nz-1);
    end
end
surf(X,Y,Z,C);
 shading interp;
hold on;
axis([0 nx+1 0 ny+1 0 nz+1]);
% caxis([0,1]);
colormap(gray);
% colorbar;
    colormap(seismic(1));%Using a colored colormap

xlabel('Xline','Rotation',-3,'fontsize',12);
ylabel('Crossline','Rotation',43,'fontsize',12);
zlabel('Time Sample','fontsize',15);
axis([1 32 1 32 1 300]);
% set(gca,'zTick',(10:10:300));
set (gcf,'Position',[500,300,300,350]); 
set(gca,'tickdir','out');
set(gca,'ydir','reverse');
 view(16, 6);
% margin = get(gca, 'TightInset');  
% set(gca, 'Position', [0+margin(1) 0+margin(2) 1-margin(1)-margin(3) 1-margin(2)-margin(4)]);%去除figure空白区域
% set(gcf, 'color', [1 1 1]);  %背景设为白色
axis tight;

% axis equal; 
% axis tight;
