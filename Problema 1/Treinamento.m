function [ W1, W2 ] = Treinamento(NumNeuronioPrimeiraCamadaEscondida, NumNeuronioCamadaSaida, TaxaAprendizagem, Precisao, Entrada)

% C�lculo das Dimens�es da Matriz de Entrada
[Linha Coluna] = size(Entrada);

% A Sa�da Desejada recebe a �ltima Coluna da Matriz de Entrada 
SaidaDesejada = Entrada(:,Coluna);

% Polariza��o da �ltima Coluna da Matriz de Entrada
Entrada(:, Coluna) = -1;

% Verifica��o de Dimens�es da Entrada
[NumPadroes NumEntradasPrimeiraCamada] = size(Entrada);

% Gerando Pesos Aleat�rios p/ PrimeiraCamadaEscondida
for i = 1 : NumNeuronioPrimeiraCamadaEscondida 
    for j = 1 : NumEntradasPrimeiraCamada 
        W1(i,j) = rand;
    end
end

% Gerando Pesos Aleatorios p/ Camada de Sa�da
for i = 1 : NumNeuronioCamadaSaida 
    for j = 1 : NumNeuronioPrimeiraCamadaEscondida + 1 % Igual ao N�mero de Entradas da 2� Camada + a do Bias
        W2(i,j) = rand;
    end
end

% Transpondo a Matriz de Pesos
W1 = W1';

% Declara��o de Vari�veis
ErroQuadraticoMedio = 0;
NumTotalEpocas = 0;
ErroQuadratico = 0;
Beta = 5;
cont = 0;

% Loop Principal
while(true)  
    
      ErroQuadraticoMedioAnterior = ErroQuadraticoMedio;
    
      for i = 1 : NumPadroes % Loop at� completar todos os Padroes     
          
          % ------------------------ForWard------------------------%    
            % Primeira Camada Escondida         
              u1 = Entrada(i,:) * W1;                        % Saida Linear          
              y1 = sigmf(u1, [5 0]);                         % Saida Linear Ativada                        
              y1(NumNeuronioPrimeiraCamadaEscondida+1) = -1; % Polarizando...      
              
            % Camada de Sa�da               
              u2 = y1 * W2';          % Saida Linear                                      
              y2 = sigmf(u2, [5 0]);  % Saida Ativada                   
          % -------------------------------------------------------%                          

          %---------------------- BackWard-------------------------%      
            % Camada de Sa�da
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
      
      % Crit�rio de Parada
      if NumTotalEpocas > 1
         if(abs(ErroQuadraticoMedio - ErroQuadraticoMedioAnterior) < Precisao)
            break; 
         end   
      end           
      
end    

   % Gr�fico do Erro Quadr�tico Medio por �poca de Treinamento
   figure
   plot(ErroQuadraticoMedioPorEpoca);
   xlabel('�poca')
   ylabel('Erro Quadr�tico M�dio')
   title('Erro Quadr�tico Medio por �poca de Treinamento') 
   
   % Imprime Erro Quadr�tico M�dio
   ErroQuadraticoMedio   
   
   % Imprime o N�mero de �pocas de treinamento
   NumTotalEpocas
   
end

