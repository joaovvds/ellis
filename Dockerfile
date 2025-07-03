# Use uma imagem oficial do Python como imagem base. A versão slim é um bom equilíbrio entre tamanho e compatibilidade.
FROM python:3.13.5-alpine3.22

# Define o diretório de trabalho no contêiner
WORKDIR /app

# Copia o arquivo de dependências para o diretório de trabalho.
# Isso é feito em um passo separado para aproveitar o cache de camadas do Docker.
COPY requirements.txt .

# Instala os pacotes necessários especificados no requirements.txt
# --no-cache-dir reduz o tamanho da imagem
# --upgrade pip garante que estamos usando a versão mais recente do pip
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho
COPY . .

# Expõe a porta em que a aplicação é executada
EXPOSE 8000

# Comando para executar a aplicação quando o contêiner iniciar.
# Use 0.0.0.0 para torná-lo acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]