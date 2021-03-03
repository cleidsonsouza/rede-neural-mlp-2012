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
% MLP(Problema 2): Classificação de Padrões
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
NumNeuronioCamadaSaida             = 3;
TaxaAprendizagem                   = 0.1;
NumTreinamento                     = 2;
Precisao                           = 1e-6;


% ----------------------------------------------------------------------- %
%                             Loop Principal                              %
% ------------------------------------------------------------------------%

for i=1 : NumTreinamento
  
% Tempo para ser subtraído para se obter o tempo real de processamento    
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

%Validação
Validacao2(W1, W2, Teste, NumNeuronioPrimeiraCamadaEscondida, xmax, xmin );

% Cálcula e Imprime o d tempo de processamento 
TempoProcessamento = cputime - TempoProcessamentoInicial

end

