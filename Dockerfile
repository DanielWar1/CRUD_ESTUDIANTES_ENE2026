# Usamos alpine como tenías, pero instalamos librerías de postgres
FROM python:3.11-alpine

# Instalamos dependencias para psycopg2 (necesarias en Alpine)
RUN apk add --no-cache postgresql-dev gcc python3-dev musl-dev

WORKDIR /app

# Copiamos requerimientos e instalamos
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiamos el resto del código
COPY . .

# Exponemos el puerto
EXPOSE 5000

# Comando de arranque (usando gunicorn como tenías en tu imagen)
# "app:app" significa: archivo app.py, objeto app
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]