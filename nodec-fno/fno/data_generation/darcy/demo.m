%Number of grid points on [0,1]^2 
%i.e. uniform mesh with step h=1/(s-1)
tic;
s_demo = 512;

%Create mesh (only needed for plotting)
[Xdemo,Ydemo] = meshgrid(0:(1/(s_demo-1)):1);

%Parameters of covariance C = tau^(2*alpha-2)*(-Laplacian + tau^2 I)^(-alpha)
%Note that we need alpha > d/2 (here d= 2) 
%Laplacian has zero Neumann boundry
%alpha and tau control smoothness; the bigger they are, the smoother the
%function
alpha_demo = 2;
tau_demo = 3;

%Generate random coefficients from N(0,C)
norm_a_demo = GRF(alpha_demo, tau_demo, s_demo);

%Exponentiate it, so that a(x) > 0
%Now a ~ Lognormal(0, C)
%This is done so that the PDE is elliptic
lognorm_a_demo = exp(norm_a_demo);

%Another way to achieve ellipticity is to threshhold the coefficients
% thresh_a = zeros(s,s);
% thresh_a(norm_a >= 0) = 12;
% thresh_a(norm_a < 0) = 4;

%Forcing function, f(x) = 1 
f_demo = randn(s_demo,s_demo);

%Solve PDE: - div(a(x)*grad(p(x))) = f(x)
lognorm_p_demo = solve_gwf(lognorm_a_demo,f_demo);
% thresh_p = solve_gwf(thresh_a,f);
T = toc;
disp(T);
% %Plot coefficients and solutions
% subplot(2,2,1)
% surf(X,Y,lognorm_a); 
% view(2); 
% shading interp;
% colorbar;
% subplot(2,2,2)
subplot(1,1,1)
surf(Xdemo,Ydemo,lognorm_p_demo); 
view(2)
% view(2); 
% shading interp;
% colorbar;
% subplot(2,2,3)
% surf(X,Y,thresh_a); 
% view(2); 
% shading interp;
% colorbar;
% subplot(2,2,4)
% surf(X,Y,thresh_p); 
% view(2); 
% shading interp;
% colorbar;
