function rgb = seismic(option)
% seismic: generate colormap array for seismic images
% Syntax:
%     rgb = seismic(option)
% Input:
% 	option: = 0, red-white-blue;
%           = 1, brown-white-black;
%           = 2, red-white-black;
%           = 3, red-white-blue, using log-transform, have clipping effect;
%           = 4, white-gray-black, using nonlinear transform (atan),
%               have clippling effect (default option)
% Output:
%     rgb: colormap array [r' g' b']

% Copyright(c)Pengliang Yang, 2012.4

if nargin==0, option=4; end
N1 = 64;
if (option == 0)
	r = [linspace(0,1,N1), ones(1,128-N1),      linspace(1,0,128-N1), zeros(1,N1)];
	g = [zeros(1,N1),linspace(0,1,128-N1),linspace(1,0,128-N1), zeros(1,N1)];
	b = [zeros(1,N1),linspace(0,1,128-N1),ones(1,128-N1),linspace(1,0,N1)];
elseif (option == 1)
% 	r = [0.5*ones(1,N1), linspace(0.5,1,128-N1), linspace(1,0,128-N1),zeros(1,N1)];
% 	g = [0.25*ones(1,N1),linspace(0.25,1,128-N1),linspace(1,0,128-N1),zeros(1,N1)];
% 	b = [zeros(1,N1),    linspace(0,1,128-N1),   linspace(1,0,128-N1),zeros(1,N1)];
	r = [zeros(1,N1), linspace(0,1,128-N1), linspace(1,0.5,128-N1),0.5*ones(1,N1)];
	g = [zeros(1,N1),linspace(0,1,128-N1),linspace(1,0.2,128-N1),0.2*ones(1,N1)];
	b = [zeros(1,N1),linspace(0,1,128-N1), linspace(1,0,128-N1) ,zeros(1,N1)];
elseif (option == 2)
%     r = [ones(1,N1), ones(1,128-N1),          linspace(1,0,128-N1),zeros(1,N1)];
%     g = [zeros(1,N1),linspace(0.,1,128-N1),   linspace(1,0,128-N1),zeros(1,N1)];
%     b = [zeros(1,N1),linspace(0.,1,128-N1),   linspace(1,0,128-N1),zeros(1,N1)];
        r = [ones(1,N1), ones(1,128-N1),          linspace(1,0,128-N1),zeros(1,N1)];
    g = [zeros(1,N1),linspace(0.,1,128-N1),   linspace(1,0,128-N1),zeros(1,N1)];
    b = [zeros(1,N1),linspace(0.,1,128-N1),   linspace(1,0,128-N1),zeros(1,N1)];
%         r = [0.4136*ones(1,N1), linspace(0.4136,1,128-N1),linspace(1,0,128-N1),zeros(1,N1)];
%     g = [0.4136*ones(1,N1), linspace(0.4136,1,128-N1),   linspace(1,0,128-N1),zeros(1,N1)];
%     b = [0.4136*ones(1,N1), linspace(0.4136,1,128-N1),   linspace(1,0,128-N1),zeros(1,N1)];
%       r = [zeros(1,N1), linspace(0,1,128-N1),linspace(1,0.4116,128-N1),0.4116*ones(1,N1)];
%     g = [zeros(1,N1), linspace(0,1,128-N1),   linspace(1,0.4116,128-N1),0.4116*ones(1,N1)];
%     b = [zeros(1,N1), linspace(0,1,128-N1),   linspace(1,0.4116,128-N1),0.4116*ones(1,N1)];
 
elseif (option == 3)
	r = [logspace(-2,0,N1),ones(1,128-N1),logspace(0,-2,128-N1),zeros(1,N1)];
	g = [zeros(1,N1),logspace(-2,0,128-N1),logspace(0,-2,128-N1),zeros(1,N1)];
	b = [zeros(1,N1),logspace(-2,0,128-N1),ones(1,128-N1),logspace(0,-2,N1)];
elseif (option == 4)
    N2 = 256;alpha = 5;
    center = floor(N2/2);
    tmp = (atan(([1:N2]-center-0.5)/alpha));
    tmp = (max(tmp)-tmp)/(max(tmp) -min(tmp));
    r = tmp;
    g = tmp;
    b = tmp;
end
rgb = [r',g',b'];

