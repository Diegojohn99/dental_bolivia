# 🦷 Dental Bolivia - Guía de Despliegue en Render

## 📋 Preparación para Despliegue

### 1. Repositorio Git
Primero, inicializa y sube tu código a GitHub:

```bash
git init
git add .
git commit -m "Initial commit - Dental Bolivia system"
git branch -M main
git remote add origin https://github.com/tu-usuario/dental-bolivia.git
git push -u origin main
```

### 2. Crear cuenta en Render
- Ve a [render.com](https://render.com)
- Crea una cuenta gratuita
- Conecta tu cuenta de GitHub

## 🚀 Despliegue en Render

### Paso 1: Crear Base de Datos PostgreSQL
1. En el dashboard de Render, haz clic en "New +"
2. Selecciona "PostgreSQL"
3. Configuración:
   - **Name**: `dental-bolivia-db`
   - **Database**: `dental_bolivia_production`
   - **User**: `dental_bolivia_user`
   - **Plan**: Free
4. Haz clic en "Create Database"
5. **Guarda la URL de conexión** que aparecerá

### Paso 2: Crear Web Service
1. Haz clic en "New +" → "Web Service"
2. Conecta tu repositorio de GitHub
3. Configuración:
   - **Name**: `dental-bolivia-web`
   - **Runtime**: Ruby
   - **Build Command**: `./bin/render-build.sh`
   - **Start Command**: `bundle exec puma -C config/puma.rb`
   - **Plan**: Free

### Paso 3: Variables de Entorno
En la sección "Environment Variables", añade:

#### Variables Requeridas:
```
DATABASE_URL = [URL de tu base de datos PostgreSQL]
RAILS_ENV = production
BUNDLE_WITHOUT = development:test
RAILS_LOG_TO_STDOUT = enabled
RAILS_SERVE_STATIC_FILES = enabled
WEB_CONCURRENCY = 1
```

#### Variables de Seguridad (Render las genera automáticamente):
```
SECRET_KEY_BASE = [Render genera automáticamente]
RAILS_MASTER_KEY = [Render genera automáticamente]
ACTIVE_RECORD_ENCRYPTION_PRIMARY_KEY = [Render genera automáticamente]
ACTIVE_RECORD_ENCRYPTION_DETERMINISTIC_KEY = [Render genera automáticamente]
ACTIVE_RECORD_ENCRYPTION_KEY_DERIVATION_SALT = [Render genera automáticamente]
```

#### Variables Opcionales (configurar después):
```
# Email (opcional)
DEFAULT_FROM_EMAIL = noreply@dentalbolivia.com
SMTP_ADDRESS = smtp.gmail.com
SMTP_PORT = 587
SMTP_DOMAIN = dentalbolivia.com
SMTP_USERNAME = tu-email@gmail.com
SMTP_PASSWORD = tu-app-password

# Twilio SMS (opcional)
TWILIO_ACCOUNT_SID = tu-account-sid
TWILIO_AUTH_TOKEN = tu-auth-token
TWILIO_FROM_NUMBER = +1234567890

# Redis (opcional, para mejor rendimiento)
REDIS_URL = redis://tu-redis-url
```

### Paso 4: Desplegar
1. Haz clic en "Create Web Service"
2. Render comenzará el proceso de build automáticamente
3. El proceso tomará 5-10 minutos la primera vez

## 📊 Post-Despliegue

### Verificar el Despliegue
1. Una vez completado, visita la URL proporcionada por Render
2. Deberías ver la página de inicio de Dental Bolivia
3. Prueba el login con las credenciales por defecto:
   - **Admin**: admin@dentalbolivia.com / password123
   - **Dentista**: carlos.mendoza@dentalbolivia.com / password123

### Configuraciones Adicionales

#### 1. Dominio Personalizado (Opcional)
- En Render, ve a Settings → Custom Domains
- Añade tu dominio personalizado
- Configura los DNS según las instrucciones

#### 2. SSL/HTTPS
- Render proporciona SSL automáticamente
- No requiere configuración adicional

#### 3. Monitoreo
- Render proporciona logs automáticos
- Ve a "Logs" para monitorear la aplicación

## 🔧 Comandos Útiles

### Ejecutar comandos en producción:
```bash
# Acceder a la consola Rails
render shell dental-bolivia-web
bundle exec rails console

# Ver logs
render logs dental-bolivia-web

# Reiniciar servicio
render restart dental-bolivia-web
```

### Ejecutar migraciones manualmente:
```bash
render shell dental-bolivia-web
bundle exec rails db:migrate
```

## 🚨 Solución de Problemas

### Error de Build
- Revisa los logs de build en Render
- Verifica que todas las gemas estén en el Gemfile
- Asegúrate de que `bin/render-build.sh` sea ejecutable

### Error de Base de Datos
- Verifica que `DATABASE_URL` esté configurada correctamente
- Asegúrate de que la base de datos PostgreSQL esté activa

### Error de Variables de Entorno
- Verifica que todas las variables requeridas estén configuradas
- Reinicia el servicio después de cambiar variables

## 📱 URLs Importantes

Una vez desplegado, tendrás acceso a:

- **Página Principal**: `https://tu-app.onrender.com`
- **Panel Admin**: `https://tu-app.onrender.com/users/sign_in`
- **Reserva Pública**: `https://tu-app.onrender.com/public/booking/new`
- **API Health Check**: `https://tu-app.onrender.com/up`

## 🔐 Seguridad en Producción

### Cambiar Contraseñas por Defecto
Después del despliegue, cambia inmediatamente las contraseñas por defecto:

1. Inicia sesión como admin
2. Ve a la consola Rails en Render
3. Ejecuta:
```ruby
User.find_by(email: 'admin@dentalbolivia.com').update(password: 'nueva-contraseña-segura')
```

### Configurar Email y SMS
- Configura las variables de entorno para email y SMS
- Prueba el envío de recordatorios

## 📞 Soporte

Si tienes problemas con el despliegue:
1. Revisa los logs en Render
2. Verifica la configuración de variables de entorno
3. Consulta la documentación de Render: [render.com/docs](https://render.com/docs)

---

¡Tu sistema de clínica dental ya está listo para producción! 🎉
