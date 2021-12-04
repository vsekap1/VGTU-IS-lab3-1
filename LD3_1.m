%% Trecias laboratorinis darbas
% Spindulio tipo baziniu funkciju naudojimas perceptorno sudarymui
% Atliko KTFM-21 Grupes studentas: Vsevolod Kapustin
clear all
clc

%% Perceptrono struktura
% Pasleptas sluoksnis - 2 neuronai su RBF aktyvavimu
% Isejimo sluosksnis - 1 neuronas su tiesiniu aktyvavimu

%% Iejimo vektoriaus aprasymas
x = 0.1:1/22:1;
y = isejimo_funkcija(x);


%% RBF sluoksnio skaiciavimas
% 1 neurono isejimas (iejimas skaiciuojamas be svoriu)
% neuronu parametrai
c1 = randn(1);
c2 = randn(1);
r1 = randn(1);
r2 = randn(1);

f1 = rbf_aktyvavimas(x, c1, r1);
f2 = rbf_aktyvavimas(x, c2, r2);

% neuronu aktyvavimo funkcijos braizymas
figure(1)
plot(x, f1, '--b', x, f2, '--r');
title("Spindulio funkcijos")
legend("Pirmas nauronas", "Antras neuronas")

%% Isejimo sluoksnio skaiciavimas
% Generuojami atsitiktiniai svoriai ir neuronu pralaidos koeficientai
w1 = [randn(1) randn(1) randn(1) randn(1) randn(1) randn(1)...
    randn(1) randn(1) randn(1) randn(1) randn(1) randn(1) randn(1) ...
    randn(1) randn(1) randn(1) randn(1) randn(1) randn(1) randn(1)];
w2 = [randn(1) randn(1) randn(1) randn(1) randn(1) randn(1)...
    randn(1) randn(1) randn(1) randn(1) randn(1) randn(1) randn(1) ...
    randn(1) randn(1) randn(1) randn(1) randn(1) randn(1) randn(1)];
b = [randn(1) randn(1) randn(1) randn(1) randn(1) randn(1)...
    randn(1) randn(1) randn(1) randn(1) randn(1) randn(1) randn(1) ...
    randn(1) randn(1) randn(1) randn(1) randn(1) randn(1) randn(1)];

% isejimo neurono svoriu funkcija
v = f1.*w1 + f2.*w2 + b;

% Isejimo neurono aktyvavimo funkcija -- tiesine

yy = v;
% isejimo funkcijos braizymas
figure(2)
plot(x, yy, '*r-', x, y, '*b-');

% Skaiciojamas klaidu vektorius
hold on
e = y - yy

e(1)

%% Perceptrono mokymas, vykdomas kiekvienai isejimo vertei atskirai

miu = 0.1;

    miu = 0.1;
 for n = 1 : length(e)
    while 1
        
        
        jx1(n) = x(n) - c1;
        jx2(n) = x(n) - c2;
        
        
        % Tikriname, kuris is reiksmiu artimiausias centro
        if jx1(n) > jx2(n)
            jx(n) = jx2(n);
        else
            jx(n) = jx1(n);
        end
        
        c1 = c1 + miu*(x(n) - c1)
        % Spindulio aktyvavimo funkcija
        
        f1(1) = rbf_aktyvavimas(x(1), c1, r1);
        f2(1) = rbf_aktyvavimas(x(1), c2, r2);
        
        % Atnajinami svoriai ir isejimo perceptrono "bias" naudojant mokymo eile miu = 0.1
        w1(n)= w1(n) + miu*e(n)*x(n);
        w2(n)= w2(n) + miu*e(n)*x(n);
        b(n) = b(n) + miu*e(n);
        v(n) = f1(n)*w1(n) + f2(n)*w2(n) + b(n);
        yy(n) = v(n);
        e(n)=y(n)-yy(n);
        e(n)
        plot(x(n), yy(n), '*r');
        if e(n) < 1e-10;
            if e(n) > -1e-10
                break
            end
        end
    end
 end
 
 
%% Isejimo funkcija
function y = isejimo_funkcija(x)
    y = ((1 + 0.6*sin(2*pi*x/0.7)) + 0.3*sin(2*pi*x))/2;
end

%% Spindulio tipo funkcija
function f = rbf_aktyvavimas(x, c, r)
% x - iejimo vektorius
% c - centro parametras
% r - spindulys
    f = exp(-(x-c).^2/(2*r.^2));
end