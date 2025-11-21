# 🚀 DENTAL BOLIVIA - GUÍA DE DESPLIEGUE EN RENDER

## 📋 PREPARACIÓN PARA DESPLIEGUE

### 1. Repositorio Git
✅ **Completado** - Código ya está en GitHub: https://github.com/Diegojohn99/dental_bolivia.git

### 2. Crear cuenta en Render
- Ve a [render.com](https://render.com)
- Crea una cuenta gratuita
- Conecta tu cuenta de GitHub

## 🚀 DESPLIEGUE EN RENDER

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
DATABASE_URL = [URL de tu base de datos PostgreSQL - Render la genera automáticamente]
RAILS_ENV = production
RACK_ENV = production
BUNDLE_WITHOUT = development:test
RAILS_LOG_TO_STDOUT = 1
RAILS_SERVE_STATIC_FILES = 1
RAILS_LOG_LEVEL = warn
WEB_CONCURRENCY = 2
```

#### Variables de Seguridad:
```
# Claves de cifrado (usar las de tu .env local)
ACTIVE_RECORD_ENCRYPTION_PRIMARY_KEY = [Tu clave del .env]
ACTIVE_RECORD_ENCRYPTION_DETERMINISTIC_KEY = [Tu clave del .env]
ACTIVE_RECORD_ENCRYPTION_KEY_DERIVATION_SALT = [Tu clave del .env]

# Claves principales (Render las genera automáticamente)
SECRET_KEY_BASE = [Render genera automáticamente]
RAILS_MASTER_KEY = [Render genera automáticamente]
```

#### Variables de Email:
```
DEFAULT_FROM_EMAIL = tu-email@gmail.com
SMTP_ADDRESS = smtp.gmail.com
SMTP_PORT = 587
SMTP_DOMAIN = gmail.com
SMTP_USERNAME = tu-email@gmail.com
SMTP_PASSWORD = tu-app-password-gmail
SMTP_AUTH = plain
SMTP_ENABLE_STARTTLS_AUTO = true
```

#### Variables de Twilio SMS:
```
TWILIO_ACCOUNT_SID = tu-twilio-account-sid
TWILIO_AUTH_TOKEN = tu-twilio-auth-token
TWILIO_FROM_NUMBER = tu-numero-twilio
```

### Paso 4: Desplegar
1. Haz clic en "Create Web Service"
2. Render comenzará el proceso de build automáticamente
3. El proceso tomará 5-10 minutos la primera vez

## 📊 POST-DESPLIEGUE

### Verificar el Despliegue
1. Una vez completado, visita la URL proporcionada por Render
2. Deberías ver la página de inicio de Dental Bolivia
3. Prueba el login con las credenciales por defecto:
   - **Admin**: admin@dentalbolivia.com / password123
   - **Dentista**: carlos.mendoza@dentalbolivia.com / password123

### URLs de tu aplicación:
- **Página Principal**: `https://dental-bolivia-web.onrender.com`
- **Panel Admin**: `https://dental-bolivia-web.onrender.com/users/sign_in`
- **Reserva Pública**: `https://dental-bolivia-web.onrender.com/public/booking/new`

### Credenciales por defecto:
- **Admin**: admin@dentalbolivia.com / password123
- **Dentista 1**: carlos.mendoza@dentalbolivia.com / password123
- **Dentista 2**: ana.rodriguez@dentalbolivia.com / password123
- **Dentista 3**: luis.vargas@dentalbolivia.com / password123
- **Recepcionista**: recepcion@dentalbolivia.com / password123

## 🔧 COMANDOS ÚTILES

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

## 🚨 SOLUCIÓN DE PROBLEMAS

### Error de Build
- Revisa los logs de build en Render
- Verifica que todas las gemas estén en el Gemfile
- Asegúrate de que `bin/render-build.sh` sea ejecutable

### Error de Base de Datos
- Verifica que `DATABASE_URL` esté configurada correctamente
- Asegúrate de que la base de datos PostgreSQL esté activa

## 🔐 SEGURIDAD EN PRODUCCIÓN

### Cambiar Contraseñas por Defecto
Después del despliegue, cambia inmediatamente las contraseñas por defecto:

1. Inicia sesión como admin
2. Ve a la consola Rails en Render
3. Ejecuta:
```ruby
User.find_by(email: 'admin@dentalbolivia.com').update(password: 'nueva-contraseña-segura')
```

---

¡Tu sistema de clínica dental ya está listo para producción! 🎉
