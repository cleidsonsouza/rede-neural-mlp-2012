function [ W1, W2 ] = Treinamento2(NumNeuronioPrimeiraCamadaEscondida, NumNeuronioCamadaSaida, TaxaAprendizagem, Precisao, IO)

% Obetendo a Entrada e a Sa�da Desejada
for i=1 : 4
    Entrada(:,i) = IO(:,i);    
    if i<4
       SaidaDesejada(:,i) = IO(:,i+4);
    end
end

% C�lculo das Dimens�es da Matriz de Entrada
[Linha Coluna] = size(Entrada);

% Polariza��o da �ltima Coluna
Entrada(:, Coluna+1) = -1;

% Obtendo algumas Inform��es Importantes
[NumPadroes NumEntradasPrimeiraCamada] = size(Entrada);

% Gerando Pesos Aleatorios p/ PrimeiraCamadaEscondida
for i = 1 : NumNeuronioPrimeiraCamadaEscondida 
    for j = 1 : NumEntradasPrimeiraCamada 
        W1(i,j) = rand;
    end
end

% Gerando Pesos Aleatorios p/ Camada de Sa�da
for i = 1 : NumNeuronioCamadaSaida 
    for j = 1 : NumNeuronioPrimeiraCamadaEscondida + 1 % Igual ao Numero de Entradas da 2� Camada + o Bias
        W2(i,j) = rand;
    end
end

% Transpondo a Matriz de Pesos
W1 = W1';

% Declara��o de Vari�veis
ErroQuadraticoMedio = 0;
NumTotalEpocas = 0;
ErroQuadratico = 0;
Beta = 1;
cont = 0;

% Loop Principal
while(true)  
    
      ErroQuadraticoMedioAnterior = ErroQuadraticoMedio;
    
      for i = 1 : NumPadroes % Loop at� completar todos os Padroes     
          
          % ------------------------ForWard----------------------- %    
            % Primeira Camada Escondida             
              u1 = Entrada(i,:) * W1;                        % Saida Linear          
              y1 = sigmf(u1, [Beta 0]);                      % Saida Linear Ativada                        
              y1(NumNeuronioPrimeiraCamadaEscondida+1) = -1; % Polarizando...                     

            % Camada de Sa�da               
              u2 = y1 * W2';             % Saida Linear                                      
              y2 = sigmf(u2, [Beta 0]);  % Saida Ativada                   
          % ------------------------------------------------------ % 
          
          % --------------------- BackWard------------------------ %      
            % Camada de Sa�da
              ErroQuadratico(i) = 0;
              for q=1 : NumNeuronioCamadaSaida % 3                     
                  Erro = (SaidaDesejada(i,q) - y2(q));              
                  ErroQuadratico(i) = ErroQuadratico(i) + Erro^2;              
                  GradienteLocal(q) = Erro * (exp(-Beta*u2(q))/(1 + exp(-Beta*u2(q)))^2);               
                  W2(q,:) = W2(q,:) + TaxaAprendizagem * GradienteLocal(q) * y1;   
              end         
              ErroQuadratico(i) = (ErroQuadratico(i)/ NumNeuronioCamadaSaida); % M�dia Erro Quadratico
            
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
   
   % Imprime o N�mero de �pocas de reinamento
   NumTotalEpocas
   
   % Imprime Erro Quadr�tico M�dio
   ErroQuadraticoMedio   
   
end

