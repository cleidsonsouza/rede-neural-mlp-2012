%-------------------------------------------------------------------------%
%                             Apresenta��o                                %
%-------------------------------------------------------------------------%
%
% Faculdade de Ci�ncia e Tecnologia de Montes Claros
%
% Intelig�ncia Computacional
%
% Terceiro Trabalho Pr�tico 
% 
% MLP(Problema 2): Classifica��o de Padr�es
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
%                                Vari�veis                                %
% ------------------------------------------------------------------------%

NumNeuronioPrimeiraCamadaEscondida = 10;
NumNeuronioCamadaSaida             = 3;
TaxaAprendizagem                   = 0.1;
NumTreinamento                     = 2;
Precisao                           = 1e-6;


% ----------------------------------------------------------------------- %
%                             Loop Principal                              %
% ------------------------------------------------------------------------%

for i=1 : NumTreinamento
  
% Tempo para ser subtra�do para se obter o tempo real de processamento    
TempoProcessamentoInicial = cputime;    
    
% Normalizando a Entrada
%[Entrada, xmax, xmin] = Normalizar2(Entrada); 

% Treinamento
[W1, W2] = Treinamento2(NumNeuronioPrimeiraCamadaEscondida, NumNeuronioCamadaSaida, TaxaAprendizagem, Precisao, Entrada);

% Comando para desviciar o Comando 'rand'
RandStream.setDefaultStream(RandStream('mt19937ar','seed',sum(100*clock)));

% Normalizando os Testes
%[Teste] = Normalizar2(Teste);

xmax = 0;
xmin = 0;

%Valida��o
Validacao2(W1, W2, Teste, NumNeuronioPrimeiraCamadaEscondida, xmax, xmin );

% C�lcula e Imprime o d tempo de processamento 
TempoProcessamento = cputime - TempoProcessamentoInicial

end

