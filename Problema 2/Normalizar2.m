function [ Entrada, xmax, xmin ] = Normalizar( Entrada )

% C�lculo das Dimens�es da Matriz de Entrada
[Linhas, Colunas] = size(Entrada);

xmax = max(Entrada);
xmin = min(Entrada);

% Normaliza��o de Toda a Matriz
for i=1 : Colunas
    for j=1 : Linhas
        Entrada(j,i) = (Entrada(j,i)-xmin(i))/(xmax(i)-xmin(i));
    end
end

end

