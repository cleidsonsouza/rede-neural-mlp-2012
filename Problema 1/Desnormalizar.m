function [ Entrada ] = Desnormalizar( Entrada, xmax, xmin ) % o xmax e xmin foi obtido na Normalização

% Cálculo das Dimensões da Matriz de Entrada
[Linhas, Colunas] = size(Entrada);

% Desnormalização de Toda a Matriz
for i=1 : Colunas
    for j=1 : Linhas
        Entrada(j,i) = (Entrada(j,i)*(xmax(i)-xmin(i)))+ xmin(i);
    end
end

end

