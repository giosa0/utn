n = 10;
E = 1100000;
h = 1;
syms x

%FORMAMOS LA MATRIZ M 
M = zeros(n);
for i = 1:n
    for j = 1:n
        if i == j
            M(i,j) = 2;
        elseif i == j-1
            M(i,j) = -1;
        elseif i == j+1
            M(i,j) = -1;
        end
        if i == 1
            M(i,j) = 0;
        elseif i == n
            M(i,j) = 0;
        end
    end
end
M(n,n) = 1;
M(1,1) = 1;

%FORMAMOS LA MATRIZ DE LOS b
b1 = zeros(n,1);
f_1=3190-210.*x;
f_2=2100-210.*x;
for i = 2:n
    if i<=8 
        b1(i,1) = eval(int((1/E)*(f_1),x,i-1,i)+int((1/E)*(f_1),x,i,i+1)); 
    elseif i>8 && i<=10
        b1(i,1) = eval(int((1/E)*(f_2),x,i-1,i)+int((1/E)*(f_2),x,i,i+1));
    end
end
b1(1,1) = 0;
b1(n,1) = 0;

%MATRIZ DE DESPLAZAMIENTOS u
u = inv(M)*b1;

%GRAFICOS
u = (u');
x = [1:1:10];
xi=[0:1/100:10];
uanalitica=(xi<=8).*((1/E)*(210*xi.^3/6-3190/2*xi.^2+12450*xi))+((xi>8)&(xi<=10)).*((1/E)*(210*xi.^3/6-2100/2*xi.^2+3730*xi+34880));
plot(xi,uanalitica);
hold on
plot(x,u)

