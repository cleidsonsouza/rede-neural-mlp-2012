function [ W1, W2 ] = Treinamento(NumNeuronioPrimeiraCamadaEscondida, NumNeuronioCamadaSaida, TaxaAprendizagem, Precisao, Entrada)

% Cálculo das Dimensões da Matriz de Entrada
[Linha Coluna] = size(Entrada);

% A Saída Desejada recebe a última Coluna da Matriz de Entrada 
SaidaDesejada = Entrada(:,Coluna);

% Polarização da Última Coluna da Matriz de Entrada
Entrada(:, Coluna) = -1;

% Verificação de Dimensões da Entrada
[NumPadroes NumEntradasPrimeiraCamada] = size(Entrada);

% Gerando Pesos Aleatórios p/ PrimeiraCamadaEscondida
for i = 1 : NumNeuronioPrimeiraCamadaEscondida 
    for j = 1 : NumEntradasPrimeiraCamada 
        W1(i,j) = rand;
    end
end

% Gerando Pesos Aleatorios p/ Camada de Saída
for i = 1 : NumNeuronioCamadaSaida 
    for j = 1 : NumNeuronioPrimeiraCamadaEscondida + 1 % Igual ao Número de Entradas da 2º Camada + a do Bias
        W2(i,j) = rand;
    end
end

% Transpondo a Matriz de Pesos
W1 = W1';

% Declaração de Variáveis
ErroQuadraticoMedio = 0;
NumTotalEpocas = 0;
ErroQuadratico = 0;
Beta = 5;
cont = 0;

% Loop Principal
while(true)  
    
      ErroQuadraticoMedioAnterior = ErroQuadraticoMedio;
    
      for i = 1 : NumPadroes % Loop até completar todos os Padroes     
          
          % ------------------------ForWard------------------------%    
            % Primeira Camada Escondida         
              u1 = Entrada(i,:) * W1;                        % Saida Linear          
              y1 = sigmf(u1, [5 0]);                         % Saida Linear Ativada                        
              y1(NumNeuronioPrimeiraCamadaEscondida+1) = -1; % Polarizando...      
              
            % Camada de Saída               
              u2 = y1 * W2';          % Saida Linear                                      
              y2 = sigmf(u2, [5 0]);  % Saida Ativada                   
          % -------------------------------------------------------%                          

          %---------------------- BackWard-------------------------%      
            % Camada de Saída
              Erro = (SaidaDesejada(i) - y2);
              ErroQuadratico(i) = Erro^2;           
              GradienteLocal = Erro * (exp(-Beta*u2)/(1 + exp(-Beta*u2))^2);           
              W2 = W2 + TaxaAprendizagem * GradienteLocal * y1;                         

            % Primeira Camada Escondida   
              for x=1 : NumNeuronioPrimeiraCamadaEscondida              
                  W1=W1';                     
                  GradienteLocal2 = GradienteLocal * W2(x) * (exp(-Beta*u1(x))/(1 + exp(-Beta*u1(x)))^2);
                  W1(x,:) = W1(x,:) + TaxaAprendizagem * GradienteLocal2 *  Entrada(i,:);
                  W1=W1';             
              end          
          %--------------------------------------------------------%         
      end            
      
      NumTotalEpocas = NumTotalEpocas + 1;
      
      ErroQuadraticoMedio = mean(abs(ErroQuadratico));  
      ErroQuadraticoMedioPorEpoca(NumTotalEpocas) = ErroQuadraticoMedio;
      
      % Critério de Parada
      if NumTotalEpocas > 1
         if(abs(ErroQuadraticoMedio - ErroQuadraticoMedioAnterior) < Precisao)
            break; 
         end   
      end           
      
end    

   % Gráfico do Erro Quadrático Medio por Época de Treinamento
   figure
   plot(ErroQuadraticoMedioPorEpoca);
   xlabel('Época')
   ylabel('Erro Quadrático Médio')
   title('Erro Quadrático Medio por Época de Treinamento') 
   
   % Imprime Erro Quadrático Médio
   ErroQuadraticoMedio   
   
   % Imprime o Número de Épocas de treinamento
   NumTotalEpocas
   
end

