function [ Variancia ] = Validacao( W1, W2, Entrada, NumNeuronioPrimeiraCamadaEscondida, xmax, xmin )

% Obtendo algumas Inform��es Importantes
[NumPadroes NumEntradasPrimeiraCamada] = size(Entrada);

% C�lculo das Dimens�es da Matriz de Entrada
[Linhas Colunas]= size(Entrada);

% A Sa�da Desejada recebe a �ltima Coluna da Matriz de Entrada 
SaidaDesejada = Entrada(:,Colunas);

% Polariza��o da �ltima Coluna 
Entrada(:,Colunas) = -1;

for i=1 : NumPadroes
    % ------------------------ForWard------------------------%    
    % Primeira Camada Escondida  
      u1 = Entrada(i,:) * W1;                        % Saida Linear          
      y1 = sigmf(u1, [5 0]);                         % Saida Linear Ativada                        
      y1(NumNeuronioPrimeiraCamadaEscondida+1) = -1; % Polarizando...                     

    % Camada de Sa�da  
      u2 = y1 * W2';         % Saida Linear                                      
      y2 = sigmf(u2, [5 0]); % Saida Ativada                   
    % -------------------------------------------------------%

    SaidaAtivada(i) = y2;
end

% Normaliza��o
SaidaAtivada = SaidaAtivada'
%[SaidaAtivada] = Desnormalizar(SaidaAtivada, xmax, xmin);
SaidaAtivada = SaidaAtivada';

% Erro Quadr�tico
ErroQuadratico = (SaidaDesejada' - SaidaAtivada).^2;

%Gr�ficos
figure
plot(ErroQuadratico);
xlabel('�poca')
ylabel('Erro Quadr�tico')
title('Erro Quadratico de Validacao')

figure
plot(SaidaDesejada, 'r');
title('Predi��o do Sinal Completo')
hold on
plot(SaidaAtivada);
hold on
legend ('Saida Desejada', 'Saida da Rede')

% Imprime a Vari�ncia
Variancia = var(ErroQuadratico)  

end


