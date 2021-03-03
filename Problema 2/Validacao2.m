function [ Acerto ] = Validacao2( W1, W2, IO, NumNeuronioPrimeiraCamada, xmax, xmin )

% Obetendo a Entrada e a Saída Desejada
for i=1 : 4
    EntradaInicial(:,i) = IO(:,i);    
    if i<4
       SaidaDesejadaInicial(:,i) = IO(:,i+4);
    end
end

% Obtendo Dimensões da Matriz de Entrada
[Linhas Colunas]= size(IO);

% Organizando a Matriz de Entrada Aleatoriamente
x = randperm(Linhas);
for z=1 : Linhas
    Entrada(z,:) = EntradaInicial(x(z),:);
    SaidaDesejada(z,:) = SaidaDesejadaInicial(x(z),:);
end    

% Obtendo algumas Informções Importantes
[NumPadroes NumEntradasPrimeiraCamada] = size(Entrada);

% Obtendo Dimensões da Matriz de Entrada
[Linhas Colunas]= size(Entrada);

% Polarização da última Coluna 
Entrada(:,Colunas+1) = -1;

for i=1 : NumPadroes
    % ------------------------ForWard------------------------%    
    % Camada 1 - Camada Entrada  
      u1 = Entrada(i,:) * W1;               % Saida Linear          
      y1 = sigmf(u1, [1 0]);                % Saida Linear Ativada                        
      y1(NumNeuronioPrimeiraCamada+1) = -1; % Polarizando...                     

    % Camada 2 - Camada Saída  
      u2 = y1 * W2';         % Saida Linear                                      
      y2 = sigmf(u2, [1 0]); % Saida Ativada                   
    % -------------------------------------------------------%

    SaidaAtivada(i,:) = y2;
end

% Normalização
%[SaidaAtivada] = Desnormalizar2(SaidaAtivada, xmax, xmin);

% Arredondamento da Saída para Verificar a Porcentagem de Acertos
SaidaAtivada = round(SaidaAtivada)

% Declaração de Variáveis
Acerto = 0;
Erro = 0;

% Obtendo o Número de Linhas e Colunas das Saídas Desejadas
[Linha Coluna] = size(SaidaDesejada);

% Verificação da Quantidade de Acertos e Erros
for i=1 : Linha
    for j=1 : Coluna
        if(SaidaAtivada(i,j)==SaidaDesejada(i,j))
           Acerto = Acerto + 1;
        else
           Erro = Erro + 1;           
        end  
    end
end

% Cálculo e Impressão da Porcentagem de Acertos e Erros
PorcentagemAcerto = (Acerto * 100) / (Linha*Coluna)
PorcentagemErro   = 100 - PorcentagemAcerto

end


