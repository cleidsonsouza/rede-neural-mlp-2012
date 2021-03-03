function [ Variancia ] = Validacao( W1, W2, Entrada, NumNeuronioPrimeiraCamadaEscondida, xmax, xmin )

% Obtendo algumas Informções Importantes
[NumPadroes NumEntradasPrimeiraCamada] = size(Entrada);

% Cálculo das Dimensões da Matriz de Entrada
[Linhas Colunas]= size(Entrada);

% A Saída Desejada recebe a última Coluna da Matriz de Entrada 
SaidaDesejada = Entrada(:,Colunas);

% Polarização da Última Coluna 
Entrada(:,Colunas) = -1;

for i=1 : NumPadroes
    % ------------------------ForWard------------------------%    
    % Primeira Camada Escondida  
      u1 = Entrada(i,:) * W1;                        % Saida Linear          
      y1 = sigmf(u1, [5 0]);                         % Saida Linear Ativada                        
      y1(NumNeuronioPrimeiraCamadaEscondida+1) = -1; % Polarizando...                     

    % Camada de Saída  
      u2 = y1 * W2';         % Saida Linear                                      
      y2 = sigmf(u2, [5 0]); % Saida Ativada                   
    % -------------------------------------------------------%

    SaidaAtivada(i) = y2;
end

% Normalização
SaidaAtivada = SaidaAtivada'
%[SaidaAtivada] = Desnormalizar(SaidaAtivada, xmax, xmin);
SaidaAtivada = SaidaAtivada';

% Erro Quadrático
ErroQuadratico = (SaidaDesejada' - SaidaAtivada).^2;

%Gráficos
figure
plot(ErroQuadratico);
xlabel('Época')
ylabel('Erro Quadrático')
title('Erro Quadratico de Validacao')

figure
plot(SaidaDesejada, 'r');
title('Predição do Sinal Completo')
hold on
plot(SaidaAtivada);
hold on
legend ('Saida Desejada', 'Saida da Rede')

% Imprime a Variãncia
Variancia = var(ErroQuadratico)  

end


