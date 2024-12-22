# Etapa 1: Compilación
FROM node:20.10.0 AS builder

# Establecer el directorio de trabajo en el contenedor
WORKDIR /app

# Copiar los archivos necesarios para instalar dependencias
COPY package.json package-lock.json ./

# Instalar dependencias
RUN npm install

# Copiar el resto de los archivos del proyecto
COPY . .

# Construir la aplicación para producción
RUN npm run build -- --configuration=production

# Etapa 2: Servir la aplicación con NGINX
FROM nginx:1.25

# Copiar los archivos compilados desde la etapa de construcción
COPY --from=builder /app/dist/my-angular-app/browser /usr/share/nginx/html

# Copiar configuración personalizada de NGINX (opcional)
# Si necesitas configuraciones específicas, crea un archivo nginx.conf y descomenta la siguiente línea:
# COPY nginx.conf /etc/nginx/nginx.conf

# Exponer el puerto 80
EXPOSE 80

# Iniciar NGINX
CMD ["nginx", "-g", "daemon off;"]