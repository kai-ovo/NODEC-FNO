%% Generate darcy flow dataset with different ef's and coeff's

num_coeff = 600; % number of coefficients
num_ef = 40; % number of forcing terms
s = 256; % grid size
data = containers.Map; % data dict

[X,Y] = meshgrid(0:(1/(s-1)):1);

%Parameters of covariance C = tau^(2*alpha-2)*(-Laplacian + tau^2 I)^(-alpha)
%Note that we need alpha > d/2 (here d= 2) 
%Laplacian has zero Neumann boundry
%alpha and tau control smoothness; the bigger they are, the smoother the
%function
alpha = 2;
tau = 3;
% tic;
% generate different forcing terms
% f ~ iid standard gaussian
forcing = zeros(num_ef,s,s);
for i = 1:num_ef
    f = randn(s,s);
    forcing(i,:,:) = f;
end
data('f') = forcing;

% generate different coeff functions
coeff = zeros(num_coeff,s,s);
for j = 1:num_coeff
    %Exponentiate it, so that a(x) > 0
    %Now a ~ Lognormal(0, C)
    %This is done so that the PDE is elliptic
    norm_a = exp(GRF(alpha, tau, s));
    coeff(j,:,:) = norm_a;
end
data('a') = coeff;

% generate solution
% size of solution is (num_coeff, num_ef, res, res)
solution = zeros(num_coeff, num_ef, s, s);
for ii = 1:num_coeff
    aa = squeeze(coeff(ii,:,:));
    for jj = 1:num_ef
        ff = squeeze(forcing(jj,:,:));
        solution(ii,jj,:,:) = solve_gwf(aa,ff);
    end
end
data('u') = solution;
filename = strcat('darcy-',num2str(num_coeff),'coeff-',num2str(num_ef), ...
           'force-gridSize',num2str(s),'.mat');
save(data,filename);
% toc;
%Generate random coefficients from N(0,C)
% norm_a = GRF(alpha, tau, s);

%Exponentiate it, so that a(x) > 0
%Now a ~ Lognormal(0, C)
%This is done so that the PDE is elliptic
% lognorm_a = exp(norm_a);

%Another way to achieve ellipticity is to threshhold the coefficients
% thresh_a = zeros(s,s);
% thresh_a(norm_a >= 0) = 12;
% thresh_a(norm_a < 0) = 4;

%Solve PDE: - div(a(x)*grad(p(x))) = f(x)
% lognorm_p = solve_gwf(lognorm_a,f);
% thresh_p = solve_gwf(thresh_a,f);