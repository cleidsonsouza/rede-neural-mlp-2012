function [ Entrada, xmax, xmin ] = Normalizar( Entrada )

% Cálculo das Dimensões da Matriz de Entrada
[Linhas, Colunas] = size(Entrada);

xmax = max(Entrada);
xmin = min(Entrada);

% Normalização de Toda a Matriz
for i=1 : Colunas
    for j=1 : Linhas
        Entrada(j,i) = (Entrada(j,i)-xmin(i))/(xmax(i)-xmin(i));
    end
end

end

