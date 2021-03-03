function [ W1, W2 ] = Treinamento2(NumNeuronioPrimeiraCamadaEscondida, NumNeuronioCamadaSaida, TaxaAprendizagem, Precisao, IO)

% Obetendo a Entrada e a Saída Desejada
for i=1 : 4
    Entrada(:,i) = IO(:,i);    
    if i<4
       SaidaDesejada(:,i) = IO(:,i+4);
    end
end

% Cálculo das Dimensões da Matriz de Entrada
[Linha Coluna] = size(Entrada);

% Polarização da Última Coluna
Entrada(:, Coluna+1) = -1;

% Obtendo algumas Informções Importantes
[NumPadroes NumEntradasPrimeiraCamada] = size(Entrada);

% Gerando Pesos Aleatorios p/ PrimeiraCamadaEscondida
for i = 1 : NumNeuronioPrimeiraCamadaEscondida 
    for j = 1 : NumEntradasPrimeiraCamada 
        W1(i,j) = rand;
    end
end

% Gerando Pesos Aleatorios p/ Camada de Saída
for i = 1 : NumNeuronioCamadaSaida 
    for j = 1 : NumNeuronioPrimeiraCamadaEscondida + 1 % Igual ao Numero de Entradas da 2º Camada + o Bias
        W2(i,j) = rand;
    end
end

% Transpondo a Matriz de Pesos
W1 = W1';

% Declaração de Variáveis
ErroQuadraticoMedio = 0;
NumTotalEpocas = 0;
ErroQuadratico = 0;
Beta = 1;
cont = 0;

% Loop Principal
while(true)  
    
      ErroQuadraticoMedioAnterior = ErroQuadraticoMedio;
    
      for i = 1 : NumPadroes % Loop até completar todos os Padroes     
          
          % ------------------------ForWard----------------------- %    
            % Primeira Camada Escondida             
              u1 = Entrada(i,:) * W1;                        % Saida Linear          
              y1 = sigmf(u1, [Beta 0]);                      % Saida Linear Ativada                        
              y1(NumNeuronioPrimeiraCamadaEscondida+1) = -1; % Polarizando...                     

            % Camada de Saída               
              u2 = y1 * W2';             % Saida Linear                                      
              y2 = sigmf(u2, [Beta 0]);  % Saida Ativada                   
          % ------------------------------------------------------ % 
          
          % --------------------- BackWard------------------------ %      
            % Camada de Saída
              ErroQuadratico(i) = 0;
              for q=1 : NumNeuronioCamadaSaida % 3                     
                  Erro = (SaidaDesejada(i,q) - y2(q));              
                  ErroQuadratico(i) = ErroQuadratico(i) + Erro^2;              
                  GradienteLocal(q) = Erro * (exp(-Beta*u2(q))/(1 + exp(-Beta*u2(q)))^2);               
                  W2(q,:) = W2(q,:) + TaxaAprendizagem * GradienteLocal(q) * y1;   
              end         
              ErroQuadratico(i) = (ErroQuadratico(i)/ NumNeuronioCamadaSaida); % Média Erro Quadratico
            
              % Primeira Camada Escondida                 
              for k=1 : NumNeuronioPrimeiraCamadaEscondida % 15
                  GradienteLocal2(k) = 0;
                  for z=1 : NumNeuronioCamadaSaida                  
                      GradienteLocal2(k) = GradienteLocal2(k) + GradienteLocal(z) * W2(z,k);
                  end
                  GradienteLocal2(k) = GradienteLocal2(k) * (exp(-Beta*u1(k))/(1 + exp(-Beta*u1(k)))^2);
                  W1=W1';    
                  W1(k,:) = W1(k,:) + TaxaAprendizagem * GradienteLocal2(k) * Entrada(k,:);                             
                  W1=W1';               
              end
          % ------------------------------------------------------ %         
      end    
      
      NumTotalEpocas = NumTotalEpocas + 1;
      
      ErroQuadraticoMedio = mean(ErroQuadratico);  
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
   
   % Imprime o Número de Épocas de reinamento
   NumTotalEpocas
   
   % Imprime Erro Quadrático Médio
   ErroQuadraticoMedio   
   
end

