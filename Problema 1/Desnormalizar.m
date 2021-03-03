function [ Entrada ] = Desnormalizar( Entrada, xmax, xmin ) % o xmax e xmin foi obtido na Normaliza��o

% C�lculo das Dimens�es da Matriz de Entrada
[Linhas, Colunas] = size(Entrada);

% Desnormaliza��o de Toda a Matriz
for i=1 : Colunas
    for j=1 : Linhas
        Entrada(j,i) = (Entrada(j,i)*(xmax(i)-xmin(i)))+ xmin(i);
    end
end

end

