%-------------------------------------------------------------------------%
%                             Apresentação                                %
%-------------------------------------------------------------------------%
%
% Faculdade de Ciência e Tecnologia de Montes Claros
%
% Inteligência Computacional
%
% Terceiro Trabalho Prático 
% 
% MLP(Problema 1): Aproximação de Funções
%
% Aluno : Cleidson dos Santos Souza 
%
% Testado no Matlab R2009a 
%
%-------------------------------------------------------------------------%


% ----------------------------------------------------------------------- %
%                                 Limpeza                                 %
% ------------------------------------------------------------------------%

clear all
close all
clc

% ----------------------------------------------------------------------- %
%                             Ler do Arquivo                              %
% ------------------------------------------------------------------------%

load 'Entrada.txt';
load 'Teste.txt';

% ----------------------------------------------------------------------- %
%                                Variáveis                                %
% ------------------------------------------------------------------------%

NumNeuronioPrimeiraCamadaEscondida = 10;
NumNeuronioCamadaSaida             = 1;
TaxaAprendizagem                   = 0.1;
NumTreinamento                     = 5;
Precisao                           = 1e-6;


% ----------------------------------------------------------------------- %
%                             Loop Principal                              %
% ------------------------------------------------------------------------%

for i=1 : NumTreinamento 

% Normalizando a Entrada
%[Entrada, xmax, xmin] = Normalizar(Entrada);  

[W1, W2] = Treinamento(NumNeuronioPrimeiraCamadaEscondida, NumNeuronioCamadaSaida, TaxaAprendizagem, Precisao, Entrada);

% Comando para desviciar o Comando 'rand'
%RandStream.setDefaultStream(RandStream('mt19937ar','seed',sum(100*clock)));

% Normalizando os Testes
%[Teste] = Normalizar(Teste);

xmax = 0;
xmin = 0;

%Validação
[Variancia] = Validacao(W1, W2, Teste, NumNeuronioPrimeiraCamadaEscondida, xmax, xmin );

end

